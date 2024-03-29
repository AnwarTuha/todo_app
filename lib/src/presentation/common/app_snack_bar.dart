import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

SnackBar buildAppSnackBar({
  required Color bgColor,
  required String msg,
  required Color txtColor,
  Key? key,
  bool isFloating = true,
}) {
  return SnackBar(
    key: key,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: txtColor,
            fontSize: AppFontSizes.font_size_14,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
    margin: isFloating
        ? const EdgeInsets.symmetric(
            horizontal: AppMargin.margin_16,
            vertical: AppMargin.margin_32,
          )
        : null,
    // padding: EdgeInsets.symmetric(vertical: AppPadding.padding_2),
    elevation: 12,
    behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(isFloating ? 8 : 0),
    ),
    backgroundColor: bgColor,
  );
}
