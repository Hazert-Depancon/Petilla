// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/core/base/view/status_view.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/enums/status_keys_enum.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/widgets/patily_help/patily_help_widget.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:patily/feature/patily_help/view/help_me_view.dart';
import 'package:patily/feature/patily_help/viewmodel/help_me_home_view_view_model.dart';

class HelpMeHomeView extends StatefulWidget {
  const HelpMeHomeView({super.key});

  @override
  State<HelpMeHomeView> createState() => _HelpMeHomeViewState();
}

class _HelpMeHomeViewState extends BaseState<HelpMeHomeView> {
  late HelpMeHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpMeHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: HelpMeHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
        endDrawer: _endDrawer(context),
        appBar: AppBar(
          title: Text(LocaleKeys.appNames_helpMe.locale),
          actions: [
            _helpMe(),
            context.emptySizedWidthBoxLow,
          ],
        ),
        body: _body(),
      );

  SafeArea _body() {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollectionEnum.animalHelp.reference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _listView(snapshot);
          }
          return const StatusView(status: StatusKeysEnum.LOADING);
        },
      ),
    );
  }

  ListView _listView(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        return _helpMeWidget(snapshot, index);
      },
    );
  }

  HelpMeWidget _helpMeWidget(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return _helpMeModel(snapshot, index);
  }

  HelpMeWidget _helpMeModel(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return HelpMeWidget(
      helpMeModel: HelpMeModel(
        title: snapshot.data!.docs[index][AppFirestoreFieldNames.title],
        description: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.descriptionField],
        long: snapshot.data!.docs[index][AppFirestoreFieldNames.long],
        lat: snapshot.data!.docs[index][AppFirestoreFieldNames.lat],
        isVetHelp: snapshot.data!.docs[index][AppFirestoreFieldNames.isVetHelp],
        isFoodHelp: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.isFoodHelp],
        imageDowlandUrl: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.imagePathField],
        currentUserEmail: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.currentEmailField],
        currentUserId: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.uidField],
        currentUserName: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.nameField],
        otherNeeds: snapshot.data!.docs[index]
            [AppFirestoreFieldNames.otherNeeds],
      ),
    );
  }

  Drawer _endDrawer(context) => Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12) +
                  const EdgeInsets.only(left: 16, right: 4),
              child: Row(
                children: [
                  _drawerTitle(context),
                ],
              ),
            ),
          ],
        ),
      );

  Text _drawerTitle(BuildContext context) {
    return Text(
      LocaleKeys.filter.locale,
      style: textTheme.titleLarge!.copyWith(
        color: LightThemeColors.miamiMarmalade,
        fontSize: 22,
      ),
    );
  }

  GestureDetector _helpMe() => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HelpMeView(),
            ),
          );
        },
        child: const Icon(AppIcons.addPhoto),
      );
}
