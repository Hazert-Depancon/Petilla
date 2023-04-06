import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patily/product/widgets/buttons/auth_button.dart';
import 'package:patily/product/widgets/textfields/main_textfield.dart';
import 'package:patily/product/constants/sizes_constant/app_sized_box.dart';
import 'package:patily/product/constants/sizes_constant/project_padding.dart';
import 'package:patily/product/constants/sizes_constant/project_radius.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/models/patily_form/question_form_model.dart';
import 'package:patily/feature/patily_form/service/patiform_service.dart';
import 'package:patily/product/widgets/dialogs/error_dialog.dart';

class AddQuestionView extends StatefulWidget {
  const AddQuestionView({super.key});

  @override
  State<AddQuestionView> createState() => _AddQuestionViewState();
}

class _AddQuestionViewState extends State<AddQuestionView> {
  final SizedBox mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;
  String? petSelectedValue;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final pets = [
    LocaleKeys.animalNames_dog.locale,
    LocaleKeys.animalNames_cat.locale,
    LocaleKeys.animalNames_fish.locale,
    LocaleKeys.animalNames_rabbit.locale,
    LocaleKeys.animalNames_bird.locale,
    LocaleKeys.other.locale,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body(),
    );
  }

  AppBar get _appBar => AppBar(
        title: Text(LocaleKeys.addAQuestion.locale),
      );

  Form _body() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          children: [
            MainTextField(
              hintText: LocaleKeys.title.locale,
              controller: _titleController,
              isNext: true,
            ),
            mainHeightSizedBox,
            MainTextField(
              controller: _descriptionController,
              hintText: LocaleKeys.description.locale,
              minLines: 5,
            ),
            mainHeightSizedBox,
            _petTypeDropDown,
            mainHeightSizedBox,
            AuthButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (petSelectedValue != null) {
                    PatilyFormService().addQuestionToForm(
                      QuestionFormModel(
                        animalType: petSelectedValue!,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        currentUserName:
                            _firebaseAuth.currentUser!.displayName!,
                        currentUid: _firebaseAuth.currentUser!.uid,
                        currentEmail: _firebaseAuth.currentUser!.email!,
                        createdTime: Timestamp.now(),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    showErrorDialog(
                      true,
                      LocaleKeys.validation_emptyValidation.locale,
                      context,
                    );
                  }
                }
              },
              text: LocaleKeys.createQuestion.locale,
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> get _petTypeDropDown {
    return DropdownButtonFormField(
      elevation: 0,
      borderRadius: ProjectRadius.allRadius,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: ProjectRadius.allRadius,
        ),
      ),
      hint: Text(LocaleKeys.petType.locale),
      value: petSelectedValue,
      items: pets
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          petSelectedValue = val;
        });
      },
    );
  }
}
