// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddPostViewModel on _AddPostViewModelBase, Store {
  late final _$imageAtom =
      Atom(name: '_AddPostViewModelBase.image', context: context);

  @override
  XFile? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(XFile? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$imageFileAtom =
      Atom(name: '_AddPostViewModelBase.imageFile', context: context);

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  late final _$isImageLoadedAtom =
      Atom(name: '_AddPostViewModelBase.isImageLoaded', context: context);

  @override
  bool get isImageLoaded {
    _$isImageLoadedAtom.reportRead();
    return super.isImageLoaded;
  }

  @override
  set isImageLoaded(bool value) {
    _$isImageLoadedAtom.reportWrite(value, super.isImageLoaded, () {
      super.isImageLoaded = value;
    });
  }

  late final _$pickImageCameraAsyncAction =
      AsyncAction('_AddPostViewModelBase.pickImageCamera', context: context);

  @override
  Future<void> pickImageCamera() {
    return _$pickImageCameraAsyncAction.run(() => super.pickImageCamera());
  }

  late final _$pickImageGalleryAsyncAction =
      AsyncAction('_AddPostViewModelBase.pickImageGallery', context: context);

  @override
  Future<void> pickImageGallery() {
    return _$pickImageGalleryAsyncAction.run(() => super.pickImageGallery());
  }

  late final _$onSubmitButtonAsyncAction =
      AsyncAction('_AddPostViewModelBase.onSubmitButton', context: context);

  @override
  Future<void> onSubmitButton(
      TextEditingController descriptionController, dynamic image) {
    return _$onSubmitButtonAsyncAction
        .run(() => super.onSubmitButton(descriptionController, image));
  }

  @override
  String toString() {
    return '''
image: ${image},
imageFile: ${imageFile},
isImageLoaded: ${isImageLoaded}
    ''';
  }
}
