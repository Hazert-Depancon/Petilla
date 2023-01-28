import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/petcook/core/models/post_model.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Text(postModel.senderUserName.characters.first),
            ),
            const SizedBox(width: 12),
            Text(
              postModel.senderUserName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: LightThemeColors.snowbank,
            borderRadius: ProjectRadius.mainAllRadius,
            image: DecorationImage(
              image: NetworkImage(postModel.postDowlandUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          postModel.description,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
