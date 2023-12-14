import 'package:firebase_tutorial/component/circular_image.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final String senderUid;
  final String curUid;
  const MessageWidget(
      {super.key,
      required this.text,
      required this.senderUid,
      required this.curUid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: senderUid == curUid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          senderUid == curUid
              ? Container()
              : CircularImage(
                  imageSrc: curUid == 'user1'
                      ? 'assets/images/man.png'
                      : 'assets/images/cowgirl.png',
                  height: 45,
                  width: 45),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: senderUid == curUid ? Colors.blue : Colors.grey,
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
