import 'package:flutter/widgets.dart';

class PermitFormCard extends StatelessWidget{
  final String start_date;
  final String time_in;
  final String time_out;
  final String sign1;
  final String sign2;
  final String approval1;
  final String approval2;
  final String reason;
  PermitFormCard({required this.start_date,
      required this.time_in,
      required this.time_out,
      required this.sign1,
      required this.approval1,
      required this.approval2,
      required this.sign2,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("Date           : ${start_date}"),
            const SizedBox(
              height: 5,
            ),
            Text("Start Time : ${time_in}"),
            const SizedBox(
              height: 5,
            ),
            Text("End Time   : ${time_out}"),
            const SizedBox(
              height: 5,
            ),
            Text(sign1 == '0'
                ? "Approval 1 : pending by ${approval1}"
                : sign1 == '1'
                    ? "Approval 1 : Accept by ${approval1}"
                    : "Approval 1 : Canceled by ${approval1}"),
            const SizedBox(
              height: 5,
            ),
            Text(sign2 == '0'
                ? "Approval 2 : pending by ${approval2}"
                : sign2 == '1'
                    ? "Approval 2 : Accept by ${approval2}"
                    : "Approval 2 : Canceled by ${approval2}"),
            const SizedBox(
              height: 5,
            ),
            Text("Reason      : ${reason}"),
          ],
        ),
      )
    );
  }
}