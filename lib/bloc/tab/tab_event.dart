import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:klinik/model/app_tab.dart';

@immutable
abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  const UpdateTab(this.tab);

  @override
  String toString() => 'UpdateTab { tab: $tab }';
}
