// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petilla_detail_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailViewViewModel on _DetailViewViewModelBase, Store {
  late final _$isFavAtom =
      Atom(name: '_DetailViewViewModelBase.isFav', context: context);

  @override
  bool? get isFav {
    _$isFavAtom.reportRead();
    return super.isFav;
  }

  @override
  set isFav(bool? value) {
    _$isFavAtom.reportWrite(value, super.isFav, () {
      super.isFav = value;
    });
  }

  late final _$favButtonAsyncAction =
      AsyncAction('_DetailViewViewModelBase.favButton', context: context);

  @override
  Future favButton(dynamic docId) {
    return _$favButtonAsyncAction.run(() => super.favButton(docId));
  }

  late final _$addFavAsyncAction =
      AsyncAction('_DetailViewViewModelBase.addFav', context: context);

  @override
  Future addFav(dynamic docId) {
    return _$addFavAsyncAction.run(() => super.addFav(docId));
  }

  late final _$removeFavAsyncAction =
      AsyncAction('_DetailViewViewModelBase.removeFav', context: context);

  @override
  Future removeFav(dynamic docId) {
    return _$removeFavAsyncAction.run(() => super.removeFav(docId));
  }

  late final _$changeFavAsyncAction =
      AsyncAction('_DetailViewViewModelBase.changeFav', context: context);

  @override
  Future changeFav(dynamic docId) {
    return _$changeFavAsyncAction.run(() => super.changeFav(docId));
  }

  late final _$_DetailViewViewModelBaseActionController =
      ActionController(name: '_DetailViewViewModelBase', context: context);

  @override
  void callChatPage(dynamic context, dynamic currentUserName,
      dynamic currentUserId, dynamic currentUserEmail) {
    final _$actionInfo = _$_DetailViewViewModelBaseActionController.startAction(
        name: '_DetailViewViewModelBase.callChatPage');
    try {
      return super.callChatPage(
          context, currentUserName, currentUserId, currentUserEmail);
    } finally {
      _$_DetailViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFav: ${isFav}
    ''';
  }
}
