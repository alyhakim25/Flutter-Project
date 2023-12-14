import 'dart:io';

import 'package:firebase_tutorial/class/firebase.dart';
import 'package:firebase_tutorial/component/mybutton.dart';
import 'package:firebase_tutorial/component/textbox.dart';
import 'package:firebase_tutorial/component/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  XFile? _pickedImage;
  bool isLoading = false;

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void SignUp(String email, String password, String confirmPassword,
      String displayName, File? image, BuildContext context) {
    if (password.length < 8) {
      ShowToast("Password at least have 8 character");
    } else if (password != confirmPassword) {
      ShowToast("Password not match");
    } else {
      setState(() {
        isLoading = true;
      });
      registerUser(email, password, displayName, image).then((value) {
        if (value) {
          ShowToast("Sign Up Success");
          Navigator.pop(context, true);
        }

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 176, 249, 252),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 50),
            _pickedImage != null
                ? CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(_pickedImage!.path)),
                  )
                : const CircleAvatar(
                    radius: 80,
                    backgroundColor: Color.fromARGB(255, 233, 233, 233),
                  ),
            const SizedBox(height: 16.0),
            MyButton(width: 120, text: "Pick Image", onPressed: _pickImage),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                  width: screenWidth - 100,
                  labelText: "Email",
                  controller: emailController),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                width: screenWidth - 100,
                labelText: "Password",
                controller: passwordController,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                width: screenWidth - 100,
                labelText: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: TextBox(
                  width: screenWidth - 100,
                  labelText: "Display Name",
                  controller: displayNameController),
            ),
            const SizedBox(height: 16.0),
            MyButton(
              width: 120,
              text: "Sign Up",
              buttonChild: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : null,
              onPressed: isLoading
                  ? () {}
                  : () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      String confirmPassword =
                          confirmPasswordController.text.trim();
                      String displayName = displayNameController.text.trim();
                      File? image = _pickedImage != null
                          ? File(_pickedImage!.path)
                          : null;
                      SignUp(email, password, confirmPassword, displayName,
                          image, context);
                    },
            ),
          ],
        ),
      )),
    );
  }
}
