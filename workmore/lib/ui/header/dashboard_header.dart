import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workmore/component/button/image_button.dart';

class DashboardHeader extends StatelessWidget {
  DashboardHeader();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "Alyhakim",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          ImageButton(
            imageSrc: "assets/image/my_photo.jpg",
            height: 80,
            width: 80,
            onPressed: () {},
            circular: true,
          )
        ],
      ),
    ));
  }
}
