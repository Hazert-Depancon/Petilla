import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/chat_service/chat_service.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/general/general_widgets/single_message.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class InChatView extends StatefulWidget {
  const InChatView({
    Key? key,
    required this.currentUserId,
    required this.currentUserEmail,
    required this.friendUserId,
    required this.friendUserEmail,
  }) : super(key: key);

  final String currentUserId;
  final String currentUserEmail;
  final String friendUserId;
  final String friendUserEmail;

  @override
  State<InChatView> createState() => _InChatViewState();
}

class _InChatViewState extends State<InChatView> {
  final TextEditingController controller = TextEditingController();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> firebaseStream;
  final String usersRef = AppFirestoreCollectionNames.usersCollection;
  final String messagesRef = AppFirestoreCollectionNames.messages;
  final String chatsRef = AppFirestoreCollectionNames.chatsCollection;

  @override
  void initState() {
    super.initState();
    firebaseStream = FirebaseFirestore.instance
        .collection(usersRef)
        .doc(widget.currentUserId)
        .collection(messagesRef)
        .doc(widget.friendUserId)
        .collection(chatsRef)
        .orderBy(AppFirestoreFieldNames.dateField, descending: true)
        .snapshots();
  }

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
        title: Text(widget.friendUserEmail),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomStreamBuilder(firebaseStream: firebaseStream, widget: widget),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(child: _textField(widget.currentUserId, widget.friendUserId, controller)),
              ],
            ),
          ),
          mainSizedBox,
        ],
      ),
    );
  }

  TextField _textField(String currentUserId, String friendUserId, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Bir mesaj yaz...',
        suffixIcon: _sendButton(controller),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }

  _sendButton(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 45,
        width: 45,
        child: CircleAvatar(
          backgroundColor: LightThemeColors.miamiMarmalade,
          foregroundColor: LightThemeColors.white,
          child: IconButton(
            onPressed: () async {
              String message = controller.text;
              ChatService().sendMessage(
                message,
                controller,
                widget.currentUserId,
                widget.friendUserId,
                widget.friendUserEmail,
                widget.currentUserEmail,
              );
            },
            icon: const Icon(AppIcons.sendIcon),
          ),
        ),
      ),
    );
  }
}

class CustomStreamBuilder extends StatelessWidget {
  const CustomStreamBuilder({
    Key? key,
    required this.firebaseStream,
    required this.widget,
  }) : super(key: key);

  final Stream<QuerySnapshot<Map<String, dynamic>>> firebaseStream;
  final InChatView widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.isEmpty) {
            return Center(
              child: Text("say_hi".tr()),
            );
          }
          return Expanded(
            child: MyListView(widget: widget, snapshot: snapshot),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyListView extends StatelessWidget {
  const MyListView({
    Key? key,
    required this.widget,
    required this.snapshot,
  }) : super(key: key);

  final InChatView widget;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        bool isMe = snapshot.data.docs[index]["senderId"] == widget.currentUserId;
        return SingleMessage(
          message: snapshot.data.docs[index]["message"],
          isMe: isMe,
        );
      },
    );
  }
}
