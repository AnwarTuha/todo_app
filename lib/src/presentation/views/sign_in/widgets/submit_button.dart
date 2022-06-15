import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/presentation/common/app_loading.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {Key? key,
      required this.buttonTitle,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  final String buttonTitle;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: !isLoading ? AppColors.appRed : AppColors.grey.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.padding_14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonTitle,
              style: TextStyle(
                fontSize: AppFontSizes.font_size_14,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 10.0),
            !isLoading
                ? Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 10,
                  )
                : const AppLoading(size: 15),
          ],
        ),
      ),
    );
  }
}
