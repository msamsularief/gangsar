import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klinik/api/api_client.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/models/chart.dart';

import 'chart.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(ChartLoading()) {
    on<ChartEvent>((event, emit) => emit(ChartLoading()));
    on<LoadChartList>((event, emit) async {
      emit(ChartListLoading());

      List<Chart> items = [];

      String? token = await Auth.getAccessToken();

      String userId = event.userId;
      String url =
          '/charts.json?auth=$token&orderBy="user_id"&equalTo="$userId"';
      try {
        var result = await ApiClient().public().get(url).then((value) => value);
        print("\n\nRESULT WHEN GET DATA [CHART_BLOC] : $result\n\n");
        if (result.isNotEmpty) {
          result.forEach((key, value) {
            var item = Chart.fromMap(value);
            items.add(item);
          });
          items.sort(((a, b) => DateTime.parse(a.createdAt).compareTo(
                DateTime.parse(b.createdAt),
              )));
          print("\n\nRESULT WHEN GET DATA [CHART_BLOC] : $items\n\n");
          emit(ChartListLoaded(items));
        } else {
          emit(
            ChartListFailure(
              message: "Data Kosong!",
            ),
          );
        }
      } catch (err) {
        print("ERROR : ${err.toString()}");
        emit(ChartListFailure(message: err.toString()));
      }
    });
    on<CreateChart>((event, emit) async {
      emit(ChartListLoading());

      String? token = await Auth.getAccessToken();

      String url = "/charts.json?auth=$token";

      final data = {
        "user_id": event.userId,
        "dt": event.createdAt,
        "body_mass_index": event.massIndex,
        "week": event.week,
      };

      final result = await ApiClient().public().post(url, body: data);

      print(result);
    });
  }

  @override
  void onTransition(Transition<ChartEvent, ChartState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
