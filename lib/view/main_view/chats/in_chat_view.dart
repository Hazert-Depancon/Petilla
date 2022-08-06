import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';

class InChatView extends StatefulWidget {
  const InChatView({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  State<InChatView> createState() => _InChatViewState();
}

class _InChatViewState extends State<InChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
    );
  }
}
