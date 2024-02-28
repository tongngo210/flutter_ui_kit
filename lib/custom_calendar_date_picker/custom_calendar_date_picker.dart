import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

import 'calendar_actions.dart';
import 'calendar_header.dart';
import 'calendar_select_type_list_items.dart';

class CustomCalendarDatePicker extends StatefulWidget {
  final BoxDecoration? decoration;
  final Widget? customHeader;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isRangeDateSelectType;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<Tuple2<DateTime, DateTime>>? onSelectedRangeDate;
  final VoidCallback? onCancel;
  final dynamic locale;
  final double rowHeight;
  final double daysOfWeekHeight;
  final String Function(DateTime, dynamic)? dowTextFormatter;
  final TextStyle? dowWeekdayStyle;
  final TextStyle? dowWeekendStyle;
  final bool isSundayStartingDayOfWeek;
  final double rowMargin;
  // Normal Day Configuration
  final TextStyle? normalDayStyle;
  final Decoration? normalDayDecoration;
  // Weekend Day Configuration
  final TextStyle? weekendDayTextStyle;
  final Decoration? weekendDayDecoration;
  // Disable Day Configuration
  final TextStyle? disabledDayTextStyle;
  final Decoration? disabledDayDecoration;
  // Outside Day Configuration
  final bool isOutsideDaysEnable;
  final TextStyle? outsideDayTextStyle;
  final Decoration? outsideDayDecoration;
  // Today Configuration
  final bool isTodayEnable;
  final TextStyle? todayTextStyle;
  final Decoration? todayDecoration;
  // Range Date Select Configuration
  final TextStyle? rangeStartTextStyle;
  final Decoration? rangeStartDecoration;
  final TextStyle? rangeEndTextStyle;
  final Decoration? rangeEndDecoration;
  final TextStyle? rangeWithInTextStyle;
  final Decoration? rangeWithInDecoration;
  final Color? rangeHighlightColor;
  final double? rangeHighlightScale;
  // Actions Configuration
  final String? primaryActionTitle;
  final String? secondaryActionTitle;
  final TextStyle? primaryActionEnableTextStyle;
  final Decoration? primaryActionEnableDecoration;
  final TextStyle? primaryActionDisableTextStyle;
  final Decoration? primaryActionDisableDecoration;
  final TextStyle? secondaryActionTextStyle;
  final Decoration? secondaryActionTextDecoration;

  const CustomCalendarDatePicker({
    super.key,
    this.decoration,
    this.customHeader,
    this.startDate,
    this.endDate,
    this.isRangeDateSelectType = false,
    this.onSelectedDate,
    this.onSelectedRangeDate,
    this.onCancel,
    this.locale,
    this.rowHeight = 40,
    this.daysOfWeekHeight = 48,
    this.dowTextFormatter,
    this.dowWeekdayStyle,
    this.dowWeekendStyle,
    this.isSundayStartingDayOfWeek = false,
    this.rowMargin = 0,
    this.normalDayStyle,
    this.normalDayDecoration,
    this.weekendDayTextStyle,
    this.weekendDayDecoration,
    this.disabledDayTextStyle,
    this.disabledDayDecoration,
    this.isOutsideDaysEnable = false,
    this.outsideDayTextStyle,
    this.outsideDayDecoration,
    this.isTodayEnable = false,
    this.todayTextStyle,
    this.todayDecoration,
    this.rangeStartTextStyle,
    this.rangeStartDecoration,
    this.rangeEndTextStyle,
    this.rangeEndDecoration,
    this.rangeWithInTextStyle,
    this.rangeWithInDecoration,
    this.rangeHighlightColor,
    this.rangeHighlightScale,
    this.primaryActionTitle,
    this.secondaryActionTitle,
    this.primaryActionEnableTextStyle,
    this.primaryActionEnableDecoration,
    this.primaryActionDisableTextStyle,
    this.primaryActionDisableDecoration,
    this.secondaryActionTextStyle,
    this.secondaryActionTextDecoration,
  });

  @override
  State<CustomCalendarDatePicker> createState() =>
      _CustomCalendarDatePickerState();
}

class _CustomCalendarDatePickerState extends State<CustomCalendarDatePicker> {
  final double _defaultFontSize = 16.0;
  final List<int> _listMonths = List<int>.generate(12, (i) => i + 1);
  final ValueNotifier<DateTime> _focusedDate = ValueNotifier(DateTime.now());

  DateTime get _startDate {
    return widget.startDate ??
        DateTime.now().subtract(const Duration(days: 365));
  }

  DateTime get _endDate {
    return widget.endDate ?? DateTime.now().add(const Duration(days: 365));
  }

  List<int> get _listYears {
    List<int> years = [];
    for (int i = _startDate.year; i <= _endDate.year; i++) {
      years.add(i);
    }
    return years;
  }

