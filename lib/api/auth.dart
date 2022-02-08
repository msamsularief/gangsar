import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:klinik/helper/json_helper.dart';
import 'package:klinik/model/account.dart';
import 'package:klinik/model/authorize_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    AuthorizeResult? result;
    Account account;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      print(userCredential);

      if (user != null) {
        final idToken = await user.getIdToken();
        print('\n\nID TOKEN : $idToken\n\n');

        await prefs.setString('accessToken', idToken);

        account = Account(user.displayName!, user.email!);

        print("\n\n\nACCOUNT DATA $account\n\n\n");

        await prefs.setString(
          'currentUser',
          account.toMap().toString(),
        );
        return AuthorizeResult(account: account);
      } else {
        return result;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthorizeResult(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthorizeResult(
          message: 'Wrong password provided for that user.',
        );
      }
    } catch (e) {
      throw AuthorizeResult(
        message: e.toString(),
      );
    }

    print(result);
    return result;
  }

  static Future<AuthorizeResult?> doRegister(
    String email,
    String password,
    String fullName,
    String phoneNum,
  ) async {
    Account? account;
    AuthorizeResult? result;
    String? errorMessage = "";

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await userCredential.user!.updateDisplayName(fullName);
        await auth.verifyPhoneNumber(
          phoneNumber: phoneNum,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {},
          codeAutoRetrievalTimeout: (String verificationId) {},
        );

        await userCredential.user!.reload();

        user.sendEmailVerification();

        result?.message = 'Register Success';
      } else {
        return result;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        throw AuthorizeResult(message: errorMessage);
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';

        throw AuthorizeResult(message: errorMessage);
      }
    } catch (e) {
      print('CATCHED : $e');
      errorMessage = e.toString();
      throw AuthorizeResult(message: errorMessage);
    }
    print(result!.message);
    return result;
  }
}
