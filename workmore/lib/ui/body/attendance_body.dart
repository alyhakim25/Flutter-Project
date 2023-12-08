import 'package:flutter/widgets.dart';
import 'package:workmore/component/recylerview/recylerview_container.dart';
import 'package:workmore/component/recylerview/recylerview_content.dart';
import 'package:workmore/ui/card/attendance_card.dart';

class AttendanceBody extends StatelessWidget {
  final List<dynamic> dataList;
  AttendanceBody({required this.dataList});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return (RecylerViewContainer(
        data: dataList,
        height: screenHeight - 150,
        onRefresh: () {},
        children: (index, data) {
          return RecylerViewContent(
            title: data[(data.length - 1) - index]["timestamp"],
            data: dataList,
            index: index,
            children: (index, data) {
              return AttendanceCard(data: data, index: index);
            },
          );
        }));
  }
}
