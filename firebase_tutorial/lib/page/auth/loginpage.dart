import 'package:firebase_tutorial/class/firebase.dart';
import 'package:firebase_tutorial/component/mybutton.dart';
import 'package:firebase_tutorial/component/textbox.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController usernameText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 249, 252),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "Login Page",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                  width: screenWidth - 100,
                  labelText: "Username",
                  controller: usernameText),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                  obscureText: true,
                  width: screenWidth - 100,
                  labelText: "Password",
                  controller: passwordText),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                width: 120,
                height: 40,
                text: "Sign In",
                onPressed: () {
                  signInWithEmailAndPassword(
                          usernameText.text, passwordText.text)
                      .then((value) {
                    if (value) Navigator.of(context).pushNamed('/profile');
                  });
                }),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: const Text("Sign up"))
              ],
            ),
            const SizedBox(
              height: 0,
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
                Image.asset(
                  "assets/images/google.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("Sign In with google account"),
                TextButton(
                    onPressed: () async {
                      googleSignIn().then((value) {
                        Navigator.of(context).pushNamed('/profile');
                      });
                    },
                    child: const Text("Sign in"))
              ],
            ),
          ],
        )));
  }
}
