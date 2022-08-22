// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future login(String email, String password, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Login success');
    } catch (e) {
      print(e);
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
      print(e);
    }
  }

  Future logout(context) async {
    try {
      await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const LoginView()), (route) => false));
      print('Logout success');
    } catch (e) {
      print(e);
    }
  }
}
