import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFormModel {
  final String title;
  final String description;
  final String currentUserName;
  final String currentUid;
  final String currentEmail;
  final String animalType;
  final Timestamp createdTime;
  final String? docId;

  QuestionFormModel({
    this.docId,
    required this.animalType,
    required this.title,
    required this.description,
    required this.currentUserName,
    required this.currentUid,
    required this.currentEmail,
    required this.createdTime,
  });
}
