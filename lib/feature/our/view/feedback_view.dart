// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/feature/our/viewmodel/feedback_view_view_model.dart';
import 'package:patily/product/widgets/buttons/button.dart';
import 'package:patily/product/widgets/textfields/main_textfield.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';

class FeedBackView extends StatelessWidget {
  FeedBackView({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late FeedBackViewViewModel viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedBackViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: FeedBackViewViewModel(),
      onPageBuilder: (context, value) => _buildscaffold(context),
    );
  }

  Scaffold _buildscaffold(context) {
    return Scaffold(
      appBar: _appBar,
      body: _body(context),
    );
  }

  AppBar get _appBar => AppBar(
        title: Text(LocaleKeys.feedBack.locale),
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Center(
            child: Column(
              children: [
                _titleTextField(),
                context.emptySizedHeightBoxLow3x,
                _descriptionTextField(),
                context.emptySizedHeightBoxLow3x,
                _submitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MainTextField _titleTextField() {
    return MainTextField(
      controller: titleController,
      hintText: LocaleKeys.title.locale,
      isNext: true,
      maxLines: 1,
    );
  }

  MainTextField _descriptionTextField() {
    return MainTextField(
      controller: descriptionController,
      maxLines: 5,
      minLines: 3,
      hintText: LocaleKeys.description.locale,
    );
  }

  Button _submitButton(context) {
    return Button(
      text: LocaleKeys.send.locale,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.onSubmitButton(titleController, descriptionController);
          ScaffoldMessenger.of(context).showSnackBar(_snackBar());
          Navigator.pop(context);
        }
      },
    );
  }

  SnackBar _snackBar() {
    return SnackBar(
      content: Text(LocaleKeys.thanksFeedback.locale),
    );
  }
}
