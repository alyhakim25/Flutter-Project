import 'package:flutter/material.dart';
import 'package:workmore/component/button/rectangular_button.dart';
import 'package:workmore/frame/body/body_frame.dart';
import 'package:workmore/frame/header/header_frame.dart';
import 'package:workmore/frame/page/page_frame.dart';
import 'package:workmore/ui/body/form_body.dart';
import 'package:workmore/ui/button/form_button.dart';
import 'package:workmore/ui/header/form_header.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormPage();
  }
}

class _FormPage extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return PageFrame(
        children: Column(
      children: [
        HeaderFrame(children: FormHeader()),
        BodyFrame(top: 0, children: FormBody())
      ],
    ));
  }
}
