import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import '../klinik/klinik.dart';
import 'login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final KlinikBloc klinikBloc;

  LoginBloc({
    required this.klinikBloc,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) => emit(LoginLoading()));
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final result = await Auth.doLogin(event.email, event.password);

        // final data = prefs.getString('currentUser');
        print('\n\n\nACCOUNT : ${result?.account}\n\n\n');

        if (result != null) {
          klinikBloc.add(LoggedIn());
          print("Logged In");
          emit(LoginSuccess(result.account));
        } else {
          emit(LoginFailure(error: "Cannot get new session"));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
