import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/petilla_main_chats/in_chat_view.dart';
import 'package:petilla_app_project/general/general_widgets/fav_button.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late bool _isSahiplen;
  late bool isMe;

  @override
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isSahiplen = true : _isSahiplen = false;
    widget.petModel.currentEmail == FirebaseAuth.instance.currentUser!.email ? isMe = true : isMe = false;
  }

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: ListView(
        padding: ProjectPaddings.horizontalMainPadding,
        children: [
          _emailText(context),
          const SizedBox(height: 16),
          _imageContainer(),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _nameText(headline4),
                _priceText(headline4),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _descriptionText(context),
          const SizedBox(height: 16),
          _litTile(context, "Yaş:", widget.petModel.ageRange),
          _litTile(context, "Tür:", widget.petModel.petType),
          // _litTile(context, "Cins:", widget.petBreed),
          _litTile(context, "Cinsiyet:", widget.petModel.sex),
          _litTile(context, "Konum:", "${widget.petModel.city} " " ${widget.petModel.ilce}"),
          const SizedBox(height: 120),
        ],
      ),
      floatingActionButton: isMe ? null : _chatFabButton(),
    );
  }

  Text _emailText(BuildContext context) {
    return Text(
      widget.petModel.currentEmail,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  FloatingActionButton _chatFabButton() {
    return FloatingActionButton(
      onPressed: _callChatPage,
      child: const Icon(Icons.chat),
    );
  }

  void _callChatPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InChatView(
          currentUserEmail: FirebaseAuth.instance.currentUser!.email.toString(),
          currentUserId: FirebaseAuth.instance.currentUser!.uid,
          friendUserId: widget.petModel.currentUid,
          friendUserEmail: widget.petModel.currentEmail,
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

  Text _descriptionText(BuildContext context) =>
      Text(widget.petModel.description, style: Theme.of(context).textTheme.subtitle1);

  Text _priceText(TextStyle? headline4) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${widget.petModel.price}TL",
      style: _isSahiplen
          ? headline4?.copyWith(color: LightThemeColors.miamiMarmalade, fontSize: 24)
          : headline4?.copyWith(fontSize: 24),
    );
  }

  Text _nameText(TextStyle? headline4) => Text(
        widget.petModel.name,
        style: headline4?.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
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

  FavButton _favButton() {
    return const FavButton(iconSize: 32);
  }
}
