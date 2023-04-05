import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patily/feature/auth/view/login_view.dart';
import 'package:patily/product/widgets/dialogs/default_dialog.dart';
import 'package:patily/product/widgets/dialogs/error_dialog.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/constants/string_constant/project_firestore_collection_names.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password, context) async {
    try {
      showDefaultLoadingDialog(false, context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }

    Navigator.pop(context);
  }

  Future<void> register(
      String email, String password, String name, context) async {
    try {
      showDefaultLoadingDialog(false, context);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser!.updateDisplayName(name);
      await _firestore
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(_auth.currentUser!.uid)
          .set({
        AppFirestoreFieldNames.nameField: name,
        AppFirestoreFieldNames.emailField: email,
        AppFirestoreFieldNames.uidField: _auth.currentUser!.uid,
      });
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }

    Navigator.pop(context);
  }

  Future<void> logout(context) async {
    showDefaultLoadingDialog(false, context);
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }
  }

  Future<void> deleteUser(context) async {
    try {
      _firestore
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(_auth.currentUser!.uid)
          .delete();
      _auth.currentUser!.delete().whenComplete(
            () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (route) => false,
            ),
          );
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }
  }
}
