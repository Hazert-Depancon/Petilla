import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/animal_report/viewmodel/animal_report_home_view_view_model.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/storage_service.dart/storage_crud.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AnimalReportHomeView extends StatefulWidget {
  const AnimalReportHomeView({super.key});

  @override
  State<AnimalReportHomeView> createState() => _AnimalReportHomeViewState();
}

class _AnimalReportHomeViewState extends BaseState<AnimalReportHomeView> {
  final _formKey = GlobalKey<FormState>();
  late AnimalReportHomeViewModel viewModel;

  var normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;
  bool swichValue = false;
  RadioListTile get _locationRadioListTile => _radioListTile(1, LocaleKeys.getCurrentLocation.locale, context);
  Object? val = 1;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? lat;
  String? long;

  String dowlandLink = "";

  @override
  Widget build(BuildContext context) {
    return BaseView<AnimalReportHomeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AnimalReportHomeViewModel(),
      onPageBuilder: (context, value) => buildScaffold(context),
    );
  }

  Scaffold buildScaffold(context) => Scaffold(
        appBar: _appBar(context),
        body: _body(context),
      );

  AppBar _appBar(context) => AppBar(
        title: Text(LocaleKeys.reportAnimal.locale),
        foregroundColor: LightThemeColors.miamiMarmalade,
        actions: [
          _callIcon(),
          normalWidthSizedBox,
          _infoIcon(context),
          normalWidthSizedBox,
        ],
      );

  Form _body(context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Observer(builder: (_) {
          return Column(
            children: [
              viewModel.imageFile == null ? _addPhotoContainer(context) : _photoContainer(context),
              mainHeightSizedBox,
              _descriptionTextField(),
              mainHeightSizedBox,
              _contactPhoneTextField(),
              mainHeightSizedBox,
              _adoptListTile(context),
              mainHeightSizedBox,
              _locationRadioListTile,
              mainHeightSizedBox,
              _button()
            ],
          );
        }),
      ),
    );
  }

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

  ListTile _adoptListTile(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        LocaleKeys.adopt.locale,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: _adoptSwich(),
    );
  }

  Switch _adoptSwich() {
    return Switch(
      value: swichValue,
      onChanged: (value) {
        setState(() {
          swichValue = value;
        });
      },
    );
  }

  MainTextField _contactPhoneTextField() {
    return MainTextField(
      hintText: LocaleKeys.contactPhone.locale,
      prefix: "+90 ",
      controller: phoneNumberController,
    );
  }

  MainTextField _descriptionTextField() {
    return MainTextField(
      hintText: LocaleKeys.description.locale,
      isNext: true,
      controller: descriptionController,
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

  GestureDetector _callIcon() {
    return GestureDetector(
      onTap: () {
        launchUrlString("tel://153");
      },
      child: const Icon(
        Icons.phone_outlined,
        color: LightThemeColors.black,
      ),
    );
  }

  GestureDetector _infoIcon(context) {
    return GestureDetector(
      onTap: () => quickInfoAlertDialog(context),
      child: const Icon(
        Icons.info_outline_rounded,
        color: LightThemeColors.black,
      ),
    );
  }

  quickInfoAlertDialog(context) {
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      confirmBtnColor: LightThemeColors.miamiMarmalade,
      title: LocaleKeys.reportAnimal.locale,
      text: LocaleKeys.reportAnimalInfo.locale,
      confirmBtnText: LocaleKeys.ok.locale,
      borderRadius: 24,
    );
  }

  Observer _button() {
    return Observer(builder: (_) {
      return Button(
        height: ProjectButtonSizes.mainButtonHeight,
        width: ProjectButtonSizes.mainButtonWidth,
        onPressed: onSubmitButtonClicked,
        text: LocaleKeys.report.locale,
      );
    });
  }

  void onSubmitButtonClicked() async {
    if (_formKey.currentState!.validate()) {
      await _getCurrentLocation().then((value) {
        setState(() {
          lat = "${value.latitude}";
          long = "${value.longitude}";
        });
      });
      viewModel.isImageLoaded || viewModel.image != null
          ? dowlandLink = await StorageCrud().addPhotoToStorage(
              viewModel.image!,
              AppFirestoreCollectionNames.reportAnimalCollection,
            )
          : null;

      await viewModel.loadFirestore(
        dowlandLink,
        descriptionController,
        phoneNumberController,
        swichValue,
        lat,
        long,
      );
    }
  }

  Future _getCurrentLocation() => viewModel.getCurrentLocation();
}
