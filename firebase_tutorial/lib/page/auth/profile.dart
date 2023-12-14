import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/class/firebase.dart';
import 'package:firebase_tutorial/component/circular_image.dart';
import 'package:firebase_tutorial/component/mybutton.dart';
import 'package:firebase_tutorial/component/toast.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Get the current user
    User currentUser = FirebaseAuth.instance.currentUser!;
    Future<DocumentSnapshot<Map<String, dynamic>>> data =
        getUserData(currentUser.uid);

    return FutureBuilder(
      future: data,
      builder: (context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              backgroundColor: Color.fromARGB(255, 176, 249, 252),
              body: Center(
                child: CircularProgressIndicator(),
              )); // Loading indicator while fetching data
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 176, 249, 252),
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            backgroundColor: Color.fromARGB(255, 176, 249, 252),
            body: Center(
              child: Text("User data not found"),
            ),
          );
        }

        // Access user data from snapshot
        Map<String, dynamic> userData = snapshot.data!.data()!;
        // Use the user data to build your UI

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 176, 249, 252),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularImage(
                  imageSrc: currentUser.photoURL == null
                      ? userData['image']
                      : currentUser.photoURL!,
                  height: 200,
                  width: 200,
                  imgNetwork: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("${userData['displayName']}"),

                const SizedBox(
                  height: 10,
                ),
                Text("${currentUser.email}"),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                    width: 100,
                    text: "Sign Out",
                    onPressed: () {
                      signOut(currentUser).then((value) {
                        if (value) {
                          Navigator.pop(context, true);
                          ShowToast("Sign Out Success");
                        }
                      });
                    })
                // Add more fields as needed
              ],
            ),
          ),
        );
      },
    );
  }
}
