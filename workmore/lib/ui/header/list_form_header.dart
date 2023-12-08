import 'package:flutter/material.dart';

class ListFormHeader extends StatelessWidget {
  final String title;
  ListFormHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      title,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}
