import 'package:firebase_tutorial/component/image_button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final date = ModalRoute.of(context)?.settings.arguments;
    String uidUser1 = '$date/user1';
    String uidUser2 = '$date/user2';
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 176, 249, 252),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "User 1",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyImageButton(
                    imagePath: 'assets/images/man.png',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/chat', arguments: uidUser1);
                    },
                    imgHeight: 100,
                    imgWidth: 100,
                  )
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "User 2",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyImageButton(
                    imagePath: 'assets/images/cowgirl.png',
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/chat', arguments: uidUser2);
                    },
                    imgHeight: 100,
                    imgWidth: 100,
                  )
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
