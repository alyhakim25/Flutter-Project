import 'package:flutter/widgets.dart';

class HeaderFrame extends StatelessWidget {
  final Widget children;
  final double left;
  final double right;
  final double bottom;
  final double top;
  HeaderFrame({required this.children, this.top = 40, this.left = 0, this.right = 0, this.bottom = 0});

  @override
  Widget build(BuildContext context) {
    return (Container(
        alignment: Alignment.topCenter,
        padding:  EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: children));
  }
}
