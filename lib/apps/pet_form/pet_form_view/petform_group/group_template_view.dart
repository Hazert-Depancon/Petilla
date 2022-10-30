import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/pet_form/pet_form_view/petform_group/group_template_view_model.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/single_message.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class GroupChat extends StatefulWidget {
  const GroupChat({Key? key, required this.pageTitle, required this.docId, required this.collectionId})
      : super(key: key);

  final String pageTitle;
  final String docId;
  final String collectionId;

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final auth = FirebaseAuth.instance;
  TextEditingController msg = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginUser = GroupTemplateViewModel().getCurrentUser();
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

  AppBar _appBar() {
    return AppBar(
      title: Text(widget.pageTitle),
      foregroundColor: LightThemeColors.miamiMarmalade,
      leading: GestureDetector(
        child: const Icon(AppIcons.arrowBackIcon),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  TextField _textField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: Localization.writeAMessage,
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
        return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
      },
    );
  }

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
