import 'package:flutter/material.dart';
import 'package:workmore/frame/body/body_frame.dart';
import 'package:workmore/frame/header/header_frame.dart';
import 'package:workmore/frame/page/page_frame.dart';
import 'package:workmore/ui/body/profile_body.dart';
import 'package:workmore/ui/header/profile_header.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return PageFrame(
        children: Column(children: [
      HeaderFrame(bottom: 30, children: ProfileHeader()),
      BodyFrame(
          top: 0,
          children: ProfileBody(height: screenHeight, width: screenWidth))
    ]));
  }
}
