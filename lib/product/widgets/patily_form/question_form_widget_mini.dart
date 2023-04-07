import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/models/patily_form/question_form_model.dart';
import 'package:patily/feature/patily_form/view/in_form_view.dart';

class QuestionFormModelMini extends StatefulWidget {
  const QuestionFormModelMini({super.key, required this.formModel});

  final QuestionFormModel formModel;

  @override
  State<QuestionFormModelMini> createState() => _QuestionFormModelMiniState();
}

class _QuestionFormModelMiniState extends BaseState<QuestionFormModelMini> {
  late final String animalIconPath;
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
    ).format(widget.formModel.createdTime.toDate());
    if (widget.formModel.animalType == LocaleKeys.animalNames_dog.locale) {
      animalIconPath = Assets.svg.dog;
    } else if (widget.formModel.animalType ==
        LocaleKeys.animalNames_cat.locale) {
      animalIconPath = Assets.svg.cat;
    } else if (widget.formModel.animalType ==
        LocaleKeys.animalNames_fish.locale) {
      animalIconPath = Assets.svg.fish;
    } else if (widget.formModel.animalType ==
        LocaleKeys.animalNames_rabbit.locale) {
      animalIconPath = Assets.svg.rabbit;
    } else if (widget.formModel.animalType ==
        LocaleKeys.animalNames_bird.locale) {
      animalIconPath = Assets.svg.bird;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InFormView(formModel: widget.formModel),
          ),
        );
      },
      title: Row(
        children: [
          _animalIcon(),
          context.emptySizedWidthBoxLow,
          _titleText(context),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _descriptionText(context),
          Text(
            formattedDate,
            style: textTheme.titleLarge?.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Text _descriptionText(BuildContext context) {
    return Text(
      widget.formModel.description,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
    );
  }

  Text _titleText(BuildContext context) {
    return Text(
      widget.formModel.title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SvgPicture _animalIcon() {
    return SvgPicture.asset(
      animalIconPath,
      height: 24,
    );
  }
}
