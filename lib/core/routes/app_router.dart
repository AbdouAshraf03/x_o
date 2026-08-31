import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import 'routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return _buildRoute(const HomeScreen(), settings);
      case Routes.regiest:
        return _buildRoute(const AuthScreen(), settings);
      case Routes.login:
        return _buildRoute(const AuthScreen(), settings);
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // static void navigateTo(
  //   BuildContext context,
  //   String routeName, {
  //   Object? arguments,
  // }) {
  //   Navigator.pushNamed(context, routeName, arguments: arguments);
  // }

  // static void navigateAndReplace(
  //   BuildContext context,
  //   String routeName, {
  //   Object? arguments,
  // }) {
  //   Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  // }

  // static void navigateAndRemoveUntil(
  //   BuildContext context,
  //   String routeName, {
  //   Object? arguments,
  // }) {
  //   Navigator.pushNamedAndRemoveUntil(
  //     context,
  //     routeName,
  //     (route) => false,
  //     arguments: arguments,
  //   );
  // }

  // static void goBack(BuildContext context) {
  //   Navigator.pop(context);
  // }
}
