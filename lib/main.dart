import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneybox_task/core/database/database_manager.dart';
import 'package:moneybox_task/core/di/dependency_container.dart';
import 'package:moneybox_task/core/route_config/app_route.dart';
import 'package:moneybox_task/core/theme/app_theme.dart';
import 'package:moneybox_task/core/theme/bloc/theme_bloc.dart';

import 'core/manager/shared_prefs_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.instance.database;
  await setupInjector();
  await SharedPrefsManager.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ThemeBloc())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: AppRoute.route,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
