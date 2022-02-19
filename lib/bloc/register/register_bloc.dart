import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/bloc/register/register.dart';
import 'package:klinik/models/authorize_result.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) => emit(RegisterInitial()));
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());

      try {
        AuthorizeResult? result = await Auth.doRegister(
          event.email,
          event.password,
          event.fullName,
          event.phoneNum,
        );

        if (result != null) {
          if (result.message == 'Register Success') {
            emit(RegisterSuccess(message: result.message));
          } else {
            emit(RegisterFailure(error: result.message!));
          }
        } else {
          emit(RegisterFailure(error: 'cannot get data from server !'));
        }
      } catch (e) {
        e as AuthorizeResult;
        if (e.message != 'Register Success') {
          print("\n\n\nERROR : ${e.toString()}\n\n\n");
          emit(RegisterFailure(error: e.message.toString()));
        }
      }
    });
  }

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
