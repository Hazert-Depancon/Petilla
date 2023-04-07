import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/widgets/patily_form/answer_form_widget.dart';
import 'package:patily/product/models/patily_form/answer_form_model.dart';
import 'package:patily/product/models/patily_form/question_form_model.dart';
import 'package:patily/feature/patily_form/service/patiform_service.dart';

class InFormView extends StatefulWidget {
  const InFormView({super.key, required this.formModel});
  final QuestionFormModel formModel;

  @override
  State<InFormView> createState() => _InFormViewState();
}

class _InFormViewState extends BaseState<InFormView> {
  final TextEditingController messageController = TextEditingController();

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
            flex: 5,
            child: ListView(
              padding: context.horizontalPaddingNormal,
              children: [
                Row(
                  children: [
                    _circleAvatar,
                    context.emptySizedWidthBoxLow,
                    _currentUserName(context),
                  ],
                ),
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    _animalIcon,
                    context.emptySizedWidthBoxLow,
                    _title(context),
                  ],
                ),
                context.emptySizedHeightBoxLow,
                _description,
                _date(context),
                context.emptySizedHeightBoxLow,
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseCollectionEnum.patilyForm.reference
                .doc(widget.formModel.docId)
                .collection(FirebaseCollectionEnum.answers.toString())
                .orderBy(
                  AppFirestoreFieldNames.createdTimeField,
                  descending: false,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return Expanded(
                    flex: 3,
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return AnswerFormWidget(
                          answerFormModel: AnswerFormModel(
                            answeredDocId: widget.formModel.docId!,
                            createdTime: snapshot.data!.docs[index]
                                [AppFirestoreFieldNames.createdTimeField],
                            description: snapshot.data!.docs[index]
                                [AppFirestoreFieldNames.descriptionField],
                            currentUserName: snapshot.data!.docs[index]
                                [AppFirestoreFieldNames.currentNameField],
                            currentUid: snapshot.data!.docs[index]
                                [AppFirestoreFieldNames.currentUidField],
                            currentEmail: snapshot.data!.docs[index]
                                [AppFirestoreFieldNames.currentEmailField],
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return const StatusView(status: StatusKeysEnum.LOADING);
            },
          ),
          FirebaseAuth.instance.currentUser!.uid == widget.formModel.currentUid
              ? const SizedBox.shrink()
              : Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Row(
                    children: [
                      Expanded(
                        child: _textField(messageController),
                      ),
                    ],
                  ),
                ),
          context.emptySizedHeightBoxLow,
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
              PatilyFormService().reciveQuestion(
                AnswerFormModel(
                  answeredDocId: widget.formModel.docId!,
                  createdTime: Timestamp.now(),
                  description: messageController.text.trim(),
                  currentUserName:
                      FirebaseAuth.instance.currentUser!.displayName!,
                  currentUid: FirebaseAuth.instance.currentUser!.uid,
                  currentEmail: FirebaseAuth.instance.currentUser!.email!,
                ),
              );
              messageController.clear();
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

  Text get _description => Text(
        widget.formModel.description,
        style: textTheme.titleLarge
            ?.copyWith(color: LightThemeColors.black.withOpacity(.6)),
      );

  Text _date(BuildContext context) {
    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      widget.formModel.title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
    );
  }

  SvgPicture get _animalIcon {
    return SvgPicture.asset(
      animalIconPath,
      height: 24,
    );
  }
}
