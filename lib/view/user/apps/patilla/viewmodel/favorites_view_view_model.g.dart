// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesViewViewModel on _FavoritesViewViewModelBase, Store {
  late final _$listLenghtAtom =
      Atom(name: '_FavoritesViewViewModelBase.listLenght', context: context);

  @override
  int? get listLenght {
    _$listLenghtAtom.reportRead();
    return super.listLenght;
  }

  @override
  set listLenght(int? value) {
    _$listLenghtAtom.reportWrite(value, super.listLenght, () {
      super.listLenght = value;
    });
  }

  late final _$myListAtom =
      Atom(name: '_FavoritesViewViewModelBase.myList', context: context);

  @override
  List<dynamic>? get myList {
    _$myListAtom.reportRead();
    return super.myList;
  }

  @override
  set myList(List<dynamic>? value) {
    _$myListAtom.reportWrite(value, super.myList, () {
      super.myList = value;
    });
  }

  late final _$listAtom =
      Atom(name: '_FavoritesViewViewModelBase.list', context: context);

  @override
  List<String> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(List<String> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  late final _$getSharedAsyncAction =
      AsyncAction('_FavoritesViewViewModelBase.getShared', context: context);

  @override
  Future<void> getShared() {
    return _$getSharedAsyncAction.run(() => super.getShared());
  }

  @override
  String toString() {
    return '''
listLenght: ${listLenght},
myList: ${myList},
list: ${list}
    ''';
  }
}
