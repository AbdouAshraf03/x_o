import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_o/core/theme/app_theme.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'features/game/presentation/bloc/game_bloc.dart';
import 'injection_container.dart';

void main() async {
  // await Firebase.initializeApp();

  await init();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => GameBloc())],
      child: const MyGame(),
    ),
  );
}

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.home,
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
