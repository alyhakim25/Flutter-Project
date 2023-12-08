import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final double width;
  final TextEditingController? controller;
  final String label;
  TextBox({required this.label, required this.width, this.controller});
  //deviceWidth - 200
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (SizedBox(
      width: width,
      height: 50,
      child: TextField(
        controller: controller,
        readOnly: true,
        enabled: false,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          contentPadding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
        ),
      ),
    ));
  }
}
