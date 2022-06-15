import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/bloc/blocs/user_auth/user_auth_bloc.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/core/utils/helpers.dart';
import 'package:todo_app/src/core/utils/navigation.dart';
import 'package:todo_app/src/presentation/common/app_snack_bar.dart';
import 'package:todo_app/src/presentation/views/sign_in/widgets/credential_inputs.dart';
import 'package:todo_app/src/presentation/views/sign_in/widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailEditingController =
        TextEditingController();
    final TextEditingController _passwordEditingController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        systemOverlayStyle: getStatusBarStyle(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Sign in',
          style: TextStyle(
            color: AppColors.completelyBlack,
            fontSize: AppFontSizes.font_size_16,
          ),
        ),
      ),
      body: BlocListener<UserAuthBloc, UserAuthState>(
        listener: (context, state) {
          if (state is UserAuthDone) {
            NavigationService.instance.navigateToReplacement(
              context,
              AppRouterPaths.homePageRoute,
            );
          }

          if (state is UserAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              buildAppSnackBar(
                bgColor: AppColors.errorRed,
                txtColor: AppColors.white,
                msg: 'Incorrect Email or Password.',
                isFloating: false,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.padding_18,
            vertical: AppPadding.padding_28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Sign in to manage your tasks',
                style: TextStyle(
                  height: 1.4,
                  fontSize: AppFontSizes.font_size_22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 35.0),
              CredentialInputs(
                emailController: _emailEditingController,
                passwordController: _passwordEditingController,
              ),
              const Expanded(child: SizedBox()),
              _buildSubmitButton(
                  _emailEditingController, _passwordEditingController),
              const SizedBox(height: 25.0),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: TextStyle(
                    color: AppColors.txtGrey,
                    fontSize: AppFontSizes.font_size_14,
                  ),
                  children: [
                    TextSpan(
                      text: ' Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        NavigationService.instance.navigateTo(AppRouterPaths.signUpPageRoute, context);
                        },
                      style: TextStyle(
                        color: AppColors.appRed,
                        fontSize: AppFontSizes.font_size_14,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildSubmitButton(TextEditingController emailController,
      TextEditingController passwordController) {
    return BlocBuilder<UserAuthBloc, UserAuthState>(
      builder: (context, state) {
        if (state is UserAuthLoading) {
          return SubmitButton(
            buttonTitle: 'Signing in...',
            onTap: () {},
            isLoading: true,
          );
        }

        return SubmitButton(
          buttonTitle: 'Sign in',
          onTap: () {
            if (emailController.text.isEmpty ||
                passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                buildAppSnackBar(
                  bgColor: AppColors.errorRed,
                  txtColor: AppColors.white,
                  msg: 'Please enter required fields.',
                  isFloating: false,
                ),
              );
            } else {
              BlocProvider.of<UserAuthBloc>(context).add(
                AuthenticateUser(
                  email: emailController.text.trim(),
                  password: passwordController.text,
                ),
              );
            }
          },
        );
      },
    );
  }
}
