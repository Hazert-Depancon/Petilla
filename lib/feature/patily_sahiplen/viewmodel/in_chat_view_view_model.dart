// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/patily_sahiplen/service/chat_service/chat_service.dart';

part 'in_chat_view_view_model.g.dart';

class InChatViewViewModel = _InChatViewViewModelBase with _$InChatViewViewModel;

abstract class _InChatViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void onSendButton(
    controller,
    currentUserId,
    friendUserId,
    friendUserEmail,
    currentUserEmail,
    friendUserName,
    currentUserName,
  ) {
    String message = controller.text;
    ChatService().sendMessage(
      message,
      controller,
      currentUserId,
      friendUserId,
      friendUserEmail,
      currentUserEmail,
      friendUserName,
      currentUserName,
    );
  }
}
