import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CalendarHeaderSelectType { month, year, none }

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime startDate;
  final DateTime endDate;
  final CalendarHeaderSelectType selectType;
  final VoidCallback onTapLeftMonth;
  final VoidCallback onTapRightMonth;
  final VoidCallback onTapSelectedMonth;
  final VoidCallback onTapLeftYear;
  final VoidCallback onTapRightYear;
  final VoidCallback onTapSelectedYear;
  final dynamic locale;

  const CalendarHeader({
    Key? key,
    required this.focusedDate,
    required this.startDate,
    required this.endDate,
    required this.selectType,
    required this.onTapLeftMonth,
    required this.onTapRightMonth,
    required this.onTapSelectedMonth,
    required this.onTapLeftYear,
    required this.onTapRightYear,
    required this.onTapSelectedYear,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final monthText = DateFormat.MMMM(locale).format(focusedDate);
    final yearText = DateFormat.y(locale).format(focusedDate);

    return Container(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Expanded(
              child: _sectionWidget(
            monthText,
            selectType != CalendarHeaderSelectType.year,
            CalendarHeaderSelectType.month,
            onTapSelectedMonth,
            onTapLeftMonth,
            onTapRightMonth,
          )),
          Expanded(
              child: _sectionWidget(
            yearText,
            selectType != CalendarHeaderSelectType.month,
            CalendarHeaderSelectType.year,
            onTapSelectedYear,
            onTapLeftYear,
            onTapRightYear,
          )),
        ],
      ),
    );
  }

  Widget _sectionWidget(
    String title,
    bool isChoosing,
    CalendarHeaderSelectType selectType,
    VoidCallback onTap,
    VoidCallback onTapLeft,
    VoidCallback onTapRight,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.chevron_left,
              size: 20,
              color: isChoosing
                  ? selectType == CalendarHeaderSelectType.month
                      ? focusedDate.year == startDate.year &&
                              focusedDate.month == startDate.month
                          ? Colors.grey.shade400
                          : null
                      : focusedDate.year == startDate.year
                          ? Colors.grey.shade400
                          : null
                  : Colors.grey.shade400,
            ),
            onPressed: isChoosing
                ? selectType == CalendarHeaderSelectType.month
                    ? focusedDate.year == startDate.year &&
                            focusedDate.month == startDate.month
                        ? null
                        : onTapLeft
                    : focusedDate.year == startDate.year
                        ? null
                        : onTapLeft
                : null,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isChoosing ? null : Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down_outlined,
                size: 20,
                color: isChoosing ? null : Colors.grey.shade400,
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              Icons.chevron_right,
              size: 20,
              color: isChoosing
                  ? selectType == CalendarHeaderSelectType.month
                      ? focusedDate.year == endDate.year &&
                              focusedDate.month == endDate.month
                          ? Colors.grey.shade400
                          : null
                      : focusedDate.year == endDate.year
                          ? Colors.grey.shade400
                          : null
                  : Colors.grey.shade400,
            ),
            onPressed: isChoosing
                ? selectType == CalendarHeaderSelectType.month
                    ? focusedDate.year == endDate.year &&
                            focusedDate.month == endDate.month
                        ? null
                        : onTapRight
                    : focusedDate.year == endDate.year
                        ? null
                        : onTapRight
                : null,
          ),
        ),
      ],
    );
  }
}
