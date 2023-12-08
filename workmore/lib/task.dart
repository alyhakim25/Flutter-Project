import 'package:flutter/material.dart';

var Deadline = [
  "05/12/2022",
  "05/12/2022",
  "05/12/2022",
  "05/12/2022",
  "05/12/2022",
  "05/12/2022",
];
var title = [
  "Software Change Report",
  "Modify Prod.tool",
  "Database",
  "Webpage",
  "Meeting",
  "Modify Prod.tool",
];
var urgency = [
  "Normal",
  "Urgent",
  "Urgent",
  "Normal",
  "Normal",
  "Normal",
];
// ignore: non_constant_identifier_names
var Status = [
  "Open",
  "Open",
  "Open",
  "Open",
  "Open",
  "Open",
];
// ignore: non_constant_identifier_names
var Description = [
  "Create SCR for production tool that have reviewed last week",
  "QA have request to have function to detect barcode",
  "Need to remove item 1SF437563 in production database",
  "Add new feature to block a product that haven't finish previous stage",
  "meeting about new project",
  "QA have request to show error message when VID PID not detected",
];

class Task extends StatefulWidget {
  const Task({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Task();
  }
}

class _Task extends State<Task> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F0D4),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Text(
              "Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Stack(
            children: [
              RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      Description = [
                        "xxxxxxxxxxxxxxxxxxxxx",
                        "xxxxxxxxxxxxxxxxxx",
                        "xxxxxxxxxxxxxxxxxxxxx",
                        "xxxxxxxxxxxxxxxxxxx",
                        "xxxxxxxxxxxxxxxxxxxxxxxxxx",
                        "xxxxxxxxxxxxxxxxxxxxx",
                      ];
                    });
                  },
                  child: Container(
                    color: const Color(0xFFF6F0D4),
                    height: screenHeight - 150,
                    child: ListView.builder(
                      itemCount: Deadline.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Container(
                            alignment: Alignment.center,
                            child: Text(title[index],
                                style: const TextStyle(fontSize: 17)),
                          ),
                          subtitle: SizedBox(
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 216, 216, 216),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 3, bottom: 3, right: 5),
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          "Deadline : ${Deadline[index]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    urgency[index] == "Normal"
                                                        ? const Color.fromARGB(
                                                            190, 76, 175, 79)
                                                        : const Color.fromARGB(
                                                            190, 244, 67, 54),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            margin: const EdgeInsets.only(
                                                top: 10, right: 30),
                                            width: 70,
                                            height: 30,
                                            alignment: Alignment.center,
                                            child: Text(
                                              urgency[index],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    child: Text("Status : ${Status[index]}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 50),
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                        "Description : ${Description[index]}",
                                        textAlign: TextAlign.left,
                                        maxLines: 5,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )),
              Positioned(
                  right: 10,
                  bottom: 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/new-task',
                      );
                    },
                    child: const Icon(Icons.add),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
