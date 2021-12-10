// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:klinik/bloc/tab/tab_event.dart';
import 'package:klinik/model/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.home) {
    // on<TabEvent>((event, emit) => emit(AppTab.home));
    on<UpdateTab>(
      (event, emit) => emit(event.tab),
    );
  }

  @override
  void onTransition(Transition<TabEvent, AppTab> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
