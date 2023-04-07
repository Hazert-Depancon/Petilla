// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/product/widgets/patily_media/photo_widget.dart';
import 'package:patily/product/models/patily_media/post_model.dart';
import 'package:patily/feature/patily_media/viewmodel/petcook_home_view_view_model.dart';

class PetcookHomeView extends StatelessWidget {
  PetcookHomeView({super.key});

  late PetcookHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<PetcookHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: PetcookHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _body(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.homePage.locale,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        _addPostButton(),
        context.emptySizedWidthBoxLow3x,
      ],
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollectionEnum.petcook.reference
            .orderBy(AppFirestoreFieldNames.dateField, descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const StatusView(status: StatusKeysEnum.EMPTY);
            }
            return _listview(snapshot);
          }
          return const StatusView(status: StatusKeysEnum.LOADING);
        },
      ),
    );
  }

  ListView _listview(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _photoWidget(snapshot, index);
      },
    );
  }

  PhotoWidget _photoWidget(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return PhotoWidget(
      postModel: PostModel(
        senderUserEmail: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.currentEmailField],
        senderUserName: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.currentNameField],
        senderUserId: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.senderIdField],
        postDowlandUrl: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.imagePathField],
        description: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.descriptionField],
      ),
    );
  }

  GestureDetector _addPostButton() {
    return GestureDetector(
      onTap: () {
        viewModel.callAddPhotoView();
      },
      child: SvgPicture.asset(
        Assets.svg.plus,
        height: 24,
      ),
    );
  }
}
