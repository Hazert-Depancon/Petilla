import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/components/buttons/auth_button.dart';
import 'package:patily/core/components/textfields/main_textfield.dart';
import 'package:patily/core/constants/other_constant/icon_names.dart';
import 'package:patily/core/constants/sizes_constant/app_sized_box.dart';
import 'package:patily/core/constants/sizes_constant/project_icon_sizes.dart';
import 'package:patily/core/constants/sizes_constant/project_padding.dart';
import 'package:patily/core/constants/sizes_constant/project_radius.dart';
import 'package:patily/core/extension/string_lang_extension.dart';
import 'package:patily/core/init/lang/locale_keys.g.dart';
import 'package:patily/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/view/user/apps/petcook/viewmodel/add_post_view_model.dart';

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
                  viewModel.imageFile == null
                      ? _addPhotoContainer(context)
                      : _photoContainer(context),
                  mainHeightSizedBox,
                  MainTextField(
                    controller: _descriptionController,
                    hintText: LocaleKeys.description.locale,
                    minLines: 5,
                  ),
                  mainHeightSizedBox,
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
            borderRadius: ProjectRadius.mainAllRadius,
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

  InkWell _addPhotoContainer(context) {
    return InkWell(
      borderRadius: ProjectRadius.mainAllRadius,
      onTap: () {
        _bottomSheet(context);
      },
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          borderRadius: ProjectRadius.mainAllRadius,
        ),
        child: const Icon(
          AppIcons.addPhotoAlternateIcon,
          size: ProjectIconSizes.bigIconSize,
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

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(AppIcons.arrowBackIcon),
    );
  }
}
