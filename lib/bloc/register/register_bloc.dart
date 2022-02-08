import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/bloc/register/register.dart';
import 'package:klinik/model/authorize_result.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) => emit(RegisterInitial()));
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await Auth.doRegister(
          event.email,
          event.password,
          event.fullName,
          event.phoneNum,
        );

        print('\nResult : $result\n');

        if (result != null) {
          emit(RegisterSuccess(message: result.message));
        } else {
          emit(RegisterFailure(error: result!.message!));
        }
      } catch (e) {
        e as AuthorizeResult;
        emit(RegisterFailure(error: e.message!));
      }
    });
  }

  @override
  void onTransition(Transition<RegisterEvent, RegisterState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