  CalendarHeaderSelectType _selectType = CalendarHeaderSelectType.none;
  DateTime? _currentDate = DateTime.now();
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDate,
            builder: (context, focusedDate, _) {
              return Container(
                decoration: widget.decoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.transparent, width: 1),
                    ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    _customHeader(focusedDate),
                    Stack(
                      children: [
                        _calendarTable(),
                        if (_selectType == CalendarHeaderSelectType.month)
                          _calenderSelectTypeListItems(
                            CalendarHeaderSelectType.month,
                            _listMonths,
                            (selectedMonth) {
                              final selectedDate = _focusedDate.value
                                  .copyWith(month: selectedMonth);
                              if (selectedDate.isBefore(_startDate)) {
                                _focusedDate.value = _startDate;
                              } else if (selectedDate.isAfter(_endDate)) {
                                _focusedDate.value = _endDate;
                              } else {
                                _focusedDate.value = _focusedDate.value
                                    .copyWith(month: selectedMonth);
                              }
                              _selectType = CalendarHeaderSelectType.none;
                            },
                          ),
                        if (_selectType == CalendarHeaderSelectType.year)
                          _calenderSelectTypeListItems(
                            CalendarHeaderSelectType.year,
                            _listYears,
                            (selectedYear) {
                              final selectedDate = _focusedDate.value
                                  .copyWith(year: selectedYear);
                              if (selectedDate.isBefore(_startDate)) {
                                _focusedDate.value = _startDate;
                              } else if (selectedDate.isAfter(_endDate)) {
                                _focusedDate.value = _endDate;
                              } else {
                                _focusedDate.value = _focusedDate.value
                                    .copyWith(year: selectedYear);
                              }
                              _selectType = CalendarHeaderSelectType.none;
                            },
                          ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _calenderSelectTypeListItems(
    CalendarHeaderSelectType selectType,
    List<dynamic> listItems,
    Function(dynamic) onTapItem,
  ) {
    return CalendarSelectTypeListItems(
      focusedDate: _focusedDate.value,
      startDate: _startDate,
      endDate: _endDate,
      listItems: listItems,
      selectType: selectType,
      onTapItem: onTapItem,
    );
  }

  Widget _customHeader(DateTime focusedDate) {
    return Column(
      children: [
        widget.customHeader ??
            CalendarHeader(
              focusedDate: focusedDate,
              startDate: _startDate,
              endDate: _endDate,
              selectType: _selectType,
              onTapLeftMonth: () {
                final newFocusedDate =
                    focusedDate.copyWith(month: focusedDate.month - 1);

                _focusedDate.value = (newFocusedDate.isBefore(_startDate))
                    ? _startDate
                    : newFocusedDate;
              },
              onTapRightMonth: () {
                final newFocusedDate =
                    focusedDate.copyWith(month: focusedDate.month + 1);

                _focusedDate.value = newFocusedDate.isAfter(_endDate)
                    ? _endDate
                    : newFocusedDate;
              },
              onTapSelectedMonth: () {
                setState(() {
                  _selectType = _selectType == CalendarHeaderSelectType.month
                      ? CalendarHeaderSelectType.none
                      : CalendarHeaderSelectType.month;
                });
              },
              onTapLeftYear: () {
                final newFocusedDate =
                    focusedDate.copyWith(year: focusedDate.year - 1);

                _focusedDate.value = (newFocusedDate.isBefore(_startDate))
                    ? _startDate
                    : newFocusedDate;
              },
              onTapRightYear: () {
                final newFocusedDate =
                    focusedDate.copyWith(year: focusedDate.year + 1);

                _focusedDate.value = newFocusedDate.isAfter(_endDate)
                    ? _endDate
                    : newFocusedDate;
              },
              onTapSelectedYear: () {
                setState(() {
                  _selectType = _selectType == CalendarHeaderSelectType.year
                      ? CalendarHeaderSelectType.none
                      : CalendarHeaderSelectType.year;
                });
              },
            ),
        Container(color: Colors.grey.shade300, height: 1),
      ],
    );
  }

  Widget _calendarTable() {
    return Column(
      children: [
        TableCalendar(
          locale: widget.locale,
          startingDayOfWeek: widget.isSundayStartingDayOfWeek
              ? StartingDayOfWeek.sunday
              : StartingDayOfWeek.monday,
          firstDay: _startDate.toUtc(),
          lastDay: _endDate.toUtc(),
          focusedDay: _focusedDate.value,
          rowHeight: widget.rowHeight,

          // Range Date Select Configuration
          currentDay: widget.isRangeDateSelectType ? null : _currentDate,
          selectedDayPredicate: widget.isRangeDateSelectType
              ? (day) => isSameDay(_selectedDate, day)
              : null,
          rangeSelectionMode: widget.isRangeDateSelectType
              ? _rangeSelectionMode
              : RangeSelectionMode.disabled,
          rangeStartDay: widget.isRangeDateSelectType ? _rangeStart : null,
          rangeEndDay: widget.isRangeDateSelectType ? _rangeEnd : null,
          onRangeSelected: widget.isRangeDateSelectType
              ? (start, end, focusedDay) {
                  setState(() {
                    _rangeStart = start;
                    _rangeEnd = end;
                    _selectedDate = null;
                    _focusedDate.value = focusedDay;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                }
              : null,

          // Header Configuration
          headerVisible: false,

          // Days of week Configuration
          daysOfWeekHeight: widget.daysOfWeekHeight,
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: widget.dowTextFormatter ??
                (date, locale) => DateFormat.E(locale).format(date),
            weekdayStyle: widget.dowWeekdayStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
            weekendStyle: widget.dowWeekendStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
          ),

          // Calendar Configuration
          calendarStyle: CalendarStyle(
            cellMargin: EdgeInsets.all(widget.rowMargin),

            // Normal Day Configuration
            defaultTextStyle: widget.normalDayStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: _defaultFontSize,
                ),
            defaultDecoration: widget.normalDayDecoration ??
                const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),

            // Weekend Day Configuration
            weekendTextStyle: widget.weekendDayTextStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: _defaultFontSize,
                  fontWeight: FontWeight.normal,
                ),

            weekendDecoration: widget.weekendDayDecoration ??
                const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),

            // Outside Day Configuration
            outsideDaysVisible: widget.isOutsideDaysEnable,
            outsideTextStyle: widget.outsideDayTextStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: _defaultFontSize,
                ),
            outsideDecoration: widget.outsideDayDecoration ??
                const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),

            // Disable Day Configuration
            disabledTextStyle: widget.disabledDayTextStyle ??
                TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: _defaultFontSize,
                ),
            disabledDecoration: widget.disabledDayDecoration ??
                const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),

            // Today Configuration
            isTodayHighlighted: !widget.isRangeDateSelectType,
            todayTextStyle: widget.todayTextStyle ??
                TextStyle(
                  color: widget.isRangeDateSelectType
                      ? Colors.black
                      : Colors.white,
                  fontSize: _defaultFontSize,
                  fontWeight:
                      widget.isRangeDateSelectType ? null : FontWeight.normal,
                ),
            todayDecoration: widget.todayDecoration ??
                BoxDecoration(
                  color: widget.isRangeDateSelectType
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),

            // Range Date Select Configuration
            rangeStartDecoration: widget.rangeStartDecoration ??
                BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
            rangeStartTextStyle: widget.rangeStartTextStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: _defaultFontSize,
                  fontWeight: FontWeight.normal,
                ),
            rangeEndDecoration: widget.rangeEndDecoration ??
                BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
            rangeEndTextStyle: widget.rangeEndTextStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: _defaultFontSize,
                  fontWeight: FontWeight.normal,
                ),

