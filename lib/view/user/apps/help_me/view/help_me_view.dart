// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/buttons/button.dart';
import 'package:petilla_app_project/core/components/dialogs/default_dialog.dart';
import 'package:petilla_app_project/core/components/image_component.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/view/user/apps/help_me/core/models/help_me_model.dart';
import 'package:petilla_app_project/view/user/apps/help_me/viewmodel/help_me_view_view_model.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/storage_service.dart/storage_crud.dart';

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

  final mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;

  bool isVetHelp = false;
  bool isFoodHelp = false;

  RadioListTile get _locationRadioListTile =>
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

  SafeArea _buildBody(context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Observer(builder: (_) {
            return Column(
              children: [
                AddImageComponent(
                  image: viewModel.image,
                  isImageLoaded: viewModel.isImageLoaded,
                  imageFile: viewModel.imageFile,
                ),
                mainHeightSizedBox,
                _titleTextField,
                mainHeightSizedBox,
                _descriptionTextField,
                mainHeightSizedBox,
                _otherNeedsTextfield,
                mainHeightSizedBox,
                vetHelpCheckBoxListTile,
                mainHeightSizedBox,
                foodHelpCheckBoxListTile,
                mainHeightSizedBox,
                _locationRadioListTile,
                mainHeightSizedBox,
                _submitButton,
                mainHeightSizedBox,
              ],
            );
          }),
        ),
      ),
    );
  }

  MainTextField get _otherNeedsTextfield {
    return MainTextField(
      hintText: LocaleKeys.otherNeeds.locale,
      controller: otherNeedsController,
    );
  }

  RadioListTile _radioListTile(int radioNumber, String title, context) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: ProjectRadius.buttonAllRadius,
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
      shape: RoundedRectangleBorder(borderRadius: ProjectRadius.allRadius),
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
      shape: RoundedRectangleBorder(borderRadius: ProjectRadius.allRadius),
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
      text: LocaleKeys.petillaPages_addAPet.locale,
      height: ProjectButtonSizes.mainButtonHeight,
      width: ProjectButtonSizes.mainButtonWidth,
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
                AppFirestoreCollectionNames.animalHelp,
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
