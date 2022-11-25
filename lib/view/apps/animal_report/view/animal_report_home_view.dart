import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
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
  late AnimalReportHomeViewModel viewModel;

  var normalWidthSizedBox = AppSizedBoxs.normalWidthSizedBox;
  var mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;

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
        body: SingleChildScrollView(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Column(
            children: [
              const MainTextField(),
              mainHeightSizedBox,
              const MainTextField(),
              mainHeightSizedBox,
              const MainTextField(),
              mainHeightSizedBox,
              const MainTextField(),
            ],
          ),
        ),
      );

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
