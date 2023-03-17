// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'petform_home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetformHomeViewViewModel on PetformHomeViewViewModelBase, Store {
  late final _$streamAtom =
      Atom(name: 'PetformHomeViewViewModelBase.stream', context: context);

  @override
  CollectionReference<Map<String, dynamic>> get stream {
    _$streamAtom.reportRead();
    return super.stream;
  }

  @override
  set stream(CollectionReference<Map<String, dynamic>> value) {
    _$streamAtom.reportWrite(value, super.stream, () {
      super.stream = value;
    });
  }

  late final _$PetformHomeViewViewModelBaseActionController =
      ActionController(name: 'PetformHomeViewViewModelBase', context: context);

  @override
  void callAddQuestionView() {
    final _$actionInfo = _$PetformHomeViewViewModelBaseActionController
        .startAction(name: 'PetformHomeViewViewModelBase.callAddQuestionView');
    try {
      return super.callAddQuestionView();
    } finally {
      _$PetformHomeViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stream: ${stream}
    ''';
  }
}
