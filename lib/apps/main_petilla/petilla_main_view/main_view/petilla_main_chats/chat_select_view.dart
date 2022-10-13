import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/petilla_main_widgets/chat_widgets/user_chat.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';

class ChatSelectView extends StatelessWidget {
  const ChatSelectView({Key? key}) : super(key: key);
  void _callInChat(String friendEmail, String friendUid, String currentEmail, String currentUid, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          currentUserId: currentUid,
          currentUserEmail: currentEmail,
          friendUserId: friendUid,
          friendUserEmail: friendEmail,
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
          } else if (snapshot.data!.docs.isNotEmpty) {
            return _customListView(snapshot);
          }
        }
        if (snapshot.hasError) {
          return _errorWidget();
        }
        return _loadingWidget();
      },
    );
  }

  Center _loadingWidget() => Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));

  Center _errorWidget() => Center(child: Lottie.network(ProjectLottieUrls.errorLottie));

  ListView _customListView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return UserChat(
          name: snapshot.data!.docs[index][AppFirestoreFieldNames.emailField],
          onTap: () {
            _callChat(snapshot, index, context);
          },
        );
      },
    );
  }

  void _callChat(snapshot, index, context) {
    return _callInChat(
      snapshot.data!.docs[index][AppFirestoreFieldNames.emailField],
      snapshot.data!.docs[index][AppFirestoreFieldNames.uidField],
      FirebaseAuth.instance.currentUser!.email.toString(),
      FirebaseAuth.instance.currentUser!.uid,
      context,
    );
  }

  Center _notMessagesYetWidget() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120),
          Text(_ThisPageTexts.noMessagesYet, style: const TextStyle(fontSize: 20)),
          Center(child: Lottie.network(ProjectLottieUrls.emptyLottie)),
        ],
      ),
    );
  }
}

class _ThisPageTexts {
  static String myMessages = Localization.myMessages;
  static String noMessagesYet = Localization.noMessagesYet;
}
