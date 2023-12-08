// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CreateForm();
  }
}

class _CreateForm extends State<CreateForm> {
  String formType = "";
  String documentNumber = "";
  String reason = "";
  String timeOut = "";
  String timeIn = "";
  String? selectedLeaveType;
  String? selectedLeaveSelection;
  String? selectedApproval1;
  String? selectedApproval2;
  String dropdownValue = 'Dog';
  final List<String> firstApproval = [
    "a",
    "b",
    "c",
  ];
  final List<String> leaveType = [
    "Annual Leave",
    "MC",
    "Free Leave",
  ];
  final List<String> leaveSelection = ["Full day", "Half Day"];
  final List<String> secondApproval = [
    "d",
    "e",
    "f",
  ];
  int idUser = 0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? _filePath;
  String? timeInValue;
  String? timeOutValue;
  bool isMCTypeSelected = false;
  Map<String, dynamic>? LeaveList;
  String startDateValue = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String endDateValue = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int? totalDate;
  TextEditingController date1_controller = TextEditingController();
  TextEditingController date2_controller = TextEditingController();
  TextEditingController timeIn_controller = TextEditingController();
  TextEditingController timeOut_controller = TextEditingController();
  @override
  void initState() {
    date1_controller.text = formattedDate.toString().substring(0, 10);
    date2_controller.text = formattedDate.toString().substring(0, 10);
    timeIn_controller.text = "Time In";
    timeOut_controller.text = "Time Out";
    getLeaveData();

    super.initState();
    calculateDate(startDateValue, endDateValue);
  }

  void parsingParam(String data) {
    List<String> parts = data.split(";");
    setState(() {
      documentNumber = parts[2];
      formType = parts[1];
      idUser = int.parse(parts[0]);
    });
  }

  Future<void> calculateDate(String start, String end) async {
    setState(() {
      totalDate = DateFormat("yyyy-MM-dd")
          .parse(end)
          .difference(DateFormat("yyyy-MM-dd").parse(start))
          .inDays;
    });
  }

