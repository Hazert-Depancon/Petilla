// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';
import 'package:petilla_app_project/constant/strings/project_lottie_urls.dart';
import 'package:quickalert/quickalert.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _showDialog(context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
          child: Lottie.network(ProjectLottieUrls.loadingLottie),
        );
      },
    );
  }

  _showAlertDialog(context, error) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Hata",
      text: error,
    );
  }

  Future<void> login(String email, String password, context) async {
    _showDialog(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _showAlertDialog(context, e.message);
    }
  }

  Future register(String email, String password, String name, context) async {
    _showDialog(context);

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "uid": _auth.currentUser!.uid,
        "status": "Unavailable",
      });
      print('Register success');
    } on FirebaseAuthException catch (e) {
      _showAlertDialog(context, e.message);
    }
  }

  Future logout(context) async {
    _showDialog(context);
    try {
      await _auth.signOut().then(
            (value) => Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const LoginView()), (route) => false),
          );
      print('Logout success');
    } on FirebaseAuthException catch (e) {
      _showAlertDialog(context, e.message);
    }
  }
}
