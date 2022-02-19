import 'package:bloc/bloc.dart';
import 'package:klinik/core/storage.dart';

import 'hpl.dart';

class HplBloc extends Bloc<HplEvent, HplState> {
  HplBloc() : super(HplInitial()) {
    on<HplEvent>((event, emit) => emit(HplLoading()));
    on<HplButtonPressed>((event, emit) async {
      emit(HplLoading());

      try {
        await storage.setItem(event.key, event.dateTime);

        String? result = await storage.getItem(event.key);

        print('\n\n\nACCOUNT : $result\n\n\n');

        if (result != null) {
          emit(HplSuccess(result));
        } else {
          emit(HplFailure(error: "cannot get data from server !"));
        }
      } catch (e) {
        emit(HplFailure(error: e.toString()));
      }
    });
    on<GetHplData>((event, emit) async {
      emit(HplLoading());
      try {
        String? result = await storage.getItem(event.key);
        if (result != null) {
          emit(HplLoaded(result));
        } else {
          emit(HplFailure(error: "cannot get data from local !"));
        }
      } catch (e) {
        emit(HplFailure(error: e.toString()));
      }
    });
    on<EditHplData>((event, emit) async {
      emit(HplLoading());
      await storage.setItem(event.key, event.dateTime);
      final data = await storage.getItem(event.key);
      if (data != null) {
        
      } else {
      }
    });
  }

  @override
  void onTransition(Transition<HplEvent, HplState> transition) {
    super.onTransition(transition);
    print("\n$transition");
  }
}
