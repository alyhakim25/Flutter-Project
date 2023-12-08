import 'package:flutter/material.dart';

import '../../component/button/rectangular_button.dart';
import '../button/form_button.dart';

class FormBody extends StatelessWidget {
  FormBody();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RectangularButton(
                  width: 150,
                  height: 150,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/list-form', arguments: "1111111;Leave");
                  },
                  children: FormButton(form: 'leave')),
              RectangularButton(
                  width: 150,
                  height: 150,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/list-form', arguments: "1111111;overtime");
                  },
                  children: FormButton(form: 'overtime')),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RectangularButton(
                  width: 150,
                  height: 150,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/list-form',
                        arguments: "1111111;reimburse");
                  },
                  children: FormButton(form: 'reimburse')),
              RectangularButton(
                  width: 150,
                  height: 150,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/list-form', arguments: "11111111;permit");
                  },
                  children: FormButton(form: 'permit')),
            ],
          ),
        )
      ],
    ));
  }
}
