import 'package:flutter/material.dart';
import 'package:workmore/task.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:workmore/page/dashboard.dart';
import 'package:workmore/page/attendance.dart';
import 'package:workmore/page/form.dart';
import 'package:workmore/page/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Navigation();
  }
}

class _Navigation extends State<Navigation> {
  int currentPageIndex = 2;
  @override
  void initState() {
    super.initState();
  }

  void currentPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: currentPageIndex,
        items: [
          TabItem(
            icon: Image.asset(
              'assets/image/clipboard.png',
              scale: 13,
            ),
            title: 'Task',
            isIconBlend: false,
          ),
          TabItem(
            icon: Image.asset(
              'assets/image/calendar.png',
              scale: 13,
            ),
            title: 'Attendance',
            isIconBlend: false,
          ),
          TabItem(
            icon: Image.asset(
              'assets/image/fingerprint.png',
              scale: 13,
            ),
            title: 'Absent',
            isIconBlend: false,
          ),
          TabItem(
            icon: Image.asset(
              'assets/image/paper.png',
              scale: 13,
            ),
            title: 'Form',
            isIconBlend: false,
          ),
          TabItem(
            icon: Image.asset(
              'assets/image/user.png',
              scale: 13,
            ),
            title: 'Profile',
            isIconBlend: false,
          ),
        ],
        onTap: (int i) => {currentPage(i)},
        activeColor: Colors.amber,
      ),
      body: <Widget>[
        const Task(),
        const Attendance(),
        const Dashboard(),
        const FormPage(),
        const Profile(),
      ][currentPageIndex],
    );
  }
}
