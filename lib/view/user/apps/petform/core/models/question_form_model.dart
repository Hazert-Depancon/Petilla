class QuestionFormModel {
  final String title;
  final String description;
  final String currentUserName;
  final String currentUid;
  final String currentEmail;
  final String animalType;
  final int upCount;
  final DateTime createdTime;

  QuestionFormModel({
    required this.upCount,
    required this.animalType,
    required this.title,
    required this.description,
    required this.currentUserName,
    required this.currentUid,
    required this.currentEmail,
    required this.createdTime,
  });
}
