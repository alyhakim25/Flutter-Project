import 'package:firebase_tutorial/dashboard.dart';
import 'package:firebase_tutorial/page/auth/loginpage.dart';
import 'package:firebase_tutorial/page/auth/profile.dart';
import 'package:firebase_tutorial/page/auth/registerpage.dart';
import 'package:firebase_tutorial/page/chat/chat.dart';
import 'package:firebase_tutorial/page/chat/landingpage.dart';
import 'package:flutter/material.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Tutorial',
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/auth': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
        '/register': (context) => SignUpPage(),
        '/landing': (context) => const LandingPage(),
        '/chat': (context) => ChatPage()
      },
    );
  }
}
