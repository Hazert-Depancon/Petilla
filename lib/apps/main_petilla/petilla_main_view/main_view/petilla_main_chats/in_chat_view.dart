import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/chat_service/chat_service.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/extension/string_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/general/general_widgets/single_message.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

class InChatView extends StatefulWidget {
  const InChatView({
    Key? key,
    required this.currentUserId,
    required this.currentUserEmail,
    required this.friendUserId,
    required this.friendUserEmail,
    required this.friendUserName,
    required this.currentUserName,
  }) : super(key: key);

  final String currentUserId;
  final String currentUserEmail;
  final String currentUserName;
  final String friendUserId;
  final String friendUserEmail;
  final String friendUserName;

  @override
  State<InChatView> createState() => _InChatViewState();
}

class _InChatViewState extends BaseState<InChatView> {
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
      appBar: _appBar(),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomStreamBuilder(firebaseStream: firebaseStream, widget: widget),
        Padding(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Row(
            children: [
              Expanded(child: _textField(widget.currentUserId, widget.friendUserId, controller)),
            ],
          ),
        ),
        mainSizedBox,
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      foregroundColor: LightThemeColors.miamiMarmalade,
      title: Text(widget.friendUserName),
    );
  }

  TextField _textField(String currentUserId, String friendUserId, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: _ThisPageTexts.writeAMessage,
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
            onPressed: _onSendButton,
            icon: const Icon(AppIcons.sendIcon),
          ),
        ),
      ),
    );
  }

  _onSendButton() {
    String message = controller.text;
    ChatService().sendMessage(
      message,
      controller,
      widget.currentUserId,
      widget.friendUserId,
      widget.friendUserEmail,
      widget.currentUserEmail,
      widget.friendUserName,
      widget.currentUserName,
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

  _loadingView() => const StatusView(status: StatusKeysEnum.EMPTY);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.isEmpty) {
            return Text(_ThisPageTexts.sayHi);
          }
          return Expanded(
            child: MyListView(widget: widget, snapshot: snapshot),
          );
        }
        return _loadingView();
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
        bool isMe = snapshot.data.docs[index][AppFirestoreFieldNames.senderIdField] == widget.currentUserId;
        return SingleMessage(
          message: snapshot.data.docs[index][AppFirestoreFieldNames.messagesField],
          isMe: isMe,
        );
      },
    );
  }
}

class _ThisPageTexts {
  static String writeAMessage = LocaleKeys.writeAMessage.locale;
  static String sayHi = LocaleKeys.sayHi.locale;
}
