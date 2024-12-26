import 'package:crick_hub/common/routes/routes.dart';
import 'package:crick_hub/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load();
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
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CrickHub',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                primary: AppColors
                    .background, // Custom primary color in color scheme
                secondary: AppColors.background, // Custom secondary color
                surface: AppColors.background, // Custom surface color
              ),
        ),
        routerConfig: Routes.router,
      ),
    );
  }
}
