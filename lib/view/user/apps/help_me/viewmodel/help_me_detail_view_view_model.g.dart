// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_me_detail_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HelpMeDetailViewViewModel on _HelpMeDetailViewViewModelBase, Store {
  late final _$showInMapAsyncAction =
      AsyncAction('_HelpMeDetailViewViewModelBase.showInMap', context: context);

  @override
  Future<void> showInMap(HelpMeModel helpMeModel) {
    return _$showInMapAsyncAction.run(() => super.showInMap(helpMeModel));
  }

  late final _$_HelpMeDetailViewViewModelBaseActionController =
      ActionController(
          name: '_HelpMeDetailViewViewModelBase', context: context);

  @override
  void callChatPage(dynamic context, dynamic currentUserName,
      dynamic currentUserId, dynamic currentUserEmail) {
    final _$actionInfo = _$_HelpMeDetailViewViewModelBaseActionController
        .startAction(name: '_HelpMeDetailViewViewModelBase.callChatPage');
    try {
      return super.callChatPage(
          context, currentUserName, currentUserId, currentUserEmail);
    } finally {
      _$_HelpMeDetailViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
