import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularImage extends StatelessWidget {
  final String imageSrc;
  final double width;
  final double height;
  final bool imgNetwork;
  CircularImage(
      {required this.imageSrc,
      required this.height,
      required this.width,
      this.imgNetwork = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(width < height ? height / 2 : width / 2),
        child: imgNetwork
            ? Image.network(
                imageSrc,
                width: width,
                height: height,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              )
            : Image.asset(
                imageSrc,
                width: width,
                height: height,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
      ),
    ));
  }
}