            // Within Range Date Configuration
            withinRangeTextStyle: widget.rangeWithInTextStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: _defaultFontSize,
                ),
            withinRangeDecoration: widget.rangeWithInDecoration ??
                const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
            rangeHighlightColor: widget.rangeHighlightColor ??
                Theme.of(context).colorScheme.inversePrimary,
            rangeHighlightScale: widget.rangeHighlightScale ?? 1,
          ),

          // Calendar Actions
          onPageChanged: (focusedDate) {
            setState(() {
              _focusedDate.value = focusedDate;
            });
          },
          onDaySelected: (selectedDate, focusedDate) {
            if (widget.isRangeDateSelectType) {
              if (!isSameDay(_selectedDate, selectedDate)) {
                setState(() {
                  _selectedDate = selectedDate;
                  _focusedDate.value = focusedDate;
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            } else {
              setState(() {
                _currentDate = selectedDate;
                _focusedDate.value = selectedDate.month == focusedDate.month
                    ? focusedDate
                    : selectedDate;
              });
            }
          },
        ),
        const SizedBox(height: 12),
        _calendarActions(),
      ],
    );
  }

  Widget _calendarActions() {
    return CalendarActions(
      primaryActionTitle: widget.primaryActionTitle,
      secondaryActionTitle: widget.secondaryActionTitle,
      primaryActionEnableTextStyle: widget.primaryActionEnableTextStyle,
      primaryActionEnableDecoration: widget.primaryActionEnableDecoration,
      primaryActionDisableTextStyle: widget.primaryActionDisableTextStyle,
      primaryActionDisableDecoration: widget.primaryActionDisableDecoration,
      secondaryActionTextStyle: widget.secondaryActionTextStyle,
      secondaryActionTextDecoration: widget.secondaryActionTextDecoration,
      isPrimaryActionEnable: widget.isRangeDateSelectType
          ? _rangeStart != null && _rangeEnd != null
          : _currentDate != null,
      onTapPrimaryAction: () {
        if (widget.isRangeDateSelectType &&
            widget.onSelectedRangeDate != null &&
            _rangeStart != null &&
            _rangeEnd != null) {
          widget.onSelectedRangeDate!(Tuple2(_rangeStart!, _rangeEnd!));
        } else if (widget.onSelectedDate != null && _currentDate != null) {
          widget.onSelectedDate!(_currentDate!);
        }
      },
      onTapSecondaryAction: () => widget.onCancel,
    );
  }
}
