
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Widget ChildrenWidget(int index, List<dynamic> data);

class RecylerViewContent extends StatelessWidget{
    final ChildrenWidget children;
    final List<dynamic> data;
    final int index;
    final String title;
    RecylerViewContent({required this.title,required this.index, required this.data,required this.children});

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenHeight = MediaQuery.of(context).size.height;

    return(
      ListTile(
        title: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontSize: 17),
            )),
        subtitle: SizedBox(
          height: 150,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(20)),
              child: children(index,data)),
        ))
        );
        }
        }