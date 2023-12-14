import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 243, 250),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/auth');
              },
              child: const Text('Authentication Firebase'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/landing',
                    arguments: DateTime.now().toString());
              },
              child: const Text('Firestore Firebase'),
            ),
          )
        ],
      ),
    );
  }
}
