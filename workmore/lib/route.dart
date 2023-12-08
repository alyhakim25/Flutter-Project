import 'package:flutter/material.dart';
import 'package:workmore/new_task.dart';
import 'package:workmore/splash_screen.dart';
import 'package:workmore/login.dart';
import 'package:workmore/navigation.dart';
import 'package:workmore/create_form.dart';
import 'package:workmore/list_form.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/navigation',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/navigation': (context) => const Navigation(),
        '/list-form': (context) => const ListForm(),
        '/create-form': (context) => const CreateForm(),
        '/new-task': (context) => const NewTask(),
      },
    );
  }
}
