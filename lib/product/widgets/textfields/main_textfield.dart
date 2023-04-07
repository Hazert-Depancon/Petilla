import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.suffix,
    this.maxLength,
    this.isNext,
    this.enabled,
    this.suffixIcon,
    this.prefix,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final String? suffix;
  final int? maxLength;
  final bool? isNext;
  final bool? enabled;
  final Icon? suffixIcon;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textInputAction:
          isNext == true ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: LightThemeColors.snowbank,
        border: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        prefixText: prefix,
        prefixIcon: prefixIcon,
        suffixText: suffix,
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocaleKeys.validation_emptyValidation.locale;
        }
        return null;
      },
    );
  }
}
