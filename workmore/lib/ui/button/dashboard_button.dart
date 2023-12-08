import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {
  DashboardButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/image/touch.png",
          scale: 5,
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: const Text(
            "Tekan Untuk Absen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
