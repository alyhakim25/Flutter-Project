import 'package:flutter/material.dart';

typedef void OnPressedCallback(String value);

class ReasonDialog extends StatefulWidget {
  final OnPressedCallback onPressed;
  ReasonDialog({required this.onPressed});

  @override
  _ReasonDialog createState() => _ReasonDialog();
}

class _ReasonDialog extends State<ReasonDialog> {
  String reason = "-";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          title: const Text("Reason Required"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Please input your Reason."),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    style: const TextStyle(fontSize: 15),
                    onChanged: (text) {
                      setState(() {
                        reason = text;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Reason',
                      contentPadding:
                          EdgeInsets.only(left: 8, bottom: 8, top: 8),
                    ),
                  ),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                child: const Text("Submit"),
                onPressed: () {
                  widget.onPressed(reason);
                }),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
          ],
        ));
  }
}
