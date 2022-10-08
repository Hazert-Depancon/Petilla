import 'package:easy_localization/easy_localization.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:quickalert/quickalert.dart';

showErrorDialog(bool dismissible, String error, context) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: "error".tr(),
    text: error,
    barrierDismissible: dismissible,
    confirmBtnText: "ok".tr(),
    confirmBtnColor: LightThemeColors.miamiMarmalade,
  );
}
