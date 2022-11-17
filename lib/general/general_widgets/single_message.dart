import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class SingleMessage extends StatelessWidget {
  const SingleMessage({Key? key, required this.message, required this.isMe}) : super(key: key);
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: _boxDecoration(),
          child: Text(message),
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: isMe ? LightThemeColors.miamiMarmalade.withOpacity(0.6) : Colors.grey[300],
      borderRadius: _borderRadius(),
    );
  }

  BorderRadius _borderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(isMe ? 30 : 0),
      topRight: Radius.circular(isMe ? 0 : 30),
      bottomLeft: const Radius.circular(30),
      bottomRight: const Radius.circular(30),
    );
  }
}
