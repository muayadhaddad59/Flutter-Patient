import 'package:flutter/material.dart';

import 'package:patient/view/navBar/nav_bar.dart';

class Routes {
  static const String init = "/";
  static const String signup = "/signup";
  static const String forgetPassword = "/forgetPassword";
  static const String mainScren = "/mainScreen";
  static const String login = "/login";
  static const String adminMainScreen = "/adminMainScreen";
}

class AppRoutes {
  static Route? onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.init:
        return MaterialPageRoute(
          builder: (context) {
            return const NavBar();
          },
        );

      default:
    }
    return null;
  }
}
