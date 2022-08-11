import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/main_petilla/view/main_view/chats/in_chat_view.dart';
import 'package:petilla_app_project/main_petilla/view/widgets/fav_button.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class DetailView extends StatefulWidget {
  const DetailView({
    Key? key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ageRange,
    required this.city,
    required this.petBreed,
    required this.petType,
    required this.price,
    required this.sex,
    required this.ilce,
    required this.friendUId,
    required this.friendEmail,
  }) : super(key: key);

  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String city;
  final String ilce;
  final String petBreed;
  final String petType;
  final String price;
  final String sex;
  final String friendUId;
  final String friendEmail;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late bool _isSahiplen;
  late bool isMe;

  @override
  void initState() {
    super.initState();
    widget.price == "0" ? _isSahiplen = true : _isSahiplen = false;
    widget.friendEmail == FirebaseAuth.instance.currentUser!.email ? isMe = true : isMe = false;
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
          _litTile(context, "Yaş:", widget.ageRange),
          _litTile(context, "Tür:", widget.petType),
          // _litTile(context, "Cins:", widget.petBreed),
          _litTile(context, "Cinsiyet:", widget.sex),
          _litTile(context, "Konum:", "${widget.city} " " ${widget.ilce}"),
          const SizedBox(height: 120),
        ],
      ),
      floatingActionButton: isMe ? null : _chatFabButton(),
    );
  }

  Text _emailText(BuildContext context) {
    return Text(
      widget.friendEmail,
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
          friendUserId: widget.friendUId,
          friendUserEmail: widget.friendEmail,
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

  Text _descriptionText(BuildContext context) => Text(widget.description, style: Theme.of(context).textTheme.subtitle1);

  Text _priceText(TextStyle? headline4) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${widget.price}TL",
      style: _isSahiplen
          ? headline4?.copyWith(color: LightThemeColors.miamiMarmalade, fontSize: 24)
          : headline4?.copyWith(fontSize: 24),
    );
  }

  Text _nameText(TextStyle? headline4) => Text(
        widget.name,
        style: headline4?.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
      );

  Container _imageContainer() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: ProjectRadius.mainAllRadius,
        color: LightThemeColors.miamiMarmalade,
        image: DecorationImage(
          image: NetworkImage(widget.imagePath),
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
    return FavButton(
      iconSize: 32,
      ageRange: widget.ageRange,
      city: widget.city,
      ilce: widget.ilce,
      petBreed: widget.petBreed,
      petType: widget.petType,
      price: widget.price,
      description: widget.description,
      friendEmail: widget.friendEmail,
      friendUId: widget.friendUId,
      name: widget.name,
      sex: widget.sex,
      imagePath: widget.ilce,
    );
  }
}
