// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/product/widgets/buttons/button.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:patily/feature/patily_help/viewmodel/help_me_detail_view_view_model.dart';

class HelpMeDetailView extends StatelessWidget {
  HelpMeDetailView({super.key, required this.helpMeModel});
  final HelpMeModel helpMeModel;

  late HelpMeDetailViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpMeDetailViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: HelpMeDetailViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(context),
        bottomNavigationBar: _locationAndChatButtons(context),
      );

  Padding _locationAndChatButtons(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: Row(
        children: [
          _showInMapButton(),
          helpMeModel.currentUserId == FirebaseAuth.instance.currentUser!.uid
              ? const SizedBox.shrink()
              : _chatButton(context),
        ],
      ),
    );
  }

  Padding _chatButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: FloatingActionButton(
        child: SvgPicture.asset(Assets.svg.chat),
        onPressed: () {
          viewModel.callChatPage(
            context,
            helpMeModel.currentUserName,
            helpMeModel.currentUserId,
            helpMeModel.currentUserId,
          );
        },
      ),
    );
  }

  Expanded _showInMapButton() {
    return Expanded(
      child: Button(
        text: LocaleKeys.location.locale,
        onPressed: () async {
          viewModel.showInMap(helpMeModel);
        },
      ),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageContainer(context),
            context.emptySizedHeightBoxLow,
            _titleText(context),
            context.emptySizedHeightBoxLow,
            _descriptionText(context),
            context.emptySizedHeightBoxLow,
            helpMeModel.isFoodHelp ? _footdHelpText(context) : _emptySizedBox(),
            helpMeModel.isFoodHelp
                ? context.emptySizedHeightBoxLow
                : _emptySizedBox(),
            helpMeModel.isVetHelp ? _vetHelpText(context) : _emptySizedBox(),
            _otherNeeds(context),
          ],
        ),
      ),
    );
  }

  Text _otherNeeds(context) {
    return Text(
      helpMeModel.otherNeeds,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  SizedBox _emptySizedBox() => const SizedBox.shrink();

  Text _vetHelpText(context) => Text(LocaleKeys.vetHelp.locale,
      style: Theme.of(context).textTheme.titleSmall);

  Text _footdHelpText(context) => Text(LocaleKeys.foodHelp.locale,
      style: Theme.of(context).textTheme.titleSmall);

  Text _descriptionText(context) => Text(helpMeModel.description,
      style: Theme.of(context).textTheme.titleLarge);

  Text _titleText(context) => Text(helpMeModel.title,
      style: Theme.of(context).textTheme.headlineMedium);

  Container _imageContainer(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: context.normalBorderRadius,
        image: DecorationImage(
          image: NetworkImage(
            helpMeModel.imageDowlandUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar();
}
