import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApi {
  String apiLink = 'https://your_api';
  MyApi(String endPoint, String method, Map<String, String> data) {
    apiLink += '/' + method + '/' + endPoint + '?';
    data.forEach((key, value) {
      apiLink += '$key=$value';
      apiLink += '&';
    });
  }
  Future<bool> Post() async {
    final response = await http.post(Uri.parse(apiLink));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future Get() async {
    final response = await http.get(Uri.parse(apiLink));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {};
    }
  }
}
