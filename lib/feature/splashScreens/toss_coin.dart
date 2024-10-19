import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TossCoinSplash extends StatefulWidget {
  const TossCoinSplash({super.key});

  @override
  State<TossCoinSplash> createState() => _TossCoinSplashState();
}

class _TossCoinSplashState extends State<TossCoinSplash> {
  @override
  void initState() {
    super.initState();
    goToMainPage();
  }

  void goToMainPage() {
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed("/tossCoin");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                "lib/assets/flipCoin.jpg",
              ),
            ),
          )
        ],
      ),
    );
  }
}
