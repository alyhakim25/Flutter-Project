import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageFrame extends StatelessWidget {
  final Widget children;
  final bool scrollable;
  PageFrame({required this.children, this.scrollable = false});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      backgroundColor: const Color(0xFFF6F0D4),
      body: scrollable
          ? SingleChildScrollView(
              child: children,
            )
          : children,
    ));
  }
}
