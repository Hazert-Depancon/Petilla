import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petilla_app_project/view/main_view/add_view/add_view_two.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_icon_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/view/widgets/button.dart';
import 'package:petilla_app_project/view/widgets/textfields/main_textfield.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Object? val = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evcil Hayvan Ekle 1/2"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: ProjectPaddings.horizontalMainPadding,
            child: SizedBox(
              height: Get.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _addPhotoContainer(),
                  const SizedBox(height: 24),
                  _petNameTextField(),
                  const SizedBox(height: 24),
                  _petDescriptionTextField(),
                  const SizedBox(height: 24),
                  _radioListTile(1, _ThisPageTexts.adopt),
                  _radioListTile(2, _ThisPageTexts.paid),
                  const Spacer(),
                  Align(child: _nextButton()),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Add a photo container
  InkWell _addPhotoContainer() {
    return InkWell(
      borderRadius: ProjectRadius.mainAllRadius,
      onTap: () {},
      child: Container(
        height: 200,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          borderRadius: ProjectRadius.mainAllRadius,
        ),
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          size: ProjectIconSizes.bigIconSize,
        ),
      ),
    );
  }

  // Pet name text field
  MainTextField _petNameTextField() {
    return MainTextField(
      controller: _nameController,
      hintText: _ThisPageTexts.name,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline),
    );
  }

  // Pet description text field
  MainTextField _petDescriptionTextField() {
    return MainTextField(
      controller: _descriptionController,
      minLines: 1,
      maxLines: 5,
      hintText: _ThisPageTexts.description,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.description),
    );
  }

  // Radio list tile
  RadioListTile _radioListTile(int radioNumber, String title) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
      contentPadding: EdgeInsets.zero,
      groupValue: val,
      value: radioNumber,
      onChanged: (value) {
        setState(() {
          val = value;
        });
      },
      title: Text(title, style: Theme.of(context).textTheme.bodyText1),
    );
  }

  // Next button
  Button _nextButton() {
    return Button(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddViewTwo(
                name: _nameController.text,
                description: _descriptionController.text,
                radioValue: val as int,
              ),
            ),
          );
        }
      },
      text: _ThisPageTexts.next,
      height: ProjectButtonSizes.mainButtonHeight,
      width: ProjectButtonSizes.mainButtonWidth,
    );
  }
}

class _ThisPageTexts {
  static const String name = "İsim";
  static const String description = "Açıklama";
  static const String adopt = "Sahiplendir";
  static const String paid = "Ücretli";
  static const String next = "Sonraki";
}
