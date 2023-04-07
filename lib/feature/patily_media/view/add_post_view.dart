import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/product/widgets/buttons/auth_button.dart';
import 'package:patily/product/widgets/textfields/main_textfield.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/feature/patily_media/viewmodel/add_post_view_model.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  late AddPostViewModel viewModel;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();

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
      foregroundColor: LightThemeColors.black,
      title: Text(
        LocaleKeys.sharePhoto.locale,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Observer _body(BuildContext context) {
    return Observer(
      builder: (context) {
        return Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: context.horizontalPaddingNormal,
              child: Column(
                children: [
                  viewModel.imageFile == null
                      ? _addPhotoContainer(context)
                      : _photoContainer(context),
                  context.emptySizedHeightBoxLow3x,
                  MainTextField(
                    controller: _descriptionController,
                    hintText: LocaleKeys.description.locale,
                    minLines: 5,
                  ),
                  context.emptySizedHeightBoxLow3x,
                  AuthButton(
                    onPressed: () {
                      if (viewModel.image != null) {
                        if (_formKey.currentState!.validate()) {
                          viewModel.onSubmitButton(
                              _descriptionController, viewModel.image);
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

  Observer _photoContainer(context) {
    return Observer(builder: (_) {
      return InkWell(
        onTap: () {
          _bottomSheet(context);
        },
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: LightThemeColors.miamiMarmalade,
            image: DecorationImage(
              image: FileImage(viewModel.imageFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }

  InkWell _addPhotoContainer(BuildContext context) {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: () {
        _bottomSheet(context);
      },
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          borderRadius: context.normalBorderRadius,
        ),
        child: const Icon(
          AppIcons.addPhotoAlternateIcon,
          size: 36,
        ),
      ),
    );
  }

  Future<dynamic> _bottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              _pickGalleryButton(context),
              _pickCameraButton(context),
            ],
          ),
        );
      },
    );
  }

  Observer _pickCameraButton(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        leading: const Icon(AppIcons.photoCameraIcon),
        title: Text(LocaleKeys.shootFromCamera.locale),
        onTap: () {
          viewModel.pickImageCamera();
          Navigator.of(context).pop();
        },
      );
    });
  }

  Observer _pickGalleryButton(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        leading: const Icon(AppIcons.photoLibraryIcon),
        title: Text(LocaleKeys.selectGallery.locale),
        onTap: () {
          viewModel.pickImageGallery();
          Navigator.of(context).pop();
        },
      );
    });
  }
}
