import 'package:flutter/material.dart';

class CreateFormHeader extends StatelessWidget {
  final String formType;
  final Map<String, dynamic> leaveData;
  CreateFormHeader({required this.formType, required this.leaveData});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(children: [
      Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 50, bottom: 20),
        child: Text(
          formType,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      formType == 'leave'
          ? Expanded(
              flex: 0,
              child: Container(
                  height: 70,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 50, right: 50, bottom: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border:
                          Border.all(color: const Color(0xFF000000), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Available Leave : ${leaveData != null ? leaveData["annual_leave"] : "0"}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Taken Leave : ${leaveData != null ? leaveData["advanced_leave"] : "0"}"),
                      ],
                    ),
                  )))
          : Container(),
    ]));
  }
}
