import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateChart extends ChartEvent {
  final String userId;
  final String massIndex;
  final String createdAt;
  final String week;

  CreateChart(this.userId, this.massIndex, this.createdAt, this.week);

  @override
  String toString() => "CreateChart";
}

class LoadChart extends ChartEvent {
  @override
  String toString() => "LoadChart";
}

class DeleteChart extends ChartEvent {
  final String userId;

  DeleteChart(this.userId);

  @override
  String toString() => "DeleteChart";
}

class LoadChartList extends ChartEvent {
  final String userId;

  LoadChartList(this.userId);

  @override
  String toString() => "LoadiChartList";
}
