import 'package:petilla_app_project/init/theme/light_theme/light_theme_colors.dart';
import 'package:quickalert/quickalert.dart';

showErrorDialog(bool dismissible, String error, context) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: _ThisDialogConstantsTexts.error,
    text: error,
    barrierDismissible: dismissible,
    confirmBtnText: _ThisDialogConstantsTexts.confirmBtnText,
    confirmBtnColor: LightThemeColors.miamiMarmalade,
  );
}

class _ThisDialogConstantsTexts {
  static String confirmBtnText = "Tamam";
  static String error = "Hata";
}
