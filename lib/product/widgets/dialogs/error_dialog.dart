import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
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
  static String confirmBtnText = LocaleKeys.ok.locale;
  static String error = LocaleKeys.error.locale;
}
