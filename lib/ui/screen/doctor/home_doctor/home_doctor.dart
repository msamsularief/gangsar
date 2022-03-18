import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/helper/date_formatter.dart';
import 'package:klinik/models/event.dart';
import 'package:klinik/ui/widget/build_body_widget.dart';
import 'package:klinik/ui/widget/card_widget.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({Key? key}) : super(key: key);

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat calendarFormat = CalendarFormat.month;
  late DateTime _focusDate = DateTime.now();
  final DateTime initialDate = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = _focusDate;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDate!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDate, selectedDay)) {
      setState(() {
        _selectedDate = selectedDay;
        _focusDate = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KlinikAppBar(
        title: "Home Doctor",
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 24.0,
                left: 8.0,
                right: 8.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TableCalendar<Event>(
                focusedDay: _focusDate,
                firstDay: initialDate,
                lastDay: DateTime(
                  initialDate.year + 1,
                  initialDate.month,
                  initialDate.day,
                ),
                currentDay: initialDate,
                locale: "id_ID",
                startingDayOfWeek: StartingDayOfWeek.monday,
                rangeSelectionMode: RangeSelectionMode.disabled,
                calendarFormat: calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                weekendDays: [
                  DateTime.sunday,
                ],
                rowHeight: 54.0,
                calendarStyle: CalendarStyle(
                  weekendDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.red.shade500,
                  ),
                  disabledDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  rowDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  outsideDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  selectedDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Theme.of(context).primaryColor,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                // holidayPredicate: (day) => isSameDay(day, day),
                calendarBuilders: CalendarBuilders<Event>(
                  holidayBuilder: (context, day, focusedDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: false,
                    textColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade400
                        : null,
                    borderColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade100
                        : Colors.green.shade300,
                  ),
                  disabledBuilder: (container, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Colors.grey.shade300,
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.white,
                  ),
                  defaultBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: false,
                    textColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade300
                        : null,
                    borderColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade300
                        : Colors.green.shade300,
                    backgroundColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                  ),
                  outsideBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: false,
                    textColor: Colors.grey.shade300,
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.white,
                  ),
                  selectedBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: true,
                    borderColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  todayBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: true,
                    borderColor: Theme.of(context).primaryColor.withOpacity(
                          0.2,
                        ),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(
                          0.2,
                        ),
                  ),
                  markerBuilder: (context, day, events) {
                    List<Event> items = [];
                    for (var i = 0; i < events.length; i++) {
                      events.map((e) {
                        if (i == events.indexOf(e) &&
                            events[i].isDone == false) {
                          items.add(e);
                        }
                      }).toList(growable: false);
                    }

                    if (items.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.green.shade400,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            padding: EdgeInsets.all(1.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "${items.length}",
                                style: TextStyle(
                                  color: Colors.green.shade400,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                onDaySelected: _onDaySelected,
                eventLoader: _getEventsForDay,
                onFormatChanged: (format) {
                  if (calendarFormat != format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusDate = focusedDay;
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              height: 40.0,
            ),
            Container(
              width: Core.getDefaultAppWidth(context),
              padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "Events",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 24.0,
                    ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return Column(
                  children: value.isEmpty
                      ? [
                          Container(
                            child: Icon(
                              Icons.list,
                              color: Colors.black45,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Tidak ada jadwal hari ini.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                            ),
                          ),
                        ]
                      : value
                          .map(
                            // (e) => Container(
                            //   margin: const EdgeInsets.symmetric(
                            //     horizontal: 12.0,
                            //     vertical: 4.0,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(),
                            //     borderRadius: BorderRadius.circular(12.0),
                            //   ),
                            //   child: ListTile(
                            //     onTap: () => setState(() {
                            //       e.isDone = !e.isDone;
                            //     }),
                            //     title: Text(e.title),
                            //   ),
                            // ),
                            (e) => cardWidget(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              backgroundColor:
                                  e.isDone ? Colors.grey.shade300 : null,
                              // onTap: () async {
                              //   final result = await navigateTo(
                              //     AppRoute.hphtDoctor,
                              //     arguments: e,
                              //   );
                              //   if (result != null) {
                              //     setState(() {
                              //       e.isDone = result;
                              //     });
                              //   }
                              // },
                              child: ListTile(
                                onLongPress: () {
                                  setState(() => e.isDone = false);
                                },
                                onTap: () async {
                                  final result = await navigateTo(
                                    AppRoute.hphtDoctor,
                                    arguments: e,
                                  );
                                  if (result != null) {
                                    setState(() {
                                      e.isDone = result;
                                    });
                                  }
                                },
                                contentPadding: const EdgeInsets.all(8.0),
                                tileColor: Colors.transparent,
                                leading: Container(
                                  height: 80,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      // image: DecorationImage(
                                      //   image: AssetImage(
                                      //     images[titles.indexOf(e)],
                                      //   ),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      ),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color: Colors.orange.shade200,
                                    size: 64.0,
                                  ),
                                ),
                                trailing: const SizedBox(
                                  height: 80,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 32.0,
                                    color: Color(0xFF00213D),
                                  ),
                                ),
                                title: Text(
                                  e.title,
                                  style: const TextStyle(
                                    color: Color(0xFF00213D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Pemeriksaan tanggal " +
                                      e.subtitle.todMMMMy(),
                                  style: const TextStyle(
                                    color: Color(0xFF00213D),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  buildContainer(
    BuildContext context, {
    required String text,
    Color? textColor,
    Color? borderColor,
    Color? backgroundColor,
    double size = 64.0,
    bool isSelectedItem = false,
  }) =>
      Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(1.0),
        margin: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: borderColor ?? Colors.green.shade100,
          borderRadius: BorderRadius.circular(64.0),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.green.shade50,
            borderRadius: BorderRadius.circular(64.0),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.0,
                  color: isSelectedItem ? Colors.white : textColor,
                ),
          ),
        ),
      );
}
