import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo_app/src/config/routes/app_routes.dart';
import 'package:todo_app/src/core/utils/helpers.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkIfUserLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void checkIfUserLoggedIn() async {
    bool isUserLoggedIn = await AuthenticationUtils.isUserLoggedIn();
    FlutterNativeSplash.remove();
    if (isUserLoggedIn) {
      Navigator.popAndPushNamed(context, AppRouterPaths.homePageRoute);
    } else {
      Navigator.popAndPushNamed(context, AppRouterPaths.signInPageRoute);
    }
  }
}
