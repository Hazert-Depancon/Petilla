// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/widgets/patily_sahiplen/user_chat.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/chat_select_view_model.dart';

class ChatSelectView extends StatelessWidget {
  ChatSelectView({Key? key}) : super(key: key);

  late ChatSelectViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatSelectViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: ChatSelectViewModel(),
      onPageBuilder: (context, value) => buildScaffold,
    );
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body(),
      );

  AppBar get _appBar {
    return AppBar(
      title: Text(_ThisPageTexts.myMessages),
      automaticallyImplyLeading: false,
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollectionEnum.users.reference
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(FirebaseCollectionEnum.messages.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return _notMessagesYetWidget;
            }
            if (snapshot.data!.docs.isNotEmpty) {
              return _customListView(snapshot);
            }
          }
          if (snapshot.hasError) {
            return _errorWidget;
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return _connectionError;
          }
          return _loadingWidget;
        },
      ),
    );
  }

  StatusView get _loadingWidget =>
      const StatusView(status: StatusKeysEnum.LOADING);

  StatusView get _connectionError =>
      const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  StatusView get _notMessagesYetWidget =>
      const StatusView(status: StatusKeysEnum.EMPTY);

  StatusView get _errorWidget => const StatusView(status: StatusKeysEnum.ERROR);

  ListView _customListView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _userChatWidget(snapshot, index, context);
      },
    );
  }

  UserChat _userChatWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index, BuildContext context) {
    return UserChat(
      name: snapshot.data!.docs[index][AppFirestoreFieldNames.nameField],
      lastMsg: snapshot.data!.docs[index][AppFirestoreFieldNames.lastMsgField],
      onTap: () {
        viewModel.callChat(snapshot, index, context);
      },
    );
  }
}

class _ThisPageTexts {
  static String myMessages = LocaleKeys.patilySahiplenPages_myMessages.locale;
}
