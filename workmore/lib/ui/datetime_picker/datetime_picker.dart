import 'package:flutter/material.dart';
import 'package:workmore/component/textbox/textbox.dart';

class DatetimePicker extends StatelessWidget {
  final double deviceWidth;
  final Function onPressed;
  final String buttonText;
  final String textBoxLabel;
  final TextEditingController? controller;
  DatetimePicker(
      {required this.buttonText,
      required this.textBoxLabel,
      required this.deviceWidth,
      required this.onPressed,
      this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextBox(
        label: textBoxLabel,
        width: deviceWidth - 200,
        controller: controller,
      ),
      ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: Text(buttonText))
    ]));
  }
}
