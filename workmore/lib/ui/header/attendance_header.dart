import 'package:flutter/widgets.dart';

class AttendanceHeader extends StatelessWidget {
  AttendanceHeader();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 60),
                alignment: Alignment.center,
                child: const Text(
                  "Attendance",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/image/setting.png",
                width: 30,
                height: 30,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
