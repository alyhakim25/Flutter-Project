import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Widget? buttonChild;
  MyButton({
    Key? key,
    required this.width,
    this.height = 40,
    this.buttonChild,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: onPressed,
      child: buttonChild != null ? buttonChild : Text(text),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          primary: Color.fromARGB(255, 255, 160, 71)),
    );
  }
}
