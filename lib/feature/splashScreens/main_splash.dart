// ignore_for_file: use_build_context_synchronously

import 'package:crick_hub/core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainSplash extends ConsumerStatefulWidget {
  const MainSplash({super.key});

  @override
  ConsumerState<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends ConsumerState<MainSplash> {
  @override
  void initState() {
    super.initState();
    visitDashBoard();
  }

  void visitDashBoard() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      bool isLogin = await ref.read(storageProvider).isLogin();
      !isLogin ? context.goNamed('/authentication') : context.goNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50,
            ),
            color: Colors.black,
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Center(
            child: Image(
              image: const AssetImage(
                "lib/assets/images/crickbud.png",
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
