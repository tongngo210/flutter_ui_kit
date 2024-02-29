import 'package:flutter/material.dart';

class CustomDialog {
  BuildContext context;
  final Widget? image;
  final String title;
  final TextStyle? titleTextStyle;
  final String? message;
  final TextStyle? messageTextStyle;
  final EdgeInsets? dialogMargin;
  final EdgeInsets? dialogPadding;
  final Decoration? dialogDecoration;
  final String primaryActionTitle;
  final TextStyle? primaryActionTextStyle;
  final ButtonStyle? primaryActionButtonStyle;
  final VoidCallback? primaryTapAction;
  final String? secondaryActionTitle;
  final TextStyle? secondaryActionTextStyle;
  final ButtonStyle? secondaryActionButtonStyle;
  final VoidCallback? secondaryTapAction;

  CustomDialog({
    this.image,
    required this.context,
    required this.title,
    this.titleTextStyle,
    this.message,
    this.messageTextStyle,
    this.dialogMargin,
    this.dialogPadding,
    this.dialogDecoration,
    required this.primaryActionTitle,
    this.primaryActionTextStyle,
    this.primaryActionButtonStyle,
    this.primaryTapAction,
    this.secondaryActionTitle,
    this.secondaryActionTextStyle,
    this.secondaryActionButtonStyle,
    this.secondaryTapAction,
  });

  Future show() async {
    return showDialog(
      useSafeArea: false,
      barrierDismissible: true,
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: dialogMargin ?? const EdgeInsets.all(20),
            padding: dialogPadding ?? const EdgeInsets.all(20),
            decoration: dialogDecoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (image != null)
                  Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: image!,
                  ),
                Text(
                  title,
                  style: titleTextStyle ??
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (message != null)
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: messageTextStyle ??
                          const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (secondaryActionTitle != null)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => secondaryTapAction,
                            style: secondaryActionButtonStyle ??
                                ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    )),
                            child: Text(
                              secondaryActionTitle ?? "Cancel",
                              style: secondaryActionTextStyle ??
                                  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                      if (secondaryActionTitle != null)
                        const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => primaryTapAction,
                          style: primaryActionButtonStyle ??
                              ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                          child: Text(
                            primaryActionTitle,
                            style: primaryActionTextStyle ??
                                const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
