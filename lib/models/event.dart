import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String subtitle;
  late bool isDone;

  Event(this.title, this.subtitle, this.isDone);
}

/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final dataDoctorEvents = Map<DateTime, List<Event>>();

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kToday.year, kToday.month, item * 3): List.generate(
      item % 10 + 1,
      (index) => Event(
        'Today\'s Event $item | ${index + 1}',
        DateTime.utc(kToday.year, kToday.month, item * 3).toString(),
        false,
      ),
    )
}..addAll({
    kToday: [
      Event('Today\'s Event 1', kToday.toString(), false),
      Event('Today\'s Event 2', kToday.toString(), false),
      Event('Today\'s Event 3', kToday.toString(), false),
      Event('Today\'s Event 4', kToday.toString(), false),
      Event('Today\'s Event 5', kToday.toString(), false),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
