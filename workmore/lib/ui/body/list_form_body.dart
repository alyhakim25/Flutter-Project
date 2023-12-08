import 'package:flutter/material.dart';
import 'package:workmore/component/recylerview/recylerview_container.dart';
import 'package:workmore/component/recylerview/recylerview_content.dart';

import '../card/leave_form_card.dart';
import '../card/overtime_form_card.dart';
import '../card/permit_form_card.dart';
import '../card/reimburse_form_card.dart';

class ListFormBody extends StatelessWidget {
  final List<dynamic> formList;
  final double height;
  final String formType;
  final String idUser;
  ListFormBody(
      {required this.idUser,
      required this.height,
      required this.formList,
      required this.formType});

  Widget ListFormUI(String formType, int index, List<dynamic> data) {
    if (formType.toLowerCase() == "leave") {
      return LeaveFormCard(
          start_date: data[index]["start_date"],
          end_date: data[index]["end_date"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "permit") {
      return PermitFormCard(
          start_date: data[index]["start_date"],
          time_in: data[index]["time_in"],
          time_out: data[index]["time_out"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "overtime") {
      return OvertimeFormCard(
          start_date: data[index]["start_date"],
          time_out: data[index]["time_out"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "reimburse") {
      return ReimburseFormCard(
          start_date: data[index]["start_date"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (RecylerViewContainer(
      data: formList,
      height: height,
      children: ((index, data) {
        return RecylerViewContent(
            title: formList[(formList.length - 1) - index]["timestamp"],
            index: index,
            data: data,
            children: ((index, data) {
              return ListFormUI(formType, index, data);
            }));
      }),
      onRefresh: () {},
    ));
  }
}
