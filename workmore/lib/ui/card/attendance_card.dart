import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workmore/class/attendance_class.dart';

class AttendanceCard extends StatelessWidget {
  final List<dynamic> data;
  final int index;
  AttendanceCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 95,
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 5),
                margin: const EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 2.0)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/clock_in1.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      data[(data.length - 1) - index]["time_in"],
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w800),
                    )
                  ],
                )),
            Container(
                width: 95,
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, left: 3, right: 5),
                margin: const EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red, width: 2.0)),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/clock_out1.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: data[(data.length - 1) - index]["time_out"] ==
                                  null
                              ? 8
                              : 0),
                      child: Text(
                          data[(data.length - 1) - index]["time_out"] ??
                              '--:--:--',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w800)),
                    )
                  ],
                )),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: status(data[(data.length - 1) - index]["time_in"]) ==
                            "On-Time"
                        ? Colors.green.withOpacity(0.9)
                        : const Color.fromARGB(255, 245, 67, 67)
                            .withOpacity(0.9),
                  ),
                  margin: const EdgeInsets.only(top: 10, right: 30),
                  width: 70,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    status(data[(data.length - 1) - index]["time_in"]),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            "Working Time : " +
                timetaken(data[(data.length - 1) - index]["time_in"],
                    data[(data.length - 1) - index]["time_out"]),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              margin: const EdgeInsets.only(bottom: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[(data.length - 1) - index]["reason"] == null
                        ? "Reason: -"
                        : "Reason: " +
                            data[(data.length - 1) - index]["reason"],
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        ">",
                        style: TextStyle(fontSize: 30, color: Colors.green),
                      ))
                ],
              )),
        )),
      ],
    ));
  }
}
