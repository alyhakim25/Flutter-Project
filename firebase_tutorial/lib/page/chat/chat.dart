import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/class/firebase.dart';
import 'package:firebase_tutorial/page/chat/message_ui.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatelessWidget {
  TextEditingController messageCtrl = TextEditingController();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 249, 252),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: getMessages(uid.toString().split('/')[0]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  );
                }

                var messages = snapshot.data!.docs;

                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  var messageText = message['text'];
                  var messageSenderUid = message['senderUid'];

                  var messageWidget = MessageWidget(
                    text: messageText,
                    senderUid: messageSenderUid,
                    curUid: uid.toString().split('/')[1],
                  );
                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  reverse: true,
                  children: messageWidgets.reversed.toList(),
                );
              },
            )),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageCtrl,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (messageCtrl.text != "") {
                        sendMessage(
                                messageCtrl.text,
                                uid.toString().split('/')[1],
                                uid.toString().split('/')[0])
                            .then((value) {
                          if (value) {
                            messageCtrl.text = "";
                          } else {
                            Fluttertoast.showToast(
                                msg: "Send Message Failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 223, 223, 223),
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0);
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
