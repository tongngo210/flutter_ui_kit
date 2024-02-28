import 'package:flutter/material.dart';

class CalendarActions extends StatelessWidget {
  final String? primaryActionTitle;
  final String? secondaryActionTitle;
  final bool isPrimaryActionEnable;
  final TextStyle? primaryActionEnableTextStyle;
  final Decoration? primaryActionEnableDecoration;
  final TextStyle? primaryActionDisableTextStyle;
  final Decoration? primaryActionDisableDecoration;
  final TextStyle? secondaryActionTextStyle;
  final Decoration? secondaryActionTextDecoration;

  final VoidCallback onTapPrimaryAction;
  final VoidCallback onTapSecondaryAction;

  const CalendarActions({
    Key? key,
    this.primaryActionTitle,
    this.secondaryActionTitle,
    this.isPrimaryActionEnable = false,
    this.primaryActionEnableTextStyle,
    this.primaryActionEnableDecoration,
    this.primaryActionDisableTextStyle,
    this.primaryActionDisableDecoration,
    this.secondaryActionTextStyle,
    this.secondaryActionTextDecoration,
    required this.onTapPrimaryAction,
    required this.onTapSecondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double defaultFontSize = 16.0;
    return Row(
      children: [
        InkWell(
          onTap: isPrimaryActionEnable ? onTapPrimaryAction : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: isPrimaryActionEnable
                ? primaryActionEnableDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    )
                : primaryActionDisableDecoration ??
                    BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
            child: Text(
              primaryActionTitle ?? "OK",
              style: primaryActionEnableTextStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: defaultFontSize,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: onTapSecondaryAction,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: secondaryActionTextDecoration ?? const BoxDecoration(),
            child: Text(
              secondaryActionTitle ?? "Cancel",
              style: secondaryActionTextStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: defaultFontSize,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
