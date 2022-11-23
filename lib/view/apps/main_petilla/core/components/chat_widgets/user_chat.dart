// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';

class UserChat extends StatelessWidget {
  UserChat({Key? key, required this.onTap, required this.name, required this.lastMsg}) : super(key: key);

  final VoidCallback onTap;
  final String name;
  final String lastMsg;

  var smallSizedBox = AppSizedBoxs.smallHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 35,
              child: Text(
                name[0],
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headline6),
                  smallSizedBox,
                  Text(lastMsg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
