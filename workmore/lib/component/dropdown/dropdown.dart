import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

typedef void OnPickValue(String value);

class DropdownItem extends StatelessWidget {
  final OnPickValue onPick;
  final List<String> item;
  final String value;
  final String title;
  DropdownItem(
      {required this.item,
      required this.title,
      required this.value,
      required this.onPick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
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
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x80000000),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: item
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
        value: value,
        onChanged: (String? value) {
          onPick(value!);
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
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
    ));
  }
}
