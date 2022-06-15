import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/src/config/themes/app_theme.dart';
import 'package:todo_app/src/data/datasources/local/app_hive_service.dart';

import 'constants.dart';

SystemUiOverlayStyle getStatusBarStyle() {
  return SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
}

class ScreenUtil {
  final BuildContext context;

  ScreenUtil({required this.context});

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }
}

class AuthenticationUtils {
  static Future<bool> isUserLoggedIn() async {
    if (AppHiveService.instance.appTokenBox.get(AppValues.appTokenKey) !=
        null) {
      return true;
    } else {
      ///USER IS NOT LOGGED IN
      return false;
    }
  }
}
