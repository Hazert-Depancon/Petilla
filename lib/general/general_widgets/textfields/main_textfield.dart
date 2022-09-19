import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class MainTextField extends StatefulWidget {
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

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      textInputAction: widget.isNext == true ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: LightThemeColors.snowbank,
        border: OutlineInputBorder(
          borderRadius: ProjectRadius.allRadius,
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixText: widget.suffix,
        suffixIcon: widget.suffixIcon,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz';
        }
        return null;
      },
    );
  }
}
