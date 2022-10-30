import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/add_view/add_view_model.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/dialogs/error_dialog.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Object? val = 1;
  XFile? image;

  File? imageFile;

  void pickImageGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    } else {
      setState(() {
        imageFile = File(image!.path);
      });
    }
  }

  void pickImageCamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      setState(() {
        imageFile = File(image!.path);
      });
    }
  }

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    var adoptRadioListTile = _radioListTile(1, _ThisPageTexts.adopt, context);
    return Scaffold(
      appBar: _appBar(),
      body: _body(context, adoptRadioListTile),
    );
  }

  Form _body(BuildContext context, RadioListTile<dynamic> adoptRadioListTile) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: ProjectPaddings.horizontalMainPadding,
        children: [
          imageFile == null ? _addPhotoContainer(context) : _photoContainer(context),
          mainSizedBox,
          _petNameTextField(),
          mainSizedBox,
          _petDescriptionTextField(),
          adoptRadioListTile,
          mainSizedBox,
          Align(
            child: _nextButton(context),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(_ThisPageTexts.pageTitle),
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
            image: FileImage(imageFile!),
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
              _pickGalleryButton(context),
              _pickCameraButton(context),
            ],
          ),
        );
      },
    );
  }

  ListTile _pickCameraButton(BuildContext context) {
    return ListTile(
      leading: const Icon(AppIcons.photoCameraIcon),
      title: Text(_ThisPageTexts.camera),
      onTap: () {
        pickImageCamera();
        Navigator.of(context).pop();
      },
    );
  }

  ListTile _pickGalleryButton(BuildContext context) {
    return ListTile(
      leading: const Icon(AppIcons.photoLibraryIcon),
      title: Text(_ThisPageTexts.gellery),
      onTap: () {
        pickImageGallery();
        Navigator.of(context).pop();
      },
    );
  }

  MainTextField _petNameTextField() {
    return _petTextField(
      controller: _nameController,
      isNext: true,
      hintText: _ThisPageTexts.name,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(AppIcons.personOutlineIcon),
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
      prefixIcon: const Icon(AppIcons.descriptionIcon),
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
          AppIcons.addPhotoAlternateIcon,
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
      selected: val == radioNumber,
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
    if (image == null) {
      return showErrorDialog(true, _ThisPageTexts.fillAllArea, context);
    }
    if (_formKey.currentState!.validate()) {
      AddViewModel().callAddViewTwo(_nameController, _descriptionController, val, image, context);
    }
  }
}

class _ThisPageTexts {
  static String name = Localization.name;
  static String description = Localization.description;
  static String adopt = Localization.adopt;
  static String next = Localization.next;
  static String fillAllArea = Localization.fillAllArea;
  static String gellery = Localization.selectGallery;
  static String camera = Localization.shootCamera;
  static String pageTitle = Localization.addPhotoTwoInOne;
}
