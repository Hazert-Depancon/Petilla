import 'package:flutter/material.dart';
import 'package:patily/product/constants/sizes_constant/app_sized_box.dart';
import 'package:patily/product/constants/sizes_constant/project_radius.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/feature/help_me/core/models/help_me_model.dart';
import 'package:patily/feature/help_me/view/help_me_detail_view.dart';

class HelpMeWidget extends StatelessWidget {
  const HelpMeWidget({super.key, required this.helpMeModel});
  final HelpMeModel helpMeModel;

  @override
  Widget build(BuildContext context) {
    const smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;
    const smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HelpMeDetailView(helpMeModel: helpMeModel)));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: ProjectRadius.mainAllRadius,
            color: LightThemeColors.snowbank,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                _imageContainer(),
                smallWidthSizedBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleText(context),
                      smallHeightSizedBox,
                      _descriptionText(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _descriptionText(context) {
    return Text(
      maxLines: 3,
      helpMeModel.description,
      style: Theme.of(context).textTheme.titleLarge,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _titleText(context) => Text(
        helpMeModel.title,
        style: Theme.of(context).textTheme.headlineSmall,
      );

  Container _imageContainer() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: ProjectRadius.mainAllRadius,
        color: LightThemeColors.miamiMarmalade,
        image: DecorationImage(
          image: NetworkImage(helpMeModel.imageDowlandUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
