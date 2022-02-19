import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:klinik/core/storage.dart';
import 'package:klinik/models/account.dart';
import 'package:klinik/models/authorize_result.dart';

FirebaseApp firebaseApp = Firebase.apps.single;
FirebaseAuth auth = Auth.initial();

class Auth {
  static Future<FirebaseApp> initFirebaseApp() async {
    FirebaseApp result = await Firebase.initializeApp();
    return result;
  }

  static FirebaseAuth initial() {
    return auth = FirebaseAuth.instanceFor(app: firebaseApp);
  }

  static Future<AuthorizeResult?> doLogin(String email, String password) async {
    Account account;

    await storage.clear();

    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      var token = await user!.getIdToken();
      print('\n\nID TOKEN : $token\n\n');

      // Auth().accessToken = idToken;
      await storage.setItem('accesstoken', token);

      account = Account(user.uid, user.displayName!, user.email!);

      var accData = {
        "user_id": account.userId,
        "full_name": account.fullName,
        "email": account.email
      };

      //-------------------------------------------------->>>         PUT data to local.
      await storage.setItem('currentUser', accData);

      return AuthorizeResult(
        account: account,
        message: 'Logging In',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AuthorizeResult(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return AuthorizeResult(
          message: 'Wrong password provided for that user.',
        );
      } else {
        return AuthorizeResult(message: e.message);
      }
    } catch (e) {
      return AuthorizeResult(
        message: e.toString(),
      );
    }
  }

  static Future<AuthorizeResult?> doRegister(
    String email,
    String password,
    String fullName,
    String phoneNum,
  ) async {
    String? errorMessage = "";

    try {
      UserCredential? userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("USER CREDENTIAL : $userCredential");

      User? user = userCredential.user;

      await user!.updateDisplayName(fullName);
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
      );

      await user.reload();

      user.sendEmailVerification();

      return AuthorizeResult(message: 'Register Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        return AuthorizeResult(message: errorMessage);
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';

        return AuthorizeResult(message: errorMessage);
      } else {
        errorMessage = e.message;
        return AuthorizeResult(message: errorMessage);
      }
    } catch (e) {
      errorMessage = e.toString();
      return AuthorizeResult(message: errorMessage);
    }
  }

  static Future doLogout() async {
    await auth.signOut();
    await storage.clear();
  }

  ///GET user info from local.
  static Future<Account> getMeInfo() async {
    Map<String, dynamic> user = await storage.getItem('currentUser');
    print("USER [GET ME INFO] : $user");
    print("MAP [GET ME INFO] : ${user['user_id']}");
    return Account.fromMap(user);
  }

  ///Check for the Users has accessToken or not.
  static Future<bool> hasAccessToken() async {
    String? token = await getAccessToken();
    bool has = false;
    if (token != null) {
      return has = true;
    }
    return has;
  }

  ///Get the newest `token`.
  static Future<String?> getAccessToken() async {
    User? user = auth.currentUser;
    if (user != null) {
      String? currentToken = await user.getIdToken(true);

      if (currentToken.isNotEmpty) {
        var token = storage.getItem('accessToken');
        if (currentToken != token) {
          await storage.setItem('accessToken', currentToken);
          return currentToken;
        } else {
          return token!;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
