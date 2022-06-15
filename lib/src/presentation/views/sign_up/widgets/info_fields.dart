import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class InfoFields extends StatefulWidget {
  const InfoFields({
    Key? key,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;

  @override
  State<InfoFields> createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildNameInput(),
        const SizedBox(height: 18.0),
        buildEmailInput(),
        const SizedBox(height: 18.0),
        buildPasswordInput(),
      ],
    );
  }

  buildNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: TextStyle(
            color: AppColors.appBlack,
            fontWeight: FontWeight.w400,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: widget.nameController,
          textAlignVertical: TextAlignVertical.center,
          autofocus: true,
          cursorColor: AppColors.appRed,
          onChanged: (key) {},
          maxLength: 35,
          readOnly: false,
          buildCounter: buildCounter,
          keyboardType: TextInputType.text,
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: AppColors.appBlack,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.w500,
          ),
          decoration: fieldDecoration().copyWith(),
        ),
      ],
    );
  }

  buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            color: AppColors.appBlack,
            fontWeight: FontWeight.w400,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: widget.emailController,
          textAlignVertical: TextAlignVertical.center,
          autofocus: true,
          cursorColor: AppColors.appRed,
          onChanged: (key) {},
          maxLength: 35,
          readOnly: false,
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: AppColors.appBlack,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.w500,
          ),
          decoration: fieldDecoration().copyWith(
            counterText: '',
          ),
        ),
      ],
    );
  }

  buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: AppColors.appBlack,
            fontWeight: FontWeight.w400,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          controller: widget.passwordController,
          textAlignVertical: TextAlignVertical.center,
          autofocus: true,
          cursorColor: AppColors.appRed,
          onChanged: (key) {},
          maxLength: 35,
          obscureText: _isObscure,
          readOnly: false,
          keyboardType: TextInputType.text,
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: AppColors.appBlack,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.w500,
          ),
          decoration: fieldDecoration().copyWith(
            counterText: '',
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.appRed,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return '';
    }

    return '';
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
}
