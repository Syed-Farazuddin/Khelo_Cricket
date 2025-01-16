import 'package:crick_hub/common/constants/constants.dart';
import 'package:flutter/material.dart';

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
            widget.image != "" || widget.image != "null"
                ? Constants.dummyImage
                : widget.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // Image has loaded
                return child;
              } else {
                // Image is still loading
                double progress = loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1);
                return Center(
                  child: CircularProgressIndicator(
                    // Show progress indicator with current progress
                    value: progress,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) => Image.asset(''),
          ),
        ),
      ),
    );
  }
}
