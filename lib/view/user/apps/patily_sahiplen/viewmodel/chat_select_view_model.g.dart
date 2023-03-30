// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_select_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatSelectViewModel on _ChatSelectViewModelBase, Store {
  late final _$_ChatSelectViewModelBaseActionController =
      ActionController(name: '_ChatSelectViewModelBase', context: context);

  @override
  void callInChat(
      String friendEmail,
      String friendUid,
      String currentEmail,
      String currentUid,
      String friendUserName,
      String currentUserName,
      dynamic context) {
    final _$actionInfo = _$_ChatSelectViewModelBaseActionController.startAction(
        name: '_ChatSelectViewModelBase.callInChat');
    try {
      return super.callInChat(friendEmail, friendUid, currentEmail, currentUid,
          friendUserName, currentUserName, context);
    } finally {
      _$_ChatSelectViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void callChat(dynamic snapshot, dynamic index, dynamic context) {
    final _$actionInfo = _$_ChatSelectViewModelBaseActionController.startAction(
        name: '_ChatSelectViewModelBase.callChat');
    try {
      return super.callChat(snapshot, index, context);
    } finally {
      _$_ChatSelectViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
