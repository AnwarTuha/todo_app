import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({Key? key, required this.titleTextEditingController})
      : super(key: key);

  final TextEditingController titleTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: TextStyle(
            color: AppColors.appBlack,
            fontWeight: FontWeight.w400,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: titleTextEditingController,
          textAlignVertical: TextAlignVertical.center,
          autofocus: false,
          cursorColor: AppColors.appRed,
          onChanged: (key) {},
          maxLength: 25,
          readOnly: false,
          keyboardType: TextInputType.text,
          buildCounter: buildCounter,
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: AppColors.appBlack,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.w500,
          ),
          decoration: fieldDecoration(),
        ),
      ],
    );
  }

  Widget buildCounter(
    context, {
    required currentLength,
    maxLength,
    required isFocused,
  }) {
    return Text(
      '$currentLength/$maxLength',
      style: TextStyle(
        color: AppColors.appRed,
        fontSize: AppFontSizes.font_size_10,
      ),
    );
  }

  InputDecoration fieldDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding_8,
        vertical: AppPadding.padding_16,
      ),
      errorStyle: TextStyle(
        fontSize: AppFontSizes.font_size_12,
        color: AppColors.errorRed,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: AppColors.lightGrey.withOpacity(0.4),
      border: InputBorder.none,
      focusColor: AppColors.appRed,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: '',
      hintStyle: TextStyle(
        color: AppColors.txtGrey,
        fontSize: AppFontSizes.font_size_14,
      ),
    );
  }
}
