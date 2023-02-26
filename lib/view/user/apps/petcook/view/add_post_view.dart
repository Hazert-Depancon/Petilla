import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/buttons/auth_button.dart';
import 'package:petilla_app_project/core/components/image_component.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/petcook/viewmodel/add_post_view_model.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  late AddPostViewModel viewModel;
  final mainHeightSizedBox = AppSizedBoxs.mainHeightSizedBox;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  late bool isImageLoaded;
  File? imageFile;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddPostViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AddPostViewModel(),
      onPageBuilder: (context, value) {
        return _buildScaffold(context);
      },
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: _backIcon(context),
      foregroundColor: LightThemeColors.black,
      title: Text(
        LocaleKeys.sharePhoto.locale,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Observer _body(context) {
    return Observer(
      builder: (context) {
        return Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: ProjectPaddings.horizontalMainPadding,
              child: Column(
                children: [
                  AddImageComponent(
                    image: image,
                    isImageLoaded: isImageLoaded,
                    imageFile: imageFile,
                  ),
                  mainHeightSizedBox,
                  MainTextField(
                    controller: _descriptionController,
                    hintText: LocaleKeys.description.locale,
                    minLines: 5,
                  ),
                  mainHeightSizedBox,
                  AuthButton(
                    onPressed: () {
                      if (image != null) {
                        if (_formKey.currentState!.validate()) {
                          viewModel.onSubmitButton(
                              _descriptionController, image);
                        }
                      }
                    },
                    text: LocaleKeys.share.locale,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(AppIcons.arrowBackIcon),
    );
  }
}
