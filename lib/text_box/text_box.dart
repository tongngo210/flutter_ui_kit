import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
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

  const TextBox({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: boxDecoration ??
          BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
      child: Row(
        children: [
          if (leftIcon != null)
            Container(
              width: leftIconSize,
              height: leftIconSize,
              margin: EdgeInsets.only(right: leftIconSpacing),
              child: leftIcon,
            ),
          Expanded(
            child: Text(
              text,
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          if (rightIcon != null)
            Container(
              width: rightIconSize,
              height: rightIconSize,
              margin: EdgeInsets.only(left: rightIconSpacing),
              child: rightIcon,
            ),
        ],
      ),
    );
  }
}
