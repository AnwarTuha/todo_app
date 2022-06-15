import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/blocs/sign_up/sign_up_bloc.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/helpers.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/presentation/common/app_snack_bar.dart';
import 'package:todo_app/src/presentation/views/sign_in/widgets/submit_button.dart';

import 'widgets/info_fields.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailEditingController =
        TextEditingController();
    final TextEditingController _passwordEditingController =
        TextEditingController();
    final TextEditingController _confirmPasswordEditingController =
        TextEditingController();
    final TextEditingController _nameEditingController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        systemOverlayStyle: getStatusBarStyle(),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: AppColors.appBlack),
        centerTitle: true,
        title: Text(
          'Sign up',
          style: TextStyle(
            color: AppColors.completelyBlack,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding_18,
            vertical: AppPadding.padding_20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Enter your info below',
                style: TextStyle(
                  height: 1.4,
                  fontSize: AppFontSizes.font_size_22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 35.0),
              InfoFields(
                nameController: _nameEditingController,
                emailController: _emailEditingController,
                passwordController: _passwordEditingController,
              ),
              const SizedBox(height: 45.0),
              _buildSubmitButton(_nameEditingController,
                  _emailEditingController, _passwordEditingController),
            ],
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is SignUpLoading) {
          return SubmitButton(
              buttonTitle: 'Saving...', onTap: () {}, isLoading: true);
        }

        if (state is SignUpDone) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              buildAppSnackBar(
                bgColor: AppColors.appBlue,
                txtColor: AppColors.white,
                msg: 'Sign in to continue.',
                isFloating: false,
              ),
            );
            NavigationService.instance.navigateNamedAndRemoveUntil(
              AppRouterPaths.signInPageRoute,
              AppRouterPaths.signInPageRoute,
              context,
            );
          });
        }

        if (state is SignUpError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              buildAppSnackBar(
                bgColor: AppColors.errorRed,
                txtColor: AppColors.white,
                msg: 'Something went wrong. Try Again.',
                isFloating: false,
              ),
            );
          });
        }

        return SubmitButton(
            buttonTitle: 'Submit',
            onTap: () {
              if (nameController.text.isEmpty ||
                  passwordController.text.isEmpty ||
                  emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  buildAppSnackBar(
                    bgColor: AppColors.errorRed,
                    txtColor: AppColors.white,
                    msg: 'Please fill all the required fields.',
                    isFloating: false,
                  ),
                );
              } else {
                BlocProvider.of<SignUpBloc>(context).add(
                  SignUp(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
              }
            });
      },
    );
  }
}
