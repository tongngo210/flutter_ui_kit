import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calendar_header.dart';

class CalendarSelectTypeListItems extends StatelessWidget {
  final DateTime focusedDate;
  final DateTime startDate;
  final DateTime endDate;
  final List listItems;
  final ValueChanged onTapItem;
  final CalendarHeaderSelectType selectType;
  final dynamic locale;

  const CalendarSelectTypeListItems({
    super.key,
    required this.focusedDate,
    required this.startDate,
    required this.endDate,
    required this.listItems,
    required this.onTapItem,
    required this.selectType,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 24),
      height: 368,
      child: RawScrollbar(
        thumbColor: const Color(0xFFE6E7EB),
        thickness: 8,
        radius: const Radius.circular(30),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              final focusedDateWithMonthFromIndex =
                  focusedDate.copyWith(month: listItems[index]);

              bool isAfterOrEqualStartDate =
                  (focusedDateWithMonthFromIndex.isAfter(startDate) ||
                      focusedDateWithMonthFromIndex.month == startDate.month);

              bool isBeforeOrEqualEndDate =
                  (focusedDateWithMonthFromIndex.isBefore(endDate) ||
                      focusedDateWithMonthFromIndex.month == endDate.month);
              return GestureDetector(
                onTap: () {
                  if (selectType == CalendarHeaderSelectType.month &&
                      !(isAfterOrEqualStartDate && isBeforeOrEqualEndDate)) {
                    return;
                  }
                  onTapItem(listItems[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectType == CalendarHeaderSelectType.month
                        ? (focusedDate.month == listItems[index]
                            ? const Color(0xFFE6E7EB)
                            : null)
                        : (focusedDate.year == listItems[index]
                            ? const Color(0xFFE6E7EB)
                            : null),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                  child: Text(
                    selectType == CalendarHeaderSelectType.month
                        ? DateFormat.MMMM(locale)
                            .format(DateTime(0, listItems[index]))
                        : "${listItems[index]}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: selectType == CalendarHeaderSelectType.month
                            ? isAfterOrEqualStartDate && isBeforeOrEqualEndDate
                                ? const Color(0xFF333333)
                                : const Color(0xFFCCCCCC)
                            : const Color(0xFF333333)),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
