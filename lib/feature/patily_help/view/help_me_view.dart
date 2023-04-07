// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/widgets/buttons/button.dart';
import 'package:patily/product/widgets/dialogs/default_dialog.dart';
import 'package:patily/product/widgets/textfields/main_textfield.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:patily/feature/patily_help/viewmodel/help_me_view_view_model.dart';
import 'package:patily/feature/patily_sahiplen/service/storage_service.dart/storage_crud.dart';

class HelpMeView extends StatefulWidget {
  const HelpMeView({super.key});

  @override
  State<HelpMeView> createState() => _HelpMeViewState();
}

class _HelpMeViewState extends BaseState<HelpMeView> {
  late HelpMeViewViewModel viewModel;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherNeedsController = TextEditingController();

  bool isVetHelp = false;
  bool isFoodHelp = false;

  RadioListTile _locationRadioListTile(BuildContext context) =>
      _radioListTile(1, LocaleKeys.getCurrentLocation.locale, context);
  Object? currentLocationVal = 1;

  final _formKey = GlobalKey<FormState>();

  String? lat;
  String? long;

  String dowlandLink = "";

  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpMeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: HelpMeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody(context),
    );
  }

  SafeArea _buildBody(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Observer(builder: (_) {
            return Column(
              children: [
                viewModel.imageFile == null
                    ? _addPhotoContainer(context)
                    : _photoContainer(context),
                context.emptySizedHeightBoxLow3x,
                _titleTextField,
                context.emptySizedHeightBoxLow,
                _descriptionTextField,
                context.emptySizedHeightBoxLow3x,
                _otherNeedsTextfield,
                context.emptySizedHeightBoxLow,
                vetHelpCheckBoxListTile,
                context.emptySizedHeightBoxLow,
                foodHelpCheckBoxListTile,
                context.emptySizedHeightBoxLow,
                _locationRadioListTile(context),
                context.emptySizedHeightBoxLow,
                _submitButton,
                context.emptySizedHeightBoxLow,
              ],
            );
          }),
        ),
      ),
    );
  }

  Observer _photoContainer(BuildContext context) {
    return Observer(builder: (_) {
      return InkWell(
        onTap: () {
          _bottomSheet(context);
        },
        child: Container(
          height: 175,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
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

  InkWell _addPhotoContainer(BuildContext context) {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: () {
        _bottomSheet(context);
      },
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          borderRadius: context.normalBorderRadius,
        ),
        child: const Icon(
          AppIcons.addPhotoAlternateIcon,
          size: 36,
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

  Observer _pickCameraButton(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        leading: const Icon(AppIcons.photoCameraIcon),
        title: Text(LocaleKeys.shootFromCamera.locale),
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
        title: Text(LocaleKeys.selectGallery.locale),
        onTap: () {
          viewModel.pickImageGallery();
          Navigator.of(context).pop();
        },
      );
    });
  }

  MainTextField get _otherNeedsTextfield {
    return MainTextField(
      hintText: LocaleKeys.otherNeeds.locale,
      controller: otherNeedsController,
    );
  }

  RadioListTile _radioListTile(
      int radioNumber, String title, BuildContext context) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: context.normalBorderRadius,
      ),
      contentPadding: EdgeInsets.zero,
      groupValue: currentLocationVal,
      value: radioNumber,
      selected: currentLocationVal == radioNumber,
      onChanged: (value) {
        setState(() {
          currentLocationVal = value;
        });
      },
      title: Text(title, style: textTheme.bodyLarge),
    );
  }

  CheckboxListTile get vetHelpCheckBoxListTile {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(borderRadius: context.normalBorderRadius),
      value: isVetHelp,
      onChanged: (value) {
        setState(() {
          isVetHelp = value!;
        });
      },
      title: Text(LocaleKeys.vetHelp.locale),
    );
  }

  CheckboxListTile get foodHelpCheckBoxListTile {
    return CheckboxListTile(
      shape: RoundedRectangleBorder(borderRadius: context.normalBorderRadius),
      value: isFoodHelp,
      onChanged: (value) {
        setState(() {
          isFoodHelp = value!;
        });
      },
      title: Text(LocaleKeys.foodHelp.locale),
    );
  }

  Button get _submitButton {
    return Button(
      text: LocaleKeys.patilySahiplenPages_addAPet.locale,
      onPressed: () {
        onSubmitButtonClicked(context);
      },
    );
  }

  void onSubmitButtonClicked(context) async {
    if (_formKey.currentState!.validate()) {
      if (_isClicked == false) {
        _isClicked = true;
        showDefaultLoadingDialog(true, context);
        await _getCurrentLocation().then((value) {
          lat = "${value.latitude}";
          long = "${value.longitude}";
        });
        viewModel.isImageLoaded || viewModel.image != null
            ? dowlandLink = await StorageCrud().addPhotoToStorage(
                viewModel.image!,
                FirebaseCollectionEnum.animalHelp.toString(),
              )
            : null;

        viewModel
            .loadFirestore(
              HelpMeModel(
                title: titleController.text,
                description: descriptionController.text,
                long: long!,
                lat: lat!,
                isVetHelp: isVetHelp,
                isFoodHelp: isFoodHelp,
                imageDowlandUrl: dowlandLink,
                currentUserEmail: FirebaseAuth.instance.currentUser!.email!,
                currentUserId: FirebaseAuth.instance.currentUser!.uid,
                currentUserName:
                    FirebaseAuth.instance.currentUser!.displayName!,
                otherNeeds: otherNeedsController.text.trim(),
              ),
            )
            .then(
              (value) => viewModel.callHelpMeHomeView(),
            );
      }
    }
  }

  Future _getCurrentLocation() => viewModel.getCurrentLocation();

  MainTextField get _descriptionTextField {
    return MainTextField(
      controller: descriptionController,
      hintText: LocaleKeys.description.locale,
      minLines: 5,
    );
  }

  MainTextField get _titleTextField {
    return MainTextField(
      hintText: LocaleKeys.title.locale,
      isNext: true,
      maxLength: 10,
      controller: titleController,
    );
  }

  AppBar get _buildAppBar => AppBar();
}
