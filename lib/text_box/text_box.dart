import 'package:flutter/material.dart';

enum IconSide { left, right }

class TextBox extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final int? maxLines;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget? icon;
  final double? iconSize;
  final IconSide iconSide;
  final double spacing;
  final BoxDecoration? boxDecoration;

  const TextBox({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLines,
    this.width = double.infinity,
    this.margin = const EdgeInsets.all(5),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    this.icon,
    this.iconSize,
    this.iconSide = IconSide.left,
    this.spacing = 0,
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
        textDirection:
            iconSide == IconSide.left ? TextDirection.ltr : TextDirection.rtl,
        children: [
          if (icon != null)
            Container(
              width: iconSize,
              height: iconSize,
              margin: EdgeInsets.only(right: spacing),
              child: icon,
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
        ],
      ),
    );
  }
}
