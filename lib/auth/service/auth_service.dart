import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petilla_app_project/core/components/dialogs/default_dialog.dart';
import 'package:petilla_app_project/core/components/dialogs/error_dialog.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password, context) async {
    showDefaultLoadingDialog(false, context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }
  }

  Future<void> register(String email, String password, String name, context) async {
    showDefaultLoadingDialog(false, context);

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _auth.currentUser!.updateDisplayName(name);
      await _firestore.collection(AppFirestoreCollectionNames.usersCollection).doc(_auth.currentUser!.uid).set({
        AppFirestoreFieldNames.nameField: name,
        AppFirestoreFieldNames.emailField: email,
        AppFirestoreFieldNames.uidField: _auth.currentUser!.uid,
      });
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }
  }

  Future<void> logout(context) async {
    showDefaultLoadingDialog(false, context);
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showErrorDialog(true, e.message!, context);
    }
  }
}
