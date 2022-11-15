import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/utility/widget_utility/fav_button_service.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late bool _isClaim;
  late bool isMe;

  @override
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isClaim = true : _isClaim = false;
    widget.petModel.currentEmail == FirebaseAuth.instance.currentUser!.email ? isMe = true : isMe = false;
  }

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;
  var smallSizedBox = AppSizedBoxs.smallHeightSizedBox;
  bool? _isFav;

  favButton(docId) async {
    _isFav = await FavButtonService().favButton(docId);
  }

  addFav(docId) async {
    _isFav = await FavButtonService().addFav(docId);
  }

  removeFav(docId) async {
    _isFav = await FavButtonService().removeFav(docId);
  }

  changeFav(docId) async {
    setState(() {
      FavButtonService().changeFav(docId, _isFav);
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black);

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context, headline4),
      floatingActionButton: isMe ? null : _chatFabButton(),
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

  ListTile _locationListTile(BuildContext context) {
    return _litTile(context, _ThisPageTexts.location, "${widget.petModel.city} " " ${widget.petModel.ilce}");
  }

  ListTile _genderListTile(BuildContext context) => _litTile(context, _ThisPageTexts.gender, widget.petModel.gender);

  ListTile _breedListTile(BuildContext context) => _litTile(context, _ThisPageTexts.race, widget.petModel.petBreed);

  ListTile _typeListTile(BuildContext context) => _litTile(context, _ThisPageTexts.type, widget.petModel.petType);

  ListTile _ageListTile(BuildContext context) => _litTile(context, _ThisPageTexts.ageRange, widget.petModel.ageRange);

  Text _userNameText(BuildContext context) {
    return Text(
      widget.petModel.currentUserName,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  FloatingActionButton _chatFabButton() {
    return FloatingActionButton(
      onPressed: _callChatPage,
      child: const Icon(AppIcons.chatIcon),
    );
  }

  void _callChatPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          friendUserName: widget.petModel.currentUserName,
          currentUserEmail: FirebaseAuth.instance.currentUser!.email!,
          currentUserId: FirebaseAuth.instance.currentUser!.uid,
          friendUserId: widget.petModel.currentUid,
          friendUserEmail: widget.petModel.currentEmail,
          currentUserName: FirebaseAuth.instance.currentUser!.displayName!,
        ),
      ),
    );
  }

  ListTile _litTile(BuildContext context, title, trailing) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: Theme.of(context).textTheme.headline6),
      trailing: Text(trailing, style: Theme.of(context).textTheme.headline6),
    );
  }

  Text _descriptionText(BuildContext context) {
    return Text(widget.petModel.description, style: Theme.of(context).textTheme.subtitle1);
  }

  Text _priceText(TextStyle? headline4) {
    return Text(
      _isClaim ? _ThisPageTexts.claim : "${widget.petModel.price}TL",
      style: _isClaim
          ? headline4?.copyWith(color: LightThemeColors.miamiMarmalade, fontSize: 24)
          : headline4?.copyWith(fontSize: 24),
    );
  }

  Text _nameText(TextStyle? headline4) => Text(
        widget.petModel.name,
        style: headline4?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      );

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
        child: _favButton(),
      ),
    );
  }

  FutureBuilder<Object?> _favButton() {
    return FutureBuilder(
      future: favButton(widget.petModel.docId),
      builder: (context, snapshot) {
        return Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              changeFav(widget.petModel.docId);
            },
            icon: _isFav ?? false
                ? const Icon(AppIcons.favoriteIcon, color: Colors.red, size: 30)
                : const Icon(AppIcons.favoriteBorderIcon, size: 30),
          ),
        );
      },
    );
  }
}

class _ThisPageTexts {
  static String claim = Localization.claim;
  static String ageRange = Localization.ageRange;
  static String gender = Localization.gender;
  static String type = Localization.type;
  static String race = Localization.race;
  static String location = Localization.location;
}
