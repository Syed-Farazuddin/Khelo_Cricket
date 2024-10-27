import 'package:crick_hub/feature/dashboard/presentation/dashboard.dart';
import 'package:crick_hub/feature/flpCoin/presentation/pages/flip_coin.dart';
import 'package:crick_hub/feature/splashScreens/main_splash.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/start_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Khelo Cricket',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData.dark(),
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
      path: "/startTournament",
      name: "/startTournament",
      builder: (context, state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      path: "/startMatch",
      name: "/startMatch",
      builder: (context, state) {
        return const StartMatch();
      },
    ),
    GoRoute(
      path: "/tossCoin",
      name: "/tossCoin",
      builder: (context, state) {
        return const TossMyCoin();
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
