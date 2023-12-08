import 'package:flutter/widgets.dart';

class FormButton extends StatelessWidget {
  final String form;
  FormButton({required this.form});

  Map<String,String> srcContent(String type){
    if(type == "leave") return {"image":"assets/image/baggage.png", "text":"Leave"};
    else if(type == "overtime") return {"image":"assets/image/deadline.png", "text":"Overtime"};
    else if(type == "reimburse") return {"image":"assets/image/budget.png", "text":"Reimburse"};
    else if(type == "permit") return {"image":"assets/image/permit.png", "text":"Permit"};
    else return {"image":"", "text":""};
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, right: 15),
          alignment: Alignment.centerRight,
          child: Image.asset(
            srcContent(form.toLowerCase())['image']!,
            width: 70,
            height: 70,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.only(left: 20, top: 20),
          child:  Text(
            srcContent(form.toLowerCase())['text']!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ));
  }
}
