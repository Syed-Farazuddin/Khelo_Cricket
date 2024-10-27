import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/core/toaster/toaster.dart';

class TossMyCoin extends StatefulWidget {
  const TossMyCoin({super.key});

  @override
  State<TossMyCoin> createState() => _TossMyCoinState();
}

class _TossMyCoinState extends State<TossMyCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool showAnimation = false;
  bool _showFirstImage = true;
  int tossVal = 0;
  int duration = 1;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: duration), // Fixed duration
      vsync: this,
    );

    // Toggle between images at midpoints of rotation
    _controller.addListener(() {
      if ((_controller.value > 0.24 && _controller.value < 0.26) ||
          (_controller.value > 0.74 && _controller.value < 0.76)) {
        setState(() {
          _showFirstImage = !_showFirstImage;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showAnimation
              ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // Calculate y-axis rotation angle in radians
                      double angle = _controller.value * pi * 2;
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateX(angle),
                        child: _showFirstImage
                            ? Image.asset("lib/assets/images/customTail.png")
                            : Image.asset("lib/assets/images/customHead.png"),
                      );
                    },
                  ),
                )
              : tossVal == 0
                  ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset("lib/assets/images/customTail.png"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Image.asset("lib/assets/images/customHead.png"),
                    ),
          const SizedBox(height: 60),
          Custombutton(
            onTap: tossACoin,
            title: "Toss",
          )
        ],
      ),
    );
  }

  void tossACoin() {
    // Get random toss result
    tossVal = Random().nextInt(2);

    setState(() {
      _showFirstImage = tossVal == 0; // Update to initial image
    });
    debugPrint("tossVal.toString()");
    showAnimation = true;
    debugPrint(tossVal.toString());
    // Run animation with a timer to stop after 3 seconds
    _controller.repeat();
    Timer(const Duration(seconds: 3), () {
      _controller.stop();
      setState(() {
        showAnimation = false;
      });
      Toaster.onSuccess(
          message: "Your toss value is ${tossVal == 0 ? "Tails" : "Heads"}");
    });
  }
}
