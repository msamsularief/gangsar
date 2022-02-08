import 'package:bloc/bloc.dart';
import 'package:klinik/bloc/klinik/klinik.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KlinikBloc extends Bloc<KlinikEvent, KlinikState> {
  KlinikBloc() : super(KlinikLoading()) {
    on<KlinikEvent>((event, emit) => emit(AuthenticationLoading()));
    on<StartupEvent>((event, emit) async {
      emit(AuthenticationLoading());
      final prefs = await SharedPreferences.getInstance();

      final data = prefs.getString('accessToken');
      print('DATA : $data');

      if (data != null) {
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
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();

      emit(AuthenticationUnauthenticated());
    });
  }

  @override
  void onTransition(Transition<KlinikEvent, KlinikState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
