import 'package:flutter/widgets.dart';
import 'package:workmore/class/dashboard_class.dart';
import 'package:workmore/component/button/circular_button.dart';
import 'package:workmore/ui/button/dashboard_button.dart';

class DashboardBody extends StatelessWidget {
  final String time;
  final String day;
  final String date;
  final String address;
  DashboardBody(
      {required this.time,
      required this.day,
      required this.date,
      required this.address});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            time,
            style: const TextStyle(fontSize: 40),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            day,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        CircularButton(
            width: 200,
            height: 200,
            onPressed: () {
              getAbsenData(context, date, time);
            },
            children: DashboardButton()),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  "assets/image/placeholder.png",
                  width: 25,
                  height: 25,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 200,
                child: Text(
                  address,
                  style: const TextStyle(),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/image/clock_in.png",
                    width: 60,
                    height: 60,
                  ),
                  const Text(
                    "08:00",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("Jam Masuk",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/image/clock_out.png",
                    width: 60,
                    height: 60,
                  ),
                  const Text(
                    "16:40",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("Jam Pulang",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
