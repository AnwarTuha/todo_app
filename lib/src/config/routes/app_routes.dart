import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenArguments {
  final Map<String, dynamic> args;

  ScreenArguments({required this.args});
}

class AppRouterPaths {
  static const String splashPageRoute = '/splash';
  static const String signInPageRoute = '/sign-in';
  static const String signUpPageRoute = '/sign-up';
  static const String homePageRoute = '/home-page';
  static const String createTaskRoute = '/create-task';
  static const String searchTasksRoute = '/search-tasks';
  static const String editTaskRoute = '/edit-task';

  //ROUTE OBSERVER
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
}

class AppRoutes {
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   //BUILDER
  //   WidgetBuilder builder;
  //
  //   switch (settings.name) {
  //     case AppRouterPaths.homePageRoute:
  //       builder = (context) => const HomePageView();
  //       break;
  //     case AppRouterPaths.signInPageRoute:
  //       builder = (context) => const SignInView();
  //       break;
  //     case AppRouterPaths.signUpPageRoute:
  //       builder = (context) => const SignUpView();
  //       break;
  //     default:
  //       return MaterialPageRoute(
  //         builder: (context) => Scaffold(
  //           body: Center(child: Text('No route defined for ${settings.name}')),
  //         ),
  //       );
  //   }
  //
  //   //BUILDER  WITH ROUTERS
  //   return _cupertinoRoute(builder, settings);
  // }

  static Route<dynamic> _cupertinoRoute(
      WidgetBuilder builder, RouteSettings settings) {
    return CupertinoPageRoute(builder: builder, settings: settings);
  }

  static Route<dynamic> _materialRoute(WidgetBuilder builder) {
    return MaterialPageRoute(builder: builder);
  }
}
