import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/components/buttons/auth_button.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';

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
        title: const Text("Bir Soru Oluştur"),
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
                  // PetformService().addQuestionToForm(
                  // QuestionFormModel(
                  //   animalType: petSelectedValue!,
                  //   title: _titleController.text,
                  //   description: _descriptionController.text,
                  //   currentUserName: _firebaseAuth.currentUser!.displayName!,
                  //   currentUid: _firebaseAuth.currentUser!.uid,
                  //   currentEmail: _firebaseAuth.currentUser!.email!,
                  //   createdTime: DateTime.now(),
                  // ),
                  // );
                }
              },
              text: "Soru Oluştur",
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
