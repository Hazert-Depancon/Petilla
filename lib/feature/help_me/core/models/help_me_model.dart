class HelpMeModel {
  final String title;
  final String currentUserName;
  final String currentUserEmail;
  final String currentUserId;
  final String description;
  final String imageDowlandUrl;
  final String long;
  final String lat;
  final String otherNeeds;
  final bool isVetHelp;
  final bool isFoodHelp;

  HelpMeModel({
    required this.otherNeeds,
    required this.currentUserName,
    required this.currentUserEmail,
    required this.currentUserId,
    required this.imageDowlandUrl,
    required this.title,
    required this.description,
    required this.long,
    required this.lat,
    required this.isVetHelp,
    required this.isFoodHelp,
  });
}
