import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:workmore/class/dashboard_class.dart';
import 'package:workmore/frame/body/body_frame.dart';
import 'package:workmore/frame/header/header_frame.dart';
import 'package:workmore/frame/page/page_frame.dart';
import 'package:workmore/ui/body/dashboard_body.dart';
import 'package:workmore/ui/header/dashboard_header.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  String _timeString = '';
  String _dateString = '';
  String dateData = "";
  String address = "Loading Collecting Data";
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE, d MMM;HH:mm:ss').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      checkGPS(context, mounted);
      getPosition().then(((value) {
        setState(() {
          address = value;
        });
      }));
      _updateTime();
      Timer.periodic(
          const Duration(seconds: 1), (Timer t) => _updateTimePeriodically());
    }
  }

  Future<void> _updateTime() async {
    if (mounted) {
      final DateTime now = DateTime.now();
      final String formattedDateTime = _formatDateTime(now);
      final String formattedDate = _formatDate(now);
      setState(() {
        var timeFormat = formattedDateTime.split(';');
        _timeString = timeFormat[1];
        _dateString = timeFormat[0];
        dateData = formattedDate;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateTimePeriodically() {
    _updateTime();
  }

  @override
  Widget build(BuildContext context) {
    return (PageFrame(
        scrollable: true,
        children: Column(
          children: [
            HeaderFrame(left: 20, right: 20, children: DashboardHeader()),
            BodyFrame(
                top: 40,
                children: DashboardBody(
                  time: _timeString,
                  day: _dateString,
                  date: dateData,
                  address: address,
                ))
          ],
        )));
  }
}
