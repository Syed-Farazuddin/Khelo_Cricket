import 'dart:typed_data';

import 'package:crick_hub/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageSelector extends StatefulWidget {
  const CustomImageSelector({super.key});

  @override
  State<CustomImageSelector> createState() => _CustomImageSelectorState();
}

class _CustomImageSelectorState extends State<CustomImageSelector> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 12,
      ),
      child: GestureDetector(
        onTap: () {
          onSelectImage();
        },
        child: image == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Select Image"),
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(
                    "${Constants.assetSvgpath}image_upload.svg",
                  ),
                ],
              )
            : Image.memory(
                image!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  void onSelectImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) {
      return;
    }
    Uint8List bytes = await file.readAsBytes();
    setState(() {
      image = bytes;
    });
  }
}
