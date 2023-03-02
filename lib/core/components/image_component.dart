import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_icon_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class AddImageComponent extends StatefulWidget {
  AddImageComponent({
    super.key,
    required this.isImageLoaded,
    this.imageFile,
    this.image,
  });

  late bool isImageLoaded;
  late File? imageFile;
  late XFile? image;

  @override
  State<AddImageComponent> createState() => _AddImageComponentState();
}

class _AddImageComponentState extends State<AddImageComponent> {
  bool isImageLoaded = false;
  File? imageFile;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return widget.imageFile == null
        ? _addPhotoContainer(context)
        : _photoContainer(context);
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
              image: FileImage(widget.imageFile!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
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
          pickImageCamera();
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
          pickImageGallery();
          Navigator.of(context).pop();
        },
      );
    });
  }

  Future<void> pickImageCamera() async {
    widget.image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (widget.image == null) {
      return;
    } else {
      setState(() {
        widget.isImageLoaded = true;
        widget.imageFile = File(widget.image!.path);
      });
    }
  }

  Future<void> pickImageGallery() async {
    widget.image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (widget.image == null) {
      return;
    } else {
      setState(() {
        widget.isImageLoaded = true;
        widget.imageFile = File(widget.image!.path);
      });
    }
  }
}
