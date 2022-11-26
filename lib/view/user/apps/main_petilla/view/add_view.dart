import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/components/dialogs/error_dialog.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/viewmodel/add_view_view_model.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends BaseState<AddView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Object? val = 1;

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  RadioListTile get adoptRadioListTile => _radioListTile(1, _ThisPageTexts.adopt, context);

  late AddViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AddViewViewModel(),
      onPageBuilder: (context, value) => buildScaffold,
    );
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: _appBar(),
        body: _body(context, adoptRadioListTile),
      );

  Form _body(BuildContext context, RadioListTile<dynamic> adoptRadioListTile) {
    return Form(
      key: _formKey,
      child: Observer(builder: (_) {
        return ListView(
          padding: ProjectPaddings.horizontalMainPadding,
          children: [
            viewModel.imageFile == null ? _addPhotoContainer(context) : _photoContainer(context),
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
        );
      }),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(_ThisPageTexts.pageTitle),
    );
  }

  Observer _photoContainer(context) {
    return Observer(builder: (_) {
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
              image: FileImage(viewModel.imageFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
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

  Observer _pickCameraButton(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        leading: const Icon(AppIcons.photoCameraIcon),
        title: Text(_ThisPageTexts.camera),
        onTap: () {
          viewModel.pickImageCamera();
          Navigator.of(context).pop();
        },
      );
    });
  }

  Observer _pickGalleryButton(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        leading: const Icon(AppIcons.photoLibraryIcon),
        title: Text(_ThisPageTexts.gellery),
        onTap: () {
          viewModel.pickImageGallery();
          Navigator.of(context).pop();
        },
      );
    });
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
      title: Text(title, style: textTheme.bodyText1),
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
    if (viewModel.image == null) {
      return showErrorDialog(true, _ThisPageTexts.fillAllArea, context);
    }
    if (_formKey.currentState!.validate()) {
      viewModel.callAddViewTwo(_nameController, _descriptionController, val, viewModel.image, context);
    }
  }
}

class _ThisPageTexts {
  static String name = LocaleKeys.name.locale;
  static String description = LocaleKeys.description.locale;
  static String adopt = LocaleKeys.adopt.locale;
  static String next = LocaleKeys.continuePages.locale;
  static String fillAllArea = LocaleKeys.fillAllArea.locale;
  static String gellery = LocaleKeys.selectGallery.locale;
  static String camera = LocaleKeys.shootFromCamera.locale;
  static String pageTitle = LocaleKeys.addPetOneInTwo.locale;
}
