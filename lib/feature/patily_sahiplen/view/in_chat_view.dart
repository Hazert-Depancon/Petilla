import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/widgets/single_message.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/in_chat_view_view_model.dart';

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

  late InChatViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<InChatViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        firebaseStream = FirebaseCollectionEnum.users.reference
            .doc(widget.currentUserId)
            .collection(FirebaseCollectionEnum.messages.toString())
            .doc(widget.friendUserId)
            .collection(FirebaseCollectionEnum.chats.toString())
            .orderBy(AppFirestoreFieldNames.dateField, descending: true)
            .snapshots();
      },
      viewModel: InChatViewViewModel(),
      onPageBuilder: (context, value) => buildScaffold,
    );
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body,
      );

  SafeArea get _body {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomStreamBuilder(firebaseStream: firebaseStream, widget: widget),
          Padding(
            padding: context.horizontalPaddingNormal,
            child: Row(
              children: [
                Expanded(
                  child: _textField(
                    widget.currentUserId,
                    widget.friendUserId,
                    controller,
                  ),
                ),
              ],
            ),
          ),
          context.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  AppBar get _appBar => AppBar(
        title: Text(widget.friendUserName),
      );

  TextField _textField(String currentUserId, String friendUserId,
      TextEditingController controller) {
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
            onPressed: () {
              viewModel.onSendButton(
                controller,
                widget.currentUserId,
                widget.friendUserId,
                widget.friendUserEmail,
                widget.currentUserEmail,
                widget.friendUserName,
                widget.currentUserName,
              );
            },
            icon: SvgPicture.asset(
              Assets.svg.send,
              color: LightThemeColors.white,
            ),
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
        bool isMe = snapshot.data.docs[index]
                [AppFirestoreFieldNames.senderIdField] ==
            widget.currentUserId;
        return SingleMessage(
          message: snapshot.data.docs[index]
              [AppFirestoreFieldNames.messagesField],
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
