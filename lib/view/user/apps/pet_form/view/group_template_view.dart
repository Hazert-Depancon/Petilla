import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/components/single_message.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/pet_form/viewmodel/group_template_view_model.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class GroupChat extends StatefulWidget {
  const GroupChat({
    Key? key,
    required this.pageTitle,
    required this.docId,
    required this.collectionId,
  }) : super(key: key);

  final String pageTitle;
  final String docId;
  final String collectionId;

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends BaseState<GroupChat> {
  TextEditingController msg = TextEditingController();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  late GroupTemplateViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<GroupTemplateViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        loginUser = viewModel.getCurrentUser();
      },
      viewModel: GroupTemplateViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body,
      );

  AppBar get _appBar {
    return AppBar(
      title: Text(widget.pageTitle),
      foregroundColor: LightThemeColors.miamiMarmalade,
      leading: _backIcon,
    );
  }

  Column get _body {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ShowMessages(
            collectionId: widget.collectionId,
            docId: widget.docId,
          ),
        ),
        Padding(
          padding: ProjectPaddings.horizontalMainPadding,
          child: Row(
            children: [
              Expanded(child: _textField(msg)),
            ],
          ),
        ),
        mainSizedBox
      ],
    );
  }

  GestureDetector get _backIcon {
    return GestureDetector(
      child: const Icon(AppIcons.arrowBackIcon),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  TextField _textField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: LocaleKeys.writeAMessage.locale,
        suffixIcon: _sendButton(controller),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(36),
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
              GroupTemplateViewModel().onSendButton(msg, widget.docId, widget.collectionId);
            },
            icon: const Icon(AppIcons.sendIcon),
          ),
        ),
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {
  const ShowMessages({Key? key, required this.docId, required this.collectionId}) : super(key: key);
  final String docId;
  final String collectionId;

  @override
  Widget build(BuildContext context) {
    return _streamBuilder();
  }

  StreamBuilder<QuerySnapshot<Object?>> _streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(AppFirestoreCollectionNames.messages)
          .doc(docId)
          .collection(collectionId)
          .orderBy(AppFirestoreFieldNames.timeField)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listView(snapshot);
        }
        if (snapshot.hasError) {
          return _errorWidget;
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return _connectionErrorWidget;
        }
        return _loadingWidget;
      },
    );
  }

  StatusView get _errorWidget => const StatusView(status: StatusKeysEnum.ERROR);

  StatusView get _connectionErrorWidget => const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);

  StatusView get _loadingWidget => const StatusView(status: StatusKeysEnum.LOADING);

  ListView _listView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        QueryDocumentSnapshot querySnapshot = snapshot.data!.docs[index];
        return Column(
          crossAxisAlignment: loginUser!.displayName == querySnapshot[AppFirestoreFieldNames.userField]
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                querySnapshot[AppFirestoreFieldNames.userField],
              ),
            ),
            _singleMessage(querySnapshot),
          ],
        );
      },
    );
  }

  SingleMessage _singleMessage(QueryDocumentSnapshot<Object?> querySnapshot) {
    return SingleMessage(
      message: querySnapshot[AppFirestoreFieldNames.msgField],
      isMe: querySnapshot[AppFirestoreFieldNames.userField] == loginUser!.displayName.toString(),
    );
  }
}
