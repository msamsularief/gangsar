import 'package:equatable/equatable.dart';
import 'package:klinik/models/chart.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChartLoading extends ChartState {
  @override
  String toString() => "ChartLoading";
}

class ChartLoaded extends ChartState {
  final Chart? item;

  ChartLoaded(this.item);

  @override
  String toString() => "ChartLoaded : Chart $item";
}

class ChartFailure extends ChartState {
  @override
  String toString() => "ChartFailure";
}

class ChartListLoading extends ChartState {
  @override
  String toString() => "ChartListLoading";
}

class ChartListLoaded extends ChartState {
  final List<Chart>? items;

  ChartListLoaded(this.items);
  @override
  String toString() => "ChartListLoaded";
}

class ChartListFailure extends ChartState {
  final String? message;

  ChartListFailure({this.message});
  @override
  String toString() => "ChartListFailure : message $message";
}
