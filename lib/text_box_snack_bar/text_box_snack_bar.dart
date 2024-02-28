import 'package:flutter/material.dart';
import 'package:flutter_ui_kit/text_box/text_box.dart';

class TextBoxSnackBar {
  BuildContext context;
  final String text;
  final TextStyle? textStyle;
  final int? maxLines;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget? leftIcon;
  final double? leftIconSize;
  final double leftIconSpacing;
  final Widget? rightIcon;
  final double? rightIconSize;
  final double rightIconSpacing;
  final BoxDecoration? boxDecoration;
  final int millisecDuration;

  TextBoxSnackBar({
    required this.context,
    required this.text,
    this.textStyle,
    this.maxLines,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(5),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.leftIcon,
    this.leftIconSize,
    this.leftIconSpacing = 0,
    this.rightIcon,
    this.rightIconSize,
    this.rightIconSpacing = 0,
    this.boxDecoration,
    this.millisecDuration = 1500,
  });

  void show() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.zero,
            duration: Duration(milliseconds: millisecDuration),
            content: TextBox(
              text: text,
              textStyle: textStyle,
              maxLines: maxLines,
              width: width,
              margin: margin,
              padding: padding,
              leftIcon: leftIcon,
              leftIconSize: leftIconSize,
              leftIconSpacing: leftIconSpacing,
              rightIcon: rightIcon,
              rightIconSize: rightIconSize,
              rightIconSpacing: rightIconSpacing,
              boxDecoration: boxDecoration,
            )))
        .closed
        .then((_) => ScaffoldMessenger.of(context).clearSnackBars());
  }
}
