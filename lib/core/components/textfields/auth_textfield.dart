// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patily/core/constants/sizes_constant/project_radius.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/core/extension/string_lang_extension.dart';
import 'package:patily/core/init/lang/locale_keys.g.dart';
import 'package:patily/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/core/validation/regex_validations.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField(
    this.isPassword, {
    Key? key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.isNext,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final prefixIcon;
  final TextInputType? keyboardType;
  final bool? isNext;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends BaseState<AuthTextField> {
  bool? _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: ProjectRadius.mainAllRadius,
        boxShadow: const [
          BoxShadow(
            color: LightThemeColors.shadowColor,
            offset: Offset(10, 10),
            blurRadius: 30,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: LightThemeColors.white,
            offset: Offset(-10, -10),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText!,
        textInputAction:
            widget.isNext == true ? TextInputAction.next : TextInputAction.done,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          filled: true,
          fillColor: LightThemeColors.snowbank.withOpacity(0.9),
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: LightThemeColors.black,
          ),
          suffixIcon: widget.isPassword ? _visibilityIcon() : null,
          border: OutlineInputBorder(
            borderRadius: ProjectRadius.mainAllRadius,
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return LocaleKeys.validation_emptyValidation.locale;
          }
          if (widget.keyboardType == TextInputType.emailAddress) {
            if (!RegexValidations.instance.emailRegex.hasMatch(value)) {
              return LocaleKeys.validation_mailValidation.locale;
            }
          }
          return null;
        },
      ),
    );
  }

  IconButton _visibilityIcon() {
    return IconButton(
      icon: _obscureText == false
          ? SvgPicture.asset(
              Assets.svg.eyeOpen,
              color: LightThemeColors.black,
            )
          : SvgPicture.asset(
              Assets.svg.eyeClose,
              color: LightThemeColors.black,
            ),
      onPressed: () {
        _changeVisibility();
      },
    );
  }

  void _changeVisibility() {
    return setState(() {
      _obscureText = !_obscureText!;
    });
  }
}
