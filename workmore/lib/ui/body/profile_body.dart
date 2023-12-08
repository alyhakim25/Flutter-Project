import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workmore/component/button/image_button.dart';
import 'package:workmore/component/image/circular_image.dart';

class ProfileBody extends StatelessWidget {
  final double height;
  final double width;
  ProfileBody({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return (Container(
        height: height - 200,
        decoration: BoxDecoration(
            color: const Color.fromARGB(167, 158, 158, 158),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircularImage(
                      imageSrc: "assets/image/my_photo.jpg",
                      height: 150,
                      width: 150),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: ImageButton(
                      imageSrc: 'assets/image/edit.png',
                      height: 30,
                      width: 30,
                      onPressed: () => {print("asd")},
                      circular: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "ALY HAKIM",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            const Text(
              "SOFTWARE ENGINEER",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20)),
                width: width - 120,
                height: height - 491,
                margin: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("NIK         : 123456789"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Address : Batam"),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Level      : Staff")
                    ],
                  ),
                )),
          ],
        )));
  }
}
