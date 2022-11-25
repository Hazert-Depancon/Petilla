import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/apps/animal_report/viewmodel/animal_report_home_view_view_model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AnimalReportHomeView extends StatefulWidget {
  const AnimalReportHomeView({super.key});

  @override
  State<AnimalReportHomeView> createState() => _AnimalReportHomeViewState();
}

class _AnimalReportHomeViewState extends State<AnimalReportHomeView> {
  final _formKey = GlobalKey<FormState>();
  late AnimalReportHomeViewModel viewModel;

  var normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;
  bool swichValue = false;

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
              const MainTextField(
                hintText: "Açıklama",
                isNext: true,
              ),
              mainHeightSizedBox,
              const MainTextField(
                hintText: "İletişim Numarası",
                prefix: "+90 ",
              ),
              mainHeightSizedBox,
              ListTile(
                title: Text(
                  LocaleKeys.adopt.locale,
                  style: Theme.of(context).textTheme.headline5,
                ),
                trailing: Switch(
                  value: swichValue,
                  onChanged: (value) {
                    setState(() {
                      swichValue = value;
                    });
                  },
                ),
              ),
              mainHeightSizedBox,
              _button()
            ],
          );
        }),
      ),
    );
  }

  Button _button() {
    return Button(
      height: ProjectButtonSizes.mainButtonHeight,
      width: ProjectButtonSizes.mainButtonWidth,
      onPressed: () {},
      text: "Bildir",
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
        title: const Text("Kameradan Çek"),
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
        title: const Text("Galeriden Seç"),
        onTap: () {
          // pickImageGallery();
          viewModel.pickImageGallery();
          Navigator.of(context).pop();
        },
      );
    });
  }

  AppBar _appBar(context) => AppBar(
        title: const Text("Hayvan Bildir"),
        foregroundColor: LightThemeColors.miamiMarmalade,
        actions: [
          _callIcon(),
          normalWidthSizedBox,
          _infoIcon(context),
          normalWidthSizedBox,
        ],
      );

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
      title: "Hayvan Bildir",
      text:
          "Hayvan bildir özelliği sayesinde sokakta karşılaştığınız hayvanları belediyenize veya barınaklara bildirerek zararsız hale getirilmesiniz sağlayabilirsiniz!",
      confirmBtnText: "TAMAM",
      borderRadius: 24,
    );
  }
}
