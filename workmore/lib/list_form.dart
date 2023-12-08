import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workmore/class/form_class.dart';
import 'package:workmore/ui/card/leave_form_card.dart';
import 'package:workmore/ui/card/overtime_form_card.dart';
import 'package:workmore/ui/card/permit_form_card.dart';
import 'package:workmore/ui/card/reimburse_form_card.dart';

class ListForm extends StatefulWidget {
  const ListForm({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ListForm();
  }
}

class _ListForm extends State<ListForm> with WidgetsBindingObserver {
  List<dynamic> formList = [];
  String? formType;
  String? idUser;
  Future<void> getFeedbackScreen(String data) async {
    parsingParam(data.toString());
    //parsingParam(data.toString());
  }

  void parsingParam(String data) {
    List<String> parts = data.split(";");
    setState(() {
      formType = parts[1];
      idUser = parts[0];
    });
  }

  @override
  void initState() {
    //WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      getFormData(idUser!, formType!).then((value) => setState((() {
            formList = value;
          })));
    });
  }

  // ignore: non_constant_identifier_names
  Widget ListFormUI(String formType, int index, List<dynamic> data) {
    print(formType + "/" + index.toString() + "/" + data.toString());
    if (formType.toLowerCase() == "leave") {
      return LeaveFormCard(
          start_date: data[index]["start_date"],
          end_date: data[index]["end_date"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "permit") {
      return PermitFormCard(
          start_date: data[index]["start_date"],
          time_in: data[index]["time_in"],
          time_out: data[index]["time_out"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "overtime") {
      return OvertimeFormCard(
          start_date: data[index]["start_date"],
          time_out: data[index]["time_out"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else if (formType.toLowerCase() == "reimburse") {
      return ReimburseFormCard(
          start_date: data[index]["start_date"],
          sign1: data[index]["sign1"].toString(),
          approval1: data[index]["approval1"],
          approval2: data[index]["approval2"],
          sign2: data[index]["sign2"].toString(),
          reason: data[index]["reason"]);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(this.context)?.settings.arguments;
    getFeedbackScreen(data.toString());
    return Scaffold(
        backgroundColor: const Color(0xFFF6F0D4),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  formType!,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Stack(
                children: [
                  SizedBox(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          getFormData(idUser!, formType!);
                        },
                        child: ListView.builder(
                          itemCount: formList.length,
                          itemBuilder: ((context, index) {
                            return ListTile(
                                title: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      formList[(formList.length - 1) - index]
                                          ["timestamp"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                subtitle: SizedBox(
                                  height: 180,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 216, 216, 216),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListFormUI(
                                          formType!,
                                          (formList.length - 1) - index,
                                          formList)),
                                ));
                          }),
                        )),
                  ),
                  Positioned(
                      right: 20,
                      bottom: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/create-form',
                              arguments:
                                  "$idUser;$formType;${formList.length.toString()}");
                        },
                        child: const Icon(Icons.add),
                      ))
                ],
              ))
            ],
          ),
        ));
  }
}
