// ignore_for_file: unnecessary_new, non_constant_identifier_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NewTask();
  }
}

class _NewTask extends State<NewTask> {
  final List<String> status = [
    "Open",
    "Ongoing",
    "Closed",
  ];
  String deadlineDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String taskStatus = "Open";
  String taskLevel = "Normal";
  String taskDescription = "-";
  String? tasStatusSelected;

  TextEditingController deadlineDate_controller = new TextEditingController();
  @override
  void initState() {
    deadlineDate_controller.text = deadlineDate.toString().substring(0, 10);
    super.initState();
  }

  Future<String> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      return DateFormat('yyyy-MM-dd').format(picked).toString();
      /*
      setState(() {
        //selectedDate = picked;
        formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        date1_controller.text = formattedDate;
      });
      */
    } else {
      return DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 50, bottom: 50),
              child: const Text("New Task"),
            ),
            Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: deviceWidth - 200,
                        height: 50,
                        child: TextField(
                          controller: deadlineDate_controller,
                          readOnly: true,
                          enabled: false,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Deadline date",
                            contentPadding:
                                EdgeInsets.only(left: 8, bottom: 8, top: 8),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                _selectDate(context).then((value) {
                                  setState(() {
                                    deadlineDate_controller.text = value;
                                    deadlineDate = value;
                                  });
                                })
                              },
                          child: const Text("Click me"))
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 0,
              child: Container(
                width: deviceWidth,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            'Select Status',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0x80000000),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: status
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: tasStatusSelected,
                    onChanged: (String? value) {
                      setState(() {
                        tasStatusSelected = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 30,
                      iconEnabledColor: Color(0x80000000),
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all<double>(6),
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  height: 50,
                  child: TextField(
                    style: const TextStyle(fontSize: 20),
                    onChanged: (text) {
                      setState(() {
                        taskDescription = text;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      contentPadding:
                          EdgeInsets.only(left: 8, bottom: 8, top: 8),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
