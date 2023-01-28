import 'package:petilla_app_project/view/user/apps/petcook/core/constants/enums/post_type.dart';

class PostModel {
  final String senderUserId;
  final String senderUserEmail;
  final String senderUserName;
  final String postDowlandUrl;
  final String description;
  final PostType postType;

  PostModel({
    required this.senderUserEmail,
    required this.senderUserName,
    required this.senderUserId,
    required this.postDowlandUrl,
    required this.description,
    required this.postType,
  });
}
