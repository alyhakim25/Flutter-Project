import 'package:flutter/material.dart';

class MyImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final double imgHeight;
  final double imgWidth;

  MyImageButton(
      {required this.imagePath,
      required this.onPressed,
      this.imgHeight = 40,
      this.imgWidth = 40});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      borderRadius: BorderRadius.circular((imgWidth / 2 + imgHeight / 2) / 2),
      onTap: onPressed,
      child: Image.asset(
        imagePath,
        width: imgWidth, // Set the width and height according to your needs
        height: imgHeight,
      ),
    );
  }
}
