import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RectangularButton extends StatefulWidget {
  final Function onPressed;
  final Widget children;
  final double width;
  final double height;
  RectangularButton(
      {required this.width,
      required this.height,
      required this.onPressed,
      required this.children});

  @override
  _RectangularButton createState() => _RectangularButton();
}

class _RectangularButton extends State<RectangularButton> {
  bool isbuttonPressed = false;
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return (Container(
        child: GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      onTapDown: (tapDownDetails) {
        setState(() {
          isbuttonPressed = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isbuttonPressed = false;
        });
      },
      onTapUp: (tapUpDetails) {
        setState(() {
          isbuttonPressed = false;
        });
      },
      child: AnimatedOpacity(
          opacity: isbuttonPressed ? 0.7 : 0.9,
          duration: const Duration(milliseconds: 500),
          child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: isbuttonPressed
                      ? Colors.red.withOpacity(0.7)
                      : Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20)),
              child: widget.children)),
    )));
  }
}
