import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workmore/api/api.dart';

Future<bool> sendFormData(
    BuildContext contex,
    String id,
    String form,
    String reason,
    String approval1,
    String approval2,
    String timeInValue,
    String timeOutValue,
    String startDateValue,
    String endDateValue,
    int usedLeave,
    Map<String, dynamic>? LeaveList) async {
  MyApi myFormApi = MyApi('form', 'save', {
    'id': id,
    'form_type': form,
    'reason': reason,
    'approval1': approval1,
    'approval2': approval2,
    'time_in': timeInValue,
    'time_out': timeOutValue,
    'start_date': startDateValue,
    'end_date': endDateValue
  });
  final response1 = await myFormApi.Post();
  if (!response1) return false;
  MyApi myLeaveApi = MyApi('form', 'save', {
    'id': id,
    'annual_leave': (LeaveList!["annual_leave"] - usedLeave).toString(),
    'advanced_leave': (LeaveList!["advanced_leave"] + usedLeave).toString()
  });
  final response2 = await myLeaveApi.Post();

  if (response2) {
    return true;
  } else {
    return false;
  }
}

Future getLeaveData(String id) async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Get();

  if (response.length != 0) {
    return response["data"];
  } else {
    return {};
  }
}

Future<int> calculateDate(String start, String end) async {
  return DateFormat("yyyy-MM-dd")
      .parse(end)
      .difference(DateFormat("yyyy-MM-dd").parse(start))
      .inDays;
}

List<String> parsingParam(String data) {
  return data.split(";");
  /*
    setState(() {
      documentNumber = parts[2];
      formType = parts[1];
      idUser = int.parse(parts[0]);
    });
    */
}

Future<String> selectDate(BuildContext context, DateTime initDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null && picked != initDate) {
    return DateFormat('yyyy-MM-dd').format(picked).toString();
  } else {
    return DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  }
}

Future getFormData(String idUser, String formType) async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Get();

  if (response.length != 0) {
    return response["data"];
  } else {
    return {};
  }
}
