import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/question_form_model.dart';

class InFormView extends StatelessWidget {
  const InFormView({super.key, required this.formModel});
  final QuestionFormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(formModel.description),
          ],
        ),
      ),
    );
  }

  AppBar get _appBar => AppBar(
        title: Text(formModel.title),
      );
}
