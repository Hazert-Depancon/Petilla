import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/view/add_view_two.dart';

class AddViewModel {
  void callAddViewTwo(name, description, val, image, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddViewTwo(
          name: name.text,
          description: description.text,
          radioValue: val as int,
          image: image!,
        ),
      ),
    );
  }
}
