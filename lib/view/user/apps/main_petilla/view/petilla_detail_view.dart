import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/view/other_profile_view.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/viewmodel/petilla_detail_view_view_model.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends BaseState<DetailView> {
  late bool _isClaim;
  late bool _isMe;

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  var smallSizedBox = AppSizedBoxs.smallHeightSizedBox;

  late DetailViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final headline4 = textTheme.headline4?.copyWith(color: LightThemeColors.black);

    return BaseView<DetailViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        widget.petModel.price == "0" ? _isClaim = true : _isClaim = false;
        widget.petModel.currentEmail == FirebaseAuth.instance.currentUser!.email ? _isMe = true : _isMe = false;
      },
      viewModel: DetailViewViewModel(),
      onPageBuilder: (context, value) => buildScaffold(headline4),
    );
  }

  Scaffold buildScaffold(headline4) => Scaffold(
        appBar: _appBar(context),
        body: _body(context, headline4),
        floatingActionButton: _isMe ? null : _chatFabButton(),
      );

  AppBar _appBar(context) {
    return AppBar(
      foregroundColor: LightThemeColors.miamiMarmalade,
      leading: _backIcon(context),
    );
  }

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(AppIcons.arrowBackIcon),
    );
  }

  SingleChildScrollView _body(BuildContext context, TextStyle? headline4) {
    return SingleChildScrollView(
      padding: ProjectPaddings.horizontalMainPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userNameText(context),
          smallSizedBox,
          _imageContainer(),
          smallSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _nameText(headline4),
              _priceText(headline4),
            ],
          ),
          mainSizedBox,
          _descriptionText(context),
          const SizedBox(height: 16),
          _ageListTile(context),
          _typeListTile(context),
          _genderListTile(context),
          _breedListTile(context),
          _locationListTile(context),
        ],
      ),
    );
  }

  GestureDetector _userNameText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtherProfileView(petModel: widget.petModel),
          ),
        );
      },
      child: Text(
        widget.petModel.currentUserName,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Container _imageContainer() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: ProjectRadius.mainAllRadius,
        color: LightThemeColors.miamiMarmalade,
        image: DecorationImage(
          image: NetworkImage(widget.petModel.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: _isMe ? null : _favButton(),
      ),
    );
  }

  Observer _favButton() {
    return Observer(builder: (_) {
      return FutureBuilder<Object?>(
        future: viewModel.favButton(widget.petModel.docId),
        builder: (context, snapshot) {
          return Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  viewModel.changeFav(widget.petModel.docId);
                });
              },
              icon: viewModel.isFav ?? false
                  ? const Icon(AppIcons.favoriteIcon, color: LightThemeColors.red, size: 30)
                  : const Icon(AppIcons.favoriteBorderIcon, size: 30),
            ),
          );
        },
      );
    });
  }

  Text _nameText(TextStyle? headline4) => Text(
        widget.petModel.name,
        style: headline4?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      );

  Text _priceText(TextStyle? headline4) {
    return Text(
      _isClaim ? _ThisPageTexts.claim : "${widget.petModel.price}TL",
      style: _isClaim
          ? headline4?.copyWith(color: LightThemeColors.miamiMarmalade, fontSize: 24, fontWeight: FontWeight.bold)
          : headline4?.copyWith(fontSize: 24),
    );
  }

  ListTile _listTile(BuildContext context, title, trailing) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      trailing: Text(trailing, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
    );
  }

  ListTile _ageListTile(BuildContext context) => _listTile(context, _ThisPageTexts.ageRange, widget.petModel.ageRange);

  ListTile _genderListTile(BuildContext context) => _listTile(context, _ThisPageTexts.gender, widget.petModel.gender);

  ListTile _typeListTile(BuildContext context) => _listTile(context, _ThisPageTexts.type, widget.petModel.petType);

  ListTile _breedListTile(BuildContext context) => _listTile(context, _ThisPageTexts.race, widget.petModel.petBreed);

  ListTile _locationListTile(BuildContext context) =>
      _listTile(context, _ThisPageTexts.location, "${widget.petModel.city} " " ${widget.petModel.ilce}");

  Text _descriptionText(BuildContext context) {
    return Text(widget.petModel.description, style: const TextStyle(fontSize: 16));
  }

  FloatingActionButton _chatFabButton() {
    return FloatingActionButton(
      onPressed: () {
        viewModel.callChatPage(
          context,
          widget.petModel.currentUserName,
          widget.petModel.currentUid,
          widget.petModel.currentEmail,
        );
      },
      child: const Icon(AppIcons.chatIcon),
    );
  }
}

class _ThisPageTexts {
  static String claim = LocaleKeys.claim.locale;
  static String ageRange = LocaleKeys.petAgeRange.locale;
  static String gender = LocaleKeys.gender.locale;
  static String type = LocaleKeys.petType.locale;
  static String race = LocaleKeys.petRace.locale;
  static String location = LocaleKeys.location.locale;
}