  Future<void> sendFormData(BuildContext contex, String reason,
      String approval1, String approval2, int usedLeave) async {
    timeInValue == null ? timeInValue = "" : null;
    timeOutValue == null ? timeOutValue = "" : null;
    startDateValue == null ? startDateValue = "" : null;
    endDateValue == null ? endDateValue = "" : null;
    final response1 = await http.post(Uri.parse('https://yourapi'));
    final response2 = await http.post(Uri.parse('https://yourapi'));
    //print(timeIn);
    // ignore: unrelated_type_equality_checks
    if (response1.statusCode == 200 && response2 == 200) {
      // Parse the JSON response if applicable
      //final dataraw = jsonDecode(response.body);
      // Handle the data
      Fluttertoast.showToast(
        msg: "Submit Form Success.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
      Navigator.pop(context, true);

      //print(dataraw["data"]);
    } else {
      // Handle errors (e.g., server error, not found, etc.)
      Fluttertoast.showToast(
        msg: "Submit Form Failed.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }

  Future<void> getLeaveData() async {
    final response = await http.get(Uri.parse('https://yourapi'));

    if (response.statusCode == 200) {
      // Parse the JSON response if applicable
      final dataraw = jsonDecode(response.body);
      // Handle the data

      setState(() {
        LeaveList = dataraw["data"];
      });
    } else {
      // Handle errors (e.g., server error, not found, etc.)
      Fluttertoast.showToast(
        msg: "Get Leave data failed.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }

  Widget WidgetInputForm(String mode, double deviceWidth) {
    if (mode.toLowerCase() == "leave") {
      return Column(
        children: [
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
                          'Select leave type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0x80000000),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: leaveType
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
                  value: selectedLeaveType,
                  onChanged: (String? value) {
                    setState(() {
                      selectedLeaveType = value;
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(14)),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceWidth - 200,
                      height: 50,
                      child: TextField(
                        controller: date1_controller,
                        readOnly: true,
                        enabled: false,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Start Date",
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 8, top: 8),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              _selectDate(context).then((value) {
                                setState(() {
                                  date1_controller.text = value;
                                  startDateValue = value;
                                  calculateDate(value, endDateValue);
                                });
                              })
                            },
                        child: const Text("Select"))
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
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
                        controller: date2_controller,
                        readOnly: true,
                        enabled: false,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "End Date",
                          contentPadding:
                              EdgeInsets.only(left: 8, bottom: 8, top: 8),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              _selectDate(context).then((value) {
                                setState(() {
                                  date2_controller.text = value;
                                  endDateValue = value;
                                  calculateDate(startDateValue, value);
                                });
                              })
                            },
                        child: const Text("Select"))
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          selectedLeaveType == "MC"
              ? _filePath != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text(
                            'File: $_filePath',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _openFilePicker,
                            child: const Text('Open File Picker'),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const Text(
                          'No Selected File',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _openFilePicker,
                          child: const Text('Upload MC Letter'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
              : Container(),
          (totalDate == 0 && selectedLeaveType != "MC")
              ? Expanded(
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
                                'Select leave ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0x80000000),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: leaveSelection
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
                        value: selectedLeaveSelection,
                        onChanged: (String? value) {
                          setState(() {
                            selectedLeaveSelection = value;
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
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      );
    } else if (mode.toLowerCase() == "permit") {
      return Column(children: [
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
                      controller: date1_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectDate(context).then((value) {
                              setState(() {
                                date1_controller.text = value;
                                startDateValue = value;
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
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: deviceWidth - 200,
                    height: 50,
                    child: TextField(
                      controller: timeIn_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Time In",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectTime(context).then((value) {
                              setState(() {
                                timeIn_controller.text = value;
                                timeInValue = value;
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
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: deviceWidth - 200,
                    height: 50,
                    child: TextField(
                      controller: timeOut_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Time Out",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectTime(context).then((value) {
                              setState(() {
                                timeOut_controller.text = value;
                                timeOutValue = value;
                              });
                            })
                          },
                      child: const Text("Click me"))
                ],
              ),
            )),
      ]);
    } else if (mode.toLowerCase() == "overtime") {
      return Column(children: [
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
                      controller: date1_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectDate(context).then((value) {
                              setState(() {
                                date1_controller.text = value;
                                startDateValue = value;
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
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: deviceWidth - 200,
                    height: 50,
                    child: TextField(
                      controller: timeOut_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Time Out",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectTime(context).then((value) {
                              setState(() {
                                timeOut_controller.text = value;
                                timeOutValue = value;
                              });
                            })
                          },
                      child: const Text("Click me"))
                ],
              ),
            )),
      ]);
    } else if (mode.toLowerCase() == "reimburse") {
      return Column(children: [
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
                      controller: date1_controller,
                      readOnly: true,
                      enabled: false,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date",
                        contentPadding:
                            EdgeInsets.only(left: 8, bottom: 8, top: 8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _selectDate(context).then((value) {
                              setState(() {
                                date1_controller.text = value;
                                startDateValue = value;
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
        _filePath != null
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'File: $_filePath',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : const Text(
                'No Selected File',
                style: TextStyle(fontSize: 16),
              ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _openFilePicker,
          child: const Text('Open File Picker'),
        ),
      ]);
    } else {
      return const Text("asd");
    }
  }

  Future<String> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      return TimeOfDay(hour: picked.hour, minute: picked.minute)
          .format(context)
          .toString();
    } else {
      return TimeOfDay.fromDateTime(DateTime.now()).format(context).toString();
    }
  }

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePath = result.files.single.name;
      });
    }
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
    // TODO: implement build
    MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true);
    double deviceWidth = MediaQuery.of(context).size.width;
    final data = ModalRoute.of(context)?.settings.arguments;

    parsingParam(data.toString());

    return Scaffold(
        backgroundColor: const Color(0xFFF6F0D4),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Text(
                  formType,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              formType.toLowerCase() == 'leave'
                  ? Expanded(
                      flex: 0,
                      child: Container(
                          height: 70,
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 20),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: const Color(0xFF000000), width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Available Leave : ${LeaveList != null ? LeaveList!["annual_leave"] : "0"}"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Taken Leave : ${LeaveList != null ? LeaveList!["advanced_leave"] : "0"}"),
                              ],
                            ),
                          )))
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              WidgetInputForm(formType, deviceWidth),
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
                              'Select Approval 1',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0x80000000),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: firstApproval
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
                      value: selectedApproval1,
                      onChanged: (String? value) {
                        setState(() {
                          selectedApproval1 = value;
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
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
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
                              'Select Approval 2',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0x80000000),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: secondApproval
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
                      value: selectedApproval2,
                      onChanged: (String? value) {
                        setState(() {
                          selectedApproval2 = value;
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
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
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
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () => {
                        sendFormData(context, reason, selectedApproval1!,
                            selectedApproval2!, totalDate!)
                      },
                  child: const Text("Submit"))
            ],
          ),
        ));
  }
}
