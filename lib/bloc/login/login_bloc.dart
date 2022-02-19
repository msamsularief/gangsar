import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/core/storage.dart';
import 'package:klinik/models/authorize_result.dart';
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
        AuthorizeResult? result = await Auth.doLogin(
          event.email,
          event.password,
        );

        print('\n\n\nACCOUNT : ${result?.account}\n\n\n');

        if (result != null) {
          if (result.account != null) {
            final token = await storage.getItem('accessToken');

            print('AccessToken = $token');
            klinikBloc.add(LoggedIn());
            print("Logged In");
            emit(LoginSuccess(result.account));
          } else {
            emit(LoginFailure(error: result.message!));
          }
        } else {
          emit(LoginFailure(error: "cannot get data from server !"));
        }
      } catch (e) {
        e as AuthorizeResult;
        emit(LoginFailure(error: e.message.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
