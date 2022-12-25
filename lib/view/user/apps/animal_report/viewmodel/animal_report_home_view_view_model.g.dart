// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_report_home_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnimalReportHomeViewModel on _AnimalReportHomeViewModelBase, Store {
  late final _$imageAtom =
      Atom(name: '_AnimalReportHomeViewModelBase.image', context: context);

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
      Atom(name: '_AnimalReportHomeViewModelBase.imageFile', context: context);

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

  late final _$isImageLoadedAtom = Atom(
      name: '_AnimalReportHomeViewModelBase.isImageLoaded', context: context);

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

  late final _$interstitialAdAtom = Atom(
      name: '_AnimalReportHomeViewModelBase.interstitialAd', context: context);

  @override
  InterstitialAd? get interstitialAd {
    _$interstitialAdAtom.reportRead();
    return super.interstitialAd;
  }

  @override
  set interstitialAd(InterstitialAd? value) {
    _$interstitialAdAtom.reportWrite(value, super.interstitialAd, () {
      super.interstitialAd = value;
    });
  }

  late final _$loadFirestoreAsyncAction = AsyncAction(
      '_AnimalReportHomeViewModelBase.loadFirestore',
      context: context);

  @override
  Future<void> loadFirestore(
      dynamic dowlandLink,
      dynamic descriptionController,
      dynamic phoneNumberController,
      dynamic swichValue,
      dynamic lat,
      dynamic long,
      dynamic isDamaged) {
    return _$loadFirestoreAsyncAction.run(() => super.loadFirestore(
        dowlandLink,
        descriptionController,
        phoneNumberController,
        swichValue,
        lat,
        long,
        isDamaged));
  }

  late final _$getCurrentLocationAsyncAction = AsyncAction(
      '_AnimalReportHomeViewModelBase.getCurrentLocation',
      context: context);

  @override
  Future<Position> getCurrentLocation() {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation());
  }

  late final _$pickImageCameraAsyncAction = AsyncAction(
      '_AnimalReportHomeViewModelBase.pickImageCamera',
      context: context);

  @override
  Future<void> pickImageCamera() {
    return _$pickImageCameraAsyncAction.run(() => super.pickImageCamera());
  }

  late final _$pickImageGalleryAsyncAction = AsyncAction(
      '_AnimalReportHomeViewModelBase.pickImageGallery',
      context: context);

  @override
  Future<void> pickImageGallery() {
    return _$pickImageGalleryAsyncAction.run(() => super.pickImageGallery());
  }

  late final _$_AnimalReportHomeViewModelBaseActionController =
      ActionController(
          name: '_AnimalReportHomeViewModelBase', context: context);

  @override
  void createInterstitialAd() {
    final _$actionInfo =
        _$_AnimalReportHomeViewModelBaseActionController.startAction(
            name: '_AnimalReportHomeViewModelBase.createInterstitialAd');
    try {
      return super.createInterstitialAd();
    } finally {
      _$_AnimalReportHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showInterstitialAd() {
    final _$actionInfo = _$_AnimalReportHomeViewModelBaseActionController
        .startAction(name: '_AnimalReportHomeViewModelBase.showInterstitialAd');
    try {
      return super.showInterstitialAd();
    } finally {
      _$_AnimalReportHomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
imageFile: ${imageFile},
isImageLoaded: ${isImageLoaded},
interstitialAd: ${interstitialAd}
    ''';
  }
}
