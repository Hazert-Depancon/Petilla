// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patily_form_home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatilyFormHomeViewViewModel on PatilyFormHomeViewViewModelBase, Store {
  late final _$streamAtom =
      Atom(name: 'PatilyFormHomeViewViewModelBase.stream', context: context);

  @override
  CollectionReference<Object?> get stream {
    _$streamAtom.reportRead();
    return super.stream;
  }

  @override
  set stream(CollectionReference<Object?> value) {
    _$streamAtom.reportWrite(value, super.stream, () {
      super.stream = value;
    });
  }

  late final _$PatilyFormHomeViewViewModelBaseActionController =
      ActionController(
          name: 'PatilyFormHomeViewViewModelBase', context: context);

  @override
  void callAddQuestionView() {
    final _$actionInfo =
        _$PatilyFormHomeViewViewModelBaseActionController.startAction(
            name: 'PatilyFormHomeViewViewModelBase.callAddQuestionView');
    try {
      return super.callAddQuestionView();
    } finally {
      _$PatilyFormHomeViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stream: ${stream}
    ''';
  }
}
