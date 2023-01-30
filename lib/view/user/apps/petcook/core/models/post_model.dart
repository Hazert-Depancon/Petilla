class PostModel {
  final String senderUserId;
  final String senderUserEmail;
  final String senderUserName;
  final String postDowlandUrl;
  final String description;

  PostModel({
    required this.senderUserEmail,
    required this.senderUserName,
    required this.senderUserId,
    required this.postDowlandUrl,
    required this.description,
  });
}
