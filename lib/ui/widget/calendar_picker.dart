import 'package:flutter/material.dart';
import 'package:klinik/core/app_route.dart';
import 'package:klinik/core/core.dart';
import 'package:klinik/core/locale_formater.dart';
import 'package:klinik/models/range_calendar_picker.dart';
import 'package:klinik/ui/widget/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPicker extends StatefulWidget {
  final bool isRangedPicker;
  final DateTime? selectedDay;
  final String? title;
  final Color? backgroundColor;
  const CalendarPicker({
    Key? key,
    required this.isRangedPicker,
    this.selectedDay,
    this.title,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  late DateTime _focusedDay = DateTime.now();
  final DateTime initialDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  void initDay() {
    if (widget.selectedDay != null) {
      _selectedDay = widget.selectedDay;
    }
  }

  @override
  void initState() {
    super.initState();
    initDay();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end ?? start;
    });
  }

  // void _onFormatChanged(CalendarFormat format) {
  //   if (calendarFormat != format) {
  //     setState(() {
  //       calendarFormat = format;
  //     });
  //   }
  // }

  void _onPageChanged(DateTime focusedDay) {
    setState(() => _focusedDay = focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      persistentFooterButtons: [
        CustomButton.defaultButton(
          title: "Simpan",
          titleSize: 18.0,
          titleColor: Colors.white,
          titleFontWeight: FontWeight.bold,
          width: Core.getDefaultAppWidth(context),
          height: 48.0,
          onPressed: () => goBack(
            !widget.isRangedPicker
                ? _selectedDay
                : RangeCalendarPicker(
                    _rangeStart.toString(),
                    _rangeEnd.toString(),
                  ),
          ),
        ),
      ],
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 24.0,
              ),
              child: Text(widget.title ?? "Pilih Tanggal"),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 0.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              color: Colors.white,
              child: TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                locale: LocalFormatter.indonesian,
                rangeSelectionMode: widget.isRangedPicker
                    ? RangeSelectionMode.enforced
                    : RangeSelectionMode.disabled,
                focusedDay: _focusedDay,
                firstDay: DateTime(initialDay.year - 1, initialDay.month, 1),
                currentDay: initialDay,
                lastDay: initialDay,
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rowHeight: 54.0,
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onPageChanged: _onPageChanged,
                onDaySelected: _onDaySelected,
                onRangeSelected:
                    widget.isRangedPicker ? _onRangeSelected : null,
                // onFormatChanged: _onFormatChanged,
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: false,
                  cellAlignment: Alignment.center,
                  rangeHighlightColor:
                      Theme.of(context).primaryColor.withOpacity(0.16),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                key: ValueKey("Calendar"),
                // sixWeekMonthsEnforced: true,
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: false,
                    textColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade300
                        : null,
                    borderColor: day.weekday == DateTime.sunday
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    backgroundColor: Colors.white70,
                  ),
                  todayBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    fontWeight: FontWeight.w800,
                    textColor: Theme.of(context).primaryColor.withOpacity(0.4),
                    borderColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    backgroundColor: Colors.white.withOpacity(0.9),
                  ),
                  selectedBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white.withOpacity(0.9),
                  ),
                  disabledBuilder: (container, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Colors.grey.shade300,
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.white,
                  ),
                  outsideBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    isSelectedItem: false,
                    textColor: Colors.grey.shade300,
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.white,
                  ),
                  rangeStartBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white.withOpacity(0.7),
                  ),
                  rangeEndBuilder: (context, day, focusDay) => buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white.withOpacity(0.7),
                  ),
                  withinRangeBuilder: (context, day, focussedDay) =>
                      buildContainer(
                    context,
                    text: day.day.toString(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    backgroundColor: Colors.white.withOpacity(0.74),
                  ),
                ),
              ),
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
    double? height,
    double? width,
    bool isSelectedItem = false,
    FontWeight? fontWeight,
  }) =>
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(2.4),
        child: Container(
          width: width ?? size,
          height: height ?? size,
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: borderColor ?? Colors.green.shade100,
            shape: BoxShape.circle,
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16.0,
                  color: isSelectedItem ? Colors.white : textColor,
                  fontWeight: fontWeight),
            ),
          ),
        ),
      );
}
