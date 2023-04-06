/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icons/icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [icon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/fallow_instagram.png
  AssetGenImage get fallowInstagram =>
      const AssetGenImage('assets/images/fallow_instagram.png');

  /// File path: assets/images/help_me.png
  AssetGenImage get helpMe => const AssetGenImage('assets/images/help_me.png');

  /// File path: assets/images/login_background_image.png
  AssetGenImage get loginBackgroundImage =>
      const AssetGenImage('assets/images/login_background_image.png');

  /// File path: assets/images/patily_form.png
  AssetGenImage get patilyForm =>
      const AssetGenImage('assets/images/patily_form.png');

  /// File path: assets/images/patily_sahiplen_image.png
  AssetGenImage get patilySahiplenImage =>
      const AssetGenImage('assets/images/patily_sahiplen_image.png');

  /// File path: assets/images/pet_cook_image.png
  AssetGenImage get petCookImage =>
      const AssetGenImage('assets/images/pet_cook_image.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        fallowInstagram,
        helpMe,
        loginBackgroundImage,
        patilyForm,
        patilySahiplenImage,
        petCookImage
      ];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/il-ilce.json
  String get ilIlce => 'assets/jsons/il-ilce.json';

  /// File path: assets/jsons/iller.json
  String get iller => 'assets/jsons/iller.json';

  $AssetsJsonsLangGen get lang => const $AssetsJsonsLangGen();

  /// List of all assets
  List<String> get values => [ilIlce, iller];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/bird.svg
  String get bird => 'assets/svg/bird.svg';

  /// File path: assets/svg/cat.svg
  String get cat => 'assets/svg/cat.svg';

  /// File path: assets/svg/chat.svg
  String get chat => 'assets/svg/chat.svg';

  /// File path: assets/svg/dog.svg
  String get dog => 'assets/svg/dog.svg';

  /// File path: assets/svg/eye_close.svg
  String get eyeClose => 'assets/svg/eye_close.svg';

  /// File path: assets/svg/eye_open.svg
  String get eyeOpen => 'assets/svg/eye_open.svg';

  /// File path: assets/svg/filter.svg
  String get filter => 'assets/svg/filter.svg';

  /// File path: assets/svg/fish.svg
  String get fish => 'assets/svg/fish.svg';

  /// File path: assets/svg/home.svg
  String get home => 'assets/svg/home.svg';

  /// File path: assets/svg/home_outline.svg
  String get homeOutline => 'assets/svg/home_outline.svg';

  /// File path: assets/svg/language.svg
  String get language => 'assets/svg/language.svg';

  /// File path: assets/svg/onboarding_one.svg
  String get onboardingOne => 'assets/svg/onboarding_one.svg';

  /// File path: assets/svg/onboarding_three.svg
  String get onboardingThree => 'assets/svg/onboarding_three.svg';

  /// File path: assets/svg/onboarding_two.svg
  String get onboardingTwo => 'assets/svg/onboarding_two.svg';

  /// File path: assets/svg/password.svg
  String get password => 'assets/svg/password.svg';

  /// File path: assets/svg/plus.svg
  String get plus => 'assets/svg/plus.svg';

  /// File path: assets/svg/profile.svg
  String get profile => 'assets/svg/profile.svg';

  /// File path: assets/svg/rabbit.svg
  String get rabbit => 'assets/svg/rabbit.svg';

  /// File path: assets/svg/send.svg
  String get send => 'assets/svg/send.svg';

  /// File path: assets/svg/settings.svg
  String get settings => 'assets/svg/settings.svg';

  /// List of all assets
  List<String> get values => [
        bird,
        cat,
        chat,
        dog,
        eyeClose,
        eyeOpen,
        filter,
        fish,
        home,
        homeOutline,
        language,
        onboardingOne,
        onboardingThree,
        onboardingTwo,
        password,
        plus,
        profile,
        rabbit,
        send,
        settings
      ];
}

class $AssetsJsonsLangGen {
  const $AssetsJsonsLangGen();

  /// File path: assets/jsons/lang/tr-TR.json
  String get trTR => 'assets/jsons/lang/tr-TR.json';

  /// List of all assets
  List<String> get values => [trTR];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
