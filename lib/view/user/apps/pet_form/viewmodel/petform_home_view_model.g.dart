// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petform_home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetformHomeViewViewModel on PetformHomeViewViewModelBase, Store {
  late final _$interstitialAdAtom = Atom(
      name: 'PetformHomeViewViewModelBase.interstitialAd', context: context);

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

  late final _$PetformHomeViewViewModelBaseActionController =
      ActionController(name: 'PetformHomeViewViewModelBase', context: context);

  @override
  void createInterstitialAd() {
    final _$actionInfo = _$PetformHomeViewViewModelBaseActionController
        .startAction(name: 'PetformHomeViewViewModelBase.createInterstitialAd');
    try {
      return super.createInterstitialAd();
    } finally {
      _$PetformHomeViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showInterstitialAd() {
    final _$actionInfo = _$PetformHomeViewViewModelBaseActionController
        .startAction(name: 'PetformHomeViewViewModelBase.showInterstitialAd');
    try {
      return super.showInterstitialAd();
    } finally {
      _$PetformHomeViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void callGroupChatView(String title, String assetName, String collectionId,
      String docId, String pageTitle, dynamic context) {
    final _$actionInfo = _$PetformHomeViewViewModelBaseActionController
        .startAction(name: 'PetformHomeViewViewModelBase.callGroupChatView');
    try {
      return super.callGroupChatView(
          title, assetName, collectionId, docId, pageTitle, context);
    } finally {
      _$PetformHomeViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
interstitialAd: ${interstitialAd}
    ''';
  }
}
