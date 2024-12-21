import 'package:crick_hub/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({super.key, required this.image});
  final String image;
  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.network(
            widget.image == "" ? Constants.dummyImage : widget.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) => Center(
              child: LoadingAnimationWidget.bouncingBall(
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
