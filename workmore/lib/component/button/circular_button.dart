import 'package:flutter/material.dart';

typedef void OnPressedCallback();

class CircularButton extends StatefulWidget {
  final Function onPressed;
  final Widget children;
  final double width;
  final double height;
  CircularButton(
      {required this.width,
      required this.height,
      required this.onPressed,
      required this.children});

  @override
  _CircularButton createState() => _CircularButton();
}

class _CircularButton extends State<CircularButton> {
  bool isbuttonPressed = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      margin: const EdgeInsets.only(top: 50),
      width: widget.width,
      height: widget.height,
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
            opacity: isbuttonPressed ? 0.8 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Container(
                  width: widget.width-50,
                  height: widget.height-50,
                  decoration: BoxDecoration(
                      color: isbuttonPressed
                          ? const Color.fromARGB(255, 118, 211, 252)
                              .withOpacity(0.7)
                          : const Color.fromARGB(255, 118, 211, 252),
                      borderRadius: BorderRadius.circular(20)),
                  child: widget.children,
                ))),
      ),
    ));
  }
}
