import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Widget ChildrenWidget(int index, List<dynamic> data);

class RecylerViewContainer extends StatelessWidget {
  final ChildrenWidget children;
  final List<dynamic> data;
  final double height;
  final Function onRefresh;
  RecylerViewContainer(
      {required this.data, required this.height, required this.children, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
        height: height,
        child: RefreshIndicator(
            onRefresh: () async {onRefresh();},
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return children(index, data);
                })))));
  }
}
