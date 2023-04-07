import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:patily/feature/patily_help/view/help_me_detail_view.dart';

class HelpMeWidget extends StatelessWidget {
  const HelpMeWidget({super.key, required this.helpMeModel});
  final HelpMeModel helpMeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        borderRadius: context.normalBorderRadius,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpMeDetailView(helpMeModel: helpMeModel),
            ),
          );
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: LightThemeColors.snowbank,
          ),
          child: Padding(
            padding: context.paddingNormal,
            child: Row(
              children: [
                _imageContainer(context),
                context.emptySizedWidthBoxLow3x,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titleText(context),
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

  Container _imageContainer(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: context.normalBorderRadius,
        color: LightThemeColors.miamiMarmalade,
        image: DecorationImage(
          image: NetworkImage(helpMeModel.imageDowlandUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
