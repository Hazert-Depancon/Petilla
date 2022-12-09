class ReportedPetModel {
  final String? imagePath;
  final String description;
  final String phoneNumber;
  final String lat;
  final String long;
  final String currentEmail;
  final String currentUid;
  final String currentName;
  final bool isDamaged;

  ReportedPetModel({
    this.imagePath,
    required this.description,
    required this.phoneNumber,
    required this.long,
    required this.currentEmail,
    required this.currentUid,
    required this.currentName,
    required this.lat,
    required this.isDamaged,
  });
}
