import 'package:HearMe/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

User user;

Future<User> emailSignUp(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    return user;
  } on FirebaseAuthException catch (e) {
    // if (e.code == 'weak-password') {
    //   print('The password provided is too weak.');
    // } else if (e.code == 'email-already-in-use') {
    //   print('The account already exists for that email.');
    // }
    showAlertDialog(e.code, context);
    return null;
  } catch (e) {
    print(e);
  }
  return null;
}

Future<User> emailSignIn(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = userCredential.user;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    return user;
  } on FirebaseAuthException catch (e) {
    showAlertDialog(e.code, context);
    return null;
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> resetPassword(String email) async {
  await auth.sendPasswordResetEmail(email: email);
}

showAlertDialog(String message, BuildContext context) {
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          FlatButton(
            color: Colors.cyan[500],
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}