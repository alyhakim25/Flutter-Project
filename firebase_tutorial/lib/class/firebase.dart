import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_tutorial/component/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> registerUser(
    String email, String password, String displayName, File? image) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;
    String imageUrl = "";
    if (image != null) {
      String imagePath = 'user_images/$uid.jpg';
      await FirebaseStorage.instance.ref(imagePath).putFile(image);
      imageUrl = await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'displayName': displayName, 'image': imageUrl, 'email': email});
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      ShowToast('Email already used.');
    } else if (e.code == 'weak-password') {
      ShowToast('The password provided is too weak.');
    } else {
      ShowToast('Failed to Sign Up.');
    }
    return false;
  }
}

Future<bool> googleSignIn() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'displayName': user.displayName,
      'image': user.photoURL,
      'email': user.email
    });
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> googleSignOut() async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    await googleSignIn.signOut();
    // You can perform additional logout actions here, such as updating UI or navigating to a login screen.
    print('Successfully signed out from Google account.');
    return true;
  } catch (error) {
    print('Error signing out: $error');
    return false;
  }
}

Future<bool> signOutEmail() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signOut();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> signOut(User user) async {
  String method = getAuthProvider(user);
  if (method == "google") {
    return googleSignOut();
  } else {
    return signOutEmail();
  }
}

String getAuthProvider(User user) {
  // Check the providerData list to determine the authentication provider
  for (UserInfo userInfo in user.providerData) {
    switch (userInfo.providerId) {
      case 'google.com':
        return 'google';
      case 'password':
        return 'firebase';
      // Add more cases for other authentication providers if needed
      default:
        return 'unknown';
    }
  }
  return 'unknown';
}

Future<bool> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    ShowToast("Login Success");
    return true;
    //print('User signed in successfully!');
  } catch (e) {
    ShowToast("Login Failed");
    return false;
    //print('Error signing in: $e');
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance
            .collection('users') // Change this to the name of your collection
            .doc(uid)
            .get();
    print("document : " + userDocument.toString());
    return userDocument;
  } catch (e) {
    print("Error fetching user data: $e");
    return Future.error("Failed to fetch user data");
  }
}

Future<bool> sendMessage(String text, String senderUid, String dateTime) async {
  try {
    DateTime time = DateTime.now();
    FirebaseFirestore.instance
        .collection('messages')
        .doc('${time.day}-${time.month}-${time.year}')
        .collection(dateTime)
        .doc('${time.hour}:${time.minute}:${time.second}')
        .set({
      'text': text,
      'senderUid': senderUid,
      'timestamp': FieldValue.serverTimestamp(),
    });
    return true;
  } catch (e) {
    return false;
  }
}

Stream<QuerySnapshot> getMessages(String dateTime) {
  DateTime time = DateTime.now();
  return FirebaseFirestore.instance
      .collection('messages')
      .doc('${time.day}-${time.month}-${time.year}')
      .collection(dateTime)
      .snapshots();
}
