import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/petcook/core/models/post_model.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: ProjectPaddings.horizontalMainPadding,
            child: Row(
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
          ),
          const SizedBox(height: 8),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: LightThemeColors.snowbank,
              image: DecorationImage(
                image: NetworkImage(postModel.postDowlandUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: ProjectPaddings.horizontalMainPadding,
            child: RichText(
              text: TextSpan(
                text: "${postModel.senderUserName} ",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 16,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: postModel.description,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
          AppSizedBoxs.mainHeightSizedBox,
        ],
      ),
    );
  }
}
