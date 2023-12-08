// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_conditional_assignment, unused_import, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:workmore/class/attendance_class.dart';
import 'package:workmore/frame/body/body_frame.dart';
import 'package:workmore/frame/header/header_frame.dart';
import 'package:workmore/frame/page/page_frame.dart';
import 'package:workmore/model/DateTime_model.dart';
import 'package:workmore/ui/body/attendance_body.dart';
import 'package:workmore/ui/card/attendance_card.dart';
import 'package:workmore/component/recylerview/recylerview_container.dart';
import 'package:workmore/component/recylerview/recylerview_content.dart';
import 'package:workmore/ui/header/attendance_header.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Attendance();
  }
}

class _Attendance extends State<Attendance> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    getAbsenData().then((value) => setState(() {
          dataList = value;
        }));
    status("08:00:00");
  }

  @override
  Widget build(BuildContext context) {
    return PageFrame(
        children: Column(
      children: [
        HeaderFrame(children: AttendanceHeader()),
        BodyFrame(top: 0, children: AttendanceBody(dataList: dataList))
      ],
    ));
  }
}
