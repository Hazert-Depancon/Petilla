import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/question_form_model.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/service/petform_service.dart';

class InFormView extends StatefulWidget {
  const InFormView({super.key, required this.formModel});
  final QuestionFormModel formModel;

  @override
  State<InFormView> createState() => _InFormViewState();
}

class _InFormViewState extends State<InFormView> {
  final SizedBox smallHeightSizedBox = AppSizedBoxs.smallHeightSizedBox;
  final SizedBox normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;

  final TextEditingController messageController = TextEditingController();

  late final String animalIconPath;
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
    ).format(widget.formModel.createdTime);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body(context),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              padding: ProjectPaddings.horizontalMainPadding,
              children: [
                Row(
                  children: [
                    _circleAvatar,
                    normalWidthSizedBox,
                    _currentUserName(context),
                  ],
                ),
                smallHeightSizedBox,
                Row(
                  children: [
                    _animalIcon,
                    normalWidthSizedBox,
                    _title(context),
                  ],
                ),
                smallHeightSizedBox,
                _description,
                _date(context),
              ],
            ),
          ),
          Padding(
            padding: ProjectPaddings.horizontalMainPadding,
            child: Row(
              children: [
                Expanded(
                  child: _textField(messageController),
                ),
              ],
            ),
          ),
          smallHeightSizedBox,
        ],
      ),
    );
  }

  AppBar get _appBar => AppBar();

  TextField _textField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: LocaleKeys.writeAMessage.locale,
        suffixIcon: _sendButton(controller),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  _sendButton(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 45,
        width: 45,
        child: CircleAvatar(
          backgroundColor: LightThemeColors.miamiMarmalade,
          foregroundColor: LightThemeColors.white,
          child: IconButton(
            onPressed: () {
              PetformService().addQuestionToForm(
                widget.formModel.docId ?? "",
                widget.formModel,
              );
            },
            icon: SvgPicture.asset(
              Assets.svg.send,
              color: LightThemeColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Text _currentUserName(BuildContext context) {
    return Text(
      widget.formModel.currentUserName,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
    );
  }

  CircleAvatar get _circleAvatar => CircleAvatar(
        child: Text(
          widget.formModel.currentUserName.characters.first,
        ),
      );

  Text get _description => Text(widget.formModel.description);

  Text _date(BuildContext context) {
    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      widget.formModel.title,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  SvgPicture get _animalIcon {
    return SvgPicture.asset(
      animalIconPath,
      height: 24,
    );
  }
}
