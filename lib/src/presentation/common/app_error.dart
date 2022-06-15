import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/helpers.dart';

class AppError extends StatelessWidget {
  const AppError({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.padding_18),
      width: ScreenUtil(context: context).getScreenWidth() * 0.8,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Something went wrong.',
            style: TextStyle(
                fontSize: AppFontSizes.font_size_18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          const Text('Check your internet connection'),
          const SizedBox(height: 18.0),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.appRed,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 0),
                      color: AppColors.completelyBlack.withOpacity(0.2),
                      blurRadius: 6)
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.padding_32,
                vertical: AppPadding.padding_8,
              ),
              child: Text(
                'Try again',
                style: TextStyle(
                  fontSize: AppFontSizes.font_size_14,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
