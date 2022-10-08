import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/petilla_main_widgets/chat_widgets/user_chat.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';

class ChatSelectView extends StatefulWidget {
  const ChatSelectView({Key? key}) : super(key: key);

  @override
  State<ChatSelectView> createState() => _ChatSelectViewState();
}

class _ChatSelectViewState extends State<ChatSelectView> {
  void callInChat(String friendEmail, String friendUid, String currentEmail, String currentUid) {
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
      appBar: AppBar(
        title: Text("messages".tr()),
        automaticallyImplyLeading: false,
      ),
      body: _customstreamBuilder(),
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
          name: snapshot.data!.docs[index]["email"],
          onTap: () {
            _callChat(snapshot, index);
          },
        );
      },
    );
  }

  void _callChat(snapshot, index) {
    return callInChat(
      snapshot.data!.docs[index]["email"],
      snapshot.data!.docs[index]["uid"],
      FirebaseAuth.instance.currentUser!.email.toString(),
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  Center _notMessagesYetWidget() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 120),
          Text("no_messages_yet".tr(), style: const TextStyle(fontSize: 20)),
          Center(child: Lottie.network(ProjectLottieUrls.emptyLottie)),
        ],
      ),
    );
  }
}
