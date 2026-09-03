import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o/features/game/presentation/screens/game_screen.dart';
import 'package:x_o/features/profile/presentation/screens/profile_screen.dart';
import 'package:x_o/features/room/presentation/screens/room_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';

import '../../features/game/presentation/bloc/game_bloc.dart';
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
      case Routes.waitingRoom:
        return _buildRoute(
          const RoomScreen(
            roomCode: 'DWWF23S',
            roomName: 'MYROOM',
            hostName: 'abdou',
          ),
          settings,
        );
      case Routes.profileScreen:
        return _buildRoute(
          //TODO: remove dummy data
          const ProfileScreen(
            registryId: "V_213",
            callsign: 'TESTONE',
            roleLabel: 'ADMIN',
            level: 40,
            winRatePercent: (123 / (123 + 23)) * 100,
            victories: 123,
            defeats: 23,
            stalemates: 2,
          ),
          settings,
        );
      case Routes.gameScreen:
        return _buildRoute(
          //TODO: remove dummy data
          BlocProvider<GameBloc>(
            create: (context) => GameBloc(),
            child: GameScreen(
              playerXName: "abdou",
              playerOName: "ali",
              scoreX: 0,
              scoreO: 0,
              isMyTurn: true,
              currentTurnSymbol: "X",
              turnStartedAt: DateTime.now(),
              board: List.filled(9, null),
              mySymbol: "X",
              onCellTap: (index) {},
            ),
          ),
          settings,
        );
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
