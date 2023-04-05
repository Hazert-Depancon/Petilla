// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_view_two_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddViewTwoViewModel on _AddViewTwoViewModelBase, Store {
  late final _$interstitialAdAtom =
      Atom(name: '_AddViewTwoViewModelBase.interstitialAd', context: context);

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

  late final _$_AddViewTwoViewModelBaseActionController =
      ActionController(name: '_AddViewTwoViewModelBase', context: context);

  @override
  void createInterstitialAd() {
    final _$actionInfo = _$_AddViewTwoViewModelBaseActionController.startAction(
        name: '_AddViewTwoViewModelBase.createInterstitialAd');
    try {
      return super.createInterstitialAd();
    } finally {
      _$_AddViewTwoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showInterstitialAd() {
    final _$actionInfo = _$_AddViewTwoViewModelBaseActionController.startAction(
        name: '_AddViewTwoViewModelBase.showInterstitialAd');
    try {
      return super.showInterstitialAd();
    } finally {
      _$_AddViewTwoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onSubmitButton(
      dynamic context,
      dynamic image,
      dynamic imageUrl,
      dynamic genderSelectedValue,
      dynamic name,
      dynamic description,
      dynamic ageRangeSelectedValue,
      dynamic secilenIl,
      dynamic secilenIlce,
      dynamic type,
      dynamic radioValue,
      dynamic petSelectedValue) {
    final _$actionInfo = _$_AddViewTwoViewModelBaseActionController.startAction(
        name: '_AddViewTwoViewModelBase.onSubmitButton');
    try {
      return super.onSubmitButton(
          context,
          image,
          imageUrl,
          genderSelectedValue,
          name,
          description,
          ageRangeSelectedValue,
          secilenIl,
          secilenIlce,
          type,
          radioValue,
          petSelectedValue);
    } finally {
      _$_AddViewTwoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
interstitialAd: ${interstitialAd}
    ''';
  }
}
