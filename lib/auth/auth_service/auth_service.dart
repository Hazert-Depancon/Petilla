// ignore_for_file: avoid_print

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future login(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Login success');
    } catch (e) {
      errorBox(context, e);
    }
  }

  Future register(String email, String password, String name, context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "uid": _auth.currentUser!.uid,
        "status": "Unavailable",
      });
      print('Register success');
    } catch (e) {
      errorBox(context, e);
    }
  }

  Future logout(context) async {
    try {
      await _auth.signOut();
      print('Logout success');
    } catch (e) {
      errorBox(context, e);
    }
  }

  Future errorBox(context, e) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      body: Text(e.toString()),
      title: "Hata",
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }
}
