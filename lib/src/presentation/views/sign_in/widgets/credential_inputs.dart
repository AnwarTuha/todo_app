import 'package:flutter/material.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';

class CredentialInputs extends StatefulWidget {
  const CredentialInputs({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<CredentialInputs> createState() => _CredentialInputsState();
}

class _CredentialInputsState extends State<CredentialInputs> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildEmailInput(),
        const SizedBox(height: 18.0),
        buildPasswordInput(),
      ],
    );
  }

  Widget buildEmailInput() {
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
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
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

  Widget buildPasswordInput() {
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
          keyboardType: TextInputType.emailAddress,
          enabled: true,
          style: TextStyle(
            color: AppColors.appBlack,
            fontSize: AppFontSizes.font_size_16,
            fontWeight: FontWeight.w500,
          ),
          decoration: fieldDecoration().copyWith(
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
      counterText: "",
      hintStyle: TextStyle(
        color: AppColors.txtGrey,
        fontSize: AppFontSizes.font_size_14,
      ),
    );
  }
}
