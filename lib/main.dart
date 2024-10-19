import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:khelo_cricket/feature/dashboard/presentation/dashboard.dart';
import 'package:khelo_cricket/feature/flpCoin/presentation/pages/flip_coin.dart';
import 'package:khelo_cricket/feature/splashScreens/main_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // bool isDarkMode =

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Khelo Cricket',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData.dark(),
      // themeMode: themeMode,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/home",
      name: "/home",
      builder: (context, state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      path: "/tossCoin",
      name: "/tossCoin",
      builder: (context, state) {
        return const TossACoin();
      },
    ),
    GoRoute(
      path: "/splash",
      name: "/splash",
      builder: (context, state) {
        return const MainSplash();
      },
    ),
    GoRoute(
      path: "/getNumber",
      name: "/getNumber",
      builder: (context, state) {
        return const DashboardPage();
      },
    ),
  ],
);
