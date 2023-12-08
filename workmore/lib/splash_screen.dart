import 'package:flutter/material.dart';

/*
class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen(
      seconds: 8,
      navigateAfterSeconds: () {
        Navigator.of(context).pushReplacementNamed('/main');
      },
      title: Text(
        'SplashScreen Example',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
      ),
      backgroundColor: Colors.lightBlue[200],
    ));
  }
}
*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any necessary initialization or data loading code here
    // Example: fetchData();
    _navigateToMainScreen();
  }

  // Replace this method with your actual data loading logic
  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  // Navigates to the main screen after the splash screen duration
  void _navigateToMainScreen() {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F0D4),
      body: Center(
        child: SizedBox(
            width: 350,
            height: 350,
            child: Image.asset(
              "assets/image/logo.png",
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
