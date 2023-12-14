import 'package:flutter/material.dart';

typedef void OnValueChange(String value);

class TextBox extends StatefulWidget {
  final String labelText;
  final OnValueChange? onChange;
  final TextEditingController controller;
  final bool obscureText;
  final double width;

  const TextBox({
    Key? key,
    required this.width,
    required this.labelText,
    required this.controller,
    this.onChange,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _TextBox createState() => _TextBox();
}

class _TextBox extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: (value) {
          widget.onChange!(value);
        },
        decoration: InputDecoration(
            labelText: widget.labelText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: 8, bottom: 8, top: 8)),
      ),
    );
  }
}
