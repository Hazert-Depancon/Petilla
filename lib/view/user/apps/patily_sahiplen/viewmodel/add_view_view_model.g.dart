// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddViewViewModel on _AddViewViewModelBase, Store {
  late final _$imageAtom =
      Atom(name: '_AddViewViewModelBase.image', context: context);

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
      Atom(name: '_AddViewViewModelBase.imageFile', context: context);

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

  late final _$pickImageCameraAsyncAction =
      AsyncAction('_AddViewViewModelBase.pickImageCamera', context: context);

  @override
  Future<void> pickImageCamera() {
    return _$pickImageCameraAsyncAction.run(() => super.pickImageCamera());
  }

  late final _$pickImageGalleryAsyncAction =
      AsyncAction('_AddViewViewModelBase.pickImageGallery', context: context);

  @override
  Future<void> pickImageGallery() {
    return _$pickImageGalleryAsyncAction.run(() => super.pickImageGallery());
  }

  late final _$_AddViewViewModelBaseActionController =
      ActionController(name: '_AddViewViewModelBase', context: context);

  @override
  void callAddViewTwo(dynamic name, dynamic description, dynamic val,
      dynamic image, dynamic context) {
    final _$actionInfo = _$_AddViewViewModelBaseActionController.startAction(
        name: '_AddViewViewModelBase.callAddViewTwo');
    try {
      return super.callAddViewTwo(name, description, val, image, context);
    } finally {
      _$_AddViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
imageFile: ${imageFile}
    ''';
  }
}
