import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageButton extends StatelessWidget {
  final String imageSrc;
  final double height;
  final double width;
  final bool circular;
  final Function onPressed;
  ImageButton(
      {required this.imageSrc,
      required this.height,
      required this.width,
      required this.onPressed,
      this.circular = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: circular? BoxShape.circle : BoxShape.rectangle,
      ),
      child: InkWell(
        radius: width + 30,
        customBorder: const CircleBorder(),
        onTap: () {
          onPressed();
        },
        child: Ink(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: circular
                  ? BorderRadius.circular(
                      width > height ? width / 2 : height / 2)
                  : BorderRadius.zero,
              child: Image.asset(
                imageSrc,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
