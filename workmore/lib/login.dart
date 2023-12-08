// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var email = "";
var password = "";

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F0D4),
      ),
      child: const Center(child: LoginAccess()),
    ));
  }
}

class LoginAccess extends StatefulWidget {
  const LoginAccess({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginAccess();
  }
}

class _LoginAccess extends State<LoginAccess> {
  /*
  Future<void> fetchData(
      String email, String pass, BuildContext context) async {
    final response = await http.get(Uri.parse(
        'https://yourapi'));

    if (response.statusCode == 200) {
      // Parse the JSON response if applicable
      //final data = jsonDecode(response.body);
      // Handle the data
      //print(data);

      Fluttertoast.showToast(
        msg: "Login Success.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      // Handle errors (e.g., server error, not found, etc.)
      Fluttertoast.showToast(
        msg: "Login Failed.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 120,
              child: Image.asset("assets/image/man.png", fit: BoxFit.fitHeight),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: deviceWidth - 100,
              height: 50,
              child: TextField(
                style: const TextStyle(fontSize: 20),
                onChanged: (text) {
                  setState(() {
                    email = text;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  contentPadding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: deviceWidth - 100,
              height: 50,
              child: TextField(
                obscureText: true,
                style: const TextStyle(fontSize: 20),
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  contentPadding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: deviceWidth - 100,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFC14D),
                      foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/dashboard');
                  },
                  child: const Text("Login")),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Don't have an account? "),
                TextButton(onPressed: () {}, child: const Text("Sign up"))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15),
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5)),
                  child: const Text('                                  '),
                ),
                const Text("Or"),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 15),
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5)),
                  child: const Text('                                  '),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Sign In using other method? "),
                TextButton(onPressed: () {}, child: const Text("Sign in"))
              ],
            ),
          ],
        ));
  }
}
