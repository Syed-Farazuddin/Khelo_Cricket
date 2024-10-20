import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({super.key});

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  @override
  void initState() {
    super.initState();
    visitDashBoard();
  }

  void visitDashBoard() {
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed("/home");
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
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Center(
            child: Image(
              image: const AssetImage(
                "lib/assets/images/cricket.jpg",
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
