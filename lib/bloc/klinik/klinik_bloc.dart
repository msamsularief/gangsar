import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/bloc/klinik/klinik.dart';

class KlinikBloc extends Bloc<KlinikEvent, KlinikState> {
  KlinikBloc() : super(KlinikLoading()) {
    on<KlinikEvent>((event, emit) => emit(AuthenticationLoading()));
    on<StartupEvent>((event, emit) async {
      emit(AuthenticationLoading());
      bool hasToken = await Auth.hasAccessToken();

      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<LoggedIn>((event, emit) {
      emit(AuthenticationLoading());
      emit(AuthenticationAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await Auth.doLogout();

      emit(AuthenticationUnauthenticated());
    });
  }

  @override
  void onTransition(Transition<KlinikEvent, KlinikState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
