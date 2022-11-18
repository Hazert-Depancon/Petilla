import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/core/components/chat_widgets/user_chat.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/extension/string_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';

class ChatSelectView extends StatelessWidget {
  const ChatSelectView({Key? key}) : super(key: key);

  void _callInChat(
    String friendEmail,
    String friendUid,
    String currentEmail,
    String currentUid,
    String friendUserName,
    String currentUserName,
    context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          friendUserName: friendUserName,
          currentUserId: currentUid,
          currentUserEmail: currentEmail,
          friendUserId: friendUid,
          friendUserEmail: friendEmail,
          currentUserName: currentUserName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _customstreamBuilder(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.myMessages),
      automaticallyImplyLeading: false,
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _customstreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppFirestoreCollectionNames.messages)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return _notMessagesYetWidget();
          }
          if (snapshot.data!.docs.isNotEmpty) {
            return _customListView(snapshot);
          }
        }
        if (snapshot.hasError) {
          return _errorWidget();
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return _connectionError();
        }
        return _loadingWidget();
      },
    );
  }

  _loadingWidget() => const StatusView(status: StatusKeysEnum.LOADING);

  _connectionError() => const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  _notMessagesYetWidget() => const StatusView(status: StatusKeysEnum.EMPTY);

  _errorWidget() => const StatusView(status: StatusKeysEnum.ERROR);

  ListView _customListView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _userChatWidget(snapshot, index, context);
      },
    );
  }

  UserChat _userChatWidget(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index, BuildContext context) {
    return UserChat(
      name: snapshot.data!.docs[index][AppFirestoreFieldNames.nameField],
      lastMsg: snapshot.data!.docs[index][AppFirestoreFieldNames.lastMsgField],
      onTap: () {
        _callChat(snapshot, index, context);
      },
    );
  }

  void _callChat(snapshot, index, context) {
    return _callInChat(
      snapshot.data!.docs[index][AppFirestoreFieldNames.emailField],
      snapshot.data!.docs[index][AppFirestoreFieldNames.uidField],
      FirebaseAuth.instance.currentUser!.email.toString(),
      FirebaseAuth.instance.currentUser!.uid,
      snapshot.data!.docs[index][AppFirestoreFieldNames.nameField],
      FirebaseAuth.instance.currentUser!.displayName!,
      context,
    );
  }
}

class _ThisPageTexts {
  static String myMessages = LocaleKeys.myMessages.locale;
}
