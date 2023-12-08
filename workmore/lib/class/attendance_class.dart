import 'package:workmore/api/api.dart';

Future getAbsenData() async {
  MyApi myApi = MyApi('param1', 'param1', {'data': 'data'});
  final response = await myApi.Get();

  if (response.length != 0) {
    return response["data"];
  } else {
    // Handle errors (e.g., server error, not found, etc.)
    return {};
  }
}

String status(String timein) {
  //TimeOfDay time_in_config =  TimeOfDay(hour: 08, minute: 00);
  //TimeOfDay time_in_input =  TimeOfDay(hour: int.parse(timein.substring(0,1)), minute: int.parse(timein.substring(3,4)));
  DateTime timeInConfig = DateTime.parse("0000-00-00 08:00:00");
  DateTime timeInInput = DateTime.parse("0000-00-00 $timein");
  print("Diff : " + timeInInput.difference(timeInConfig).toString());
  if (timeInInput.compareTo(timeInConfig) != 1) {
    return "On-Time";
  } else {
    return "Late";
  }
}

String timetaken(String? timein, String? timeout) {
  //TimeOfDay time_in_config =  TimeOfDay(hour: 08, minute: 00);
  //TimeOfDay time_in_input =  TimeOfDay(hour: int.parse(timein.substring(0,1)), minute: int.parse(timein.substring(3,4)));
  if (timeout == null) {
    timeout = "00:00:00";
  }
  if (timein == null) {
    timein = "00:00:00";
  }
  DateTime timeInOut = DateTime.parse("0000-00-00 $timeout");
  DateTime timeInIn = DateTime.parse("0000-00-00 $timein");
  //print("Diff : " + time_in_input.difference(time_in_config).toString());
  return timeInOut.difference(timeInIn).inHours < 0
      ? "00:00:00"
      : timeInOut.difference(timeInIn).toString().substring(0, 8);
}
