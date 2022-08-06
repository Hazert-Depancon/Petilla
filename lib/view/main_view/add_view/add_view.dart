import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  String imageUrl = "";

  void pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    } else {
      Reference ref = FirebaseStorage.instance.ref("pets").child(image.name);

      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        setState(() {
          imageUrl = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var adoptRadioListTile = _radioListTile(1, _ThisPageTexts.adopt, context);
    var paidRadioListTile = _radioListTile(2, _ThisPageTexts.paid, context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evcil Hayvan Ekle 1/2"),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: Get.height,
          child: ListView(
            padding: ProjectPaddings.horizontalMainPadding,
            children: [
              imageUrl == "" ? _addPhotoContainer(context) : _photoContainer(context),
              const SizedBox(height: 24),
              _petNameTextField(),
              const SizedBox(height: 24),
              _petDescriptionTextField(),
              adoptRadioListTile,
              paidRadioListTile,
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: _nextButton(context),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _photoContainer(context) {
    return InkWell(
      onTap: () {
        _bottomSheet(context);
      },
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: ProjectRadius.mainAllRadius,
          color: LightThemeColors.miamiMarmalade,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _bottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galeri'),
                    onTap: () {
                      pickImage();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Kamera'),
                  onTap: () {
                    // imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  MainTextField _petNameTextField() {
    return _petTextField(
      controller: _nameController,
      isNext: true,
      hintText: _ThisPageTexts.name,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline),
      maxLength: 10,
    );
  }

  MainTextField _petDescriptionTextField() {
    return _petTextField(
      controller: _descriptionController,
      hintText: _ThisPageTexts.description,
      isNext: false,
      maxLength: 175,
      minLines: 1,
      maxLines: 5,
      prefixIcon: const Icon(Icons.description),
    );
  }

  // Add a photo container
  InkWell _addPhotoContainer(context) {
    return InkWell(
      borderRadius: ProjectRadius.mainAllRadius,
      onTap: () {
        _bottomSheet(context);
      },
      child: Container(
        height: 175,
        width: double.infinity,
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

  // Pet description text field
  MainTextField _petTextField({
    TextEditingController? controller,
    bool? isNext,
    int? minLines,
    int? maxLength,
    int? maxLines,
    String? hintText,
    TextInputType? keyboardType,
    Icon? prefixIcon,
  }) {
    return MainTextField(
      controller: controller,
      isNext: isNext,
      minLines: minLines,
      maxLength: maxLength,
      maxLines: maxLines,
      hintText: hintText,
      keyboardType: keyboardType,
      prefixIcon: prefixIcon,
    );
  }

  // Radio list tile
  RadioListTile _radioListTile(int radioNumber, String title, context) {
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
  Button _nextButton(context) {
    return Button(
      onPressed: () {
        _onNextButton(context);
      },
      text: _ThisPageTexts.next,
      height: ProjectButtonSizes.mainButtonHeight,
      width: ProjectButtonSizes.mainButtonWidth,
    );
  }

  _onNextButton(context) {
    if (imageUrl == "") {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Hata',
        desc: 'Fotoğraf yüklenmedi',
        btnCancelOnPress: () {},
        btnCancelText: "Tamam",
      ).show();
    }
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddViewTwo(
            name: _nameController.text,
            description: _descriptionController.text,
            radioValue: val as int,
            image: imageUrl,
          ),
        ),
      );
    }
  }
}

class _ThisPageTexts {
  static const String name = "İsim";
  static const String description = "Açıklama";
  static const String adopt = "Sahiplendir";
  static const String paid = "Ücretli";
  static const String next = "Sonraki";
}
