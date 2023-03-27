import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerFormModel {
  final String answeredDocId;
  final Timestamp createdTime;
  final String description;
  final String currentUserName;
  final String currentUid;
  final String currentEmail;
  final String? docId;

  AnswerFormModel({
    this.docId,
    required this.answeredDocId,
    required this.createdTime,
    required this.description,
    required this.currentUserName,
    required this.currentUid,
    required this.currentEmail,
  });
}
