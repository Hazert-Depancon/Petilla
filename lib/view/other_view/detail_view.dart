import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/view/widgets/fav_button.dart';

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

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late bool _isSahiplen;

  @override
  void initState() {
    super.initState();
    widget.price == "0" ? _isSahiplen = true : _isSahiplen = false;
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
          _litTile(context, "Cins:", widget.petBreed),
          _litTile(context, "Cinsiyet:", widget.sex),
          _litTile(context, "Konum:", "${widget.city} " " ${widget.ilce}"),
          const SizedBox(height: 120),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
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
        child: FavButton(
          iconSize: 32,
          ageRange: widget.ageRange,
          city: widget.city,
          ilce: widget.ilce,
          petBreed: widget.petBreed,
          petType: widget.petType,
          price: widget.price,
          description: widget.description,
          name: widget.name,
          imagePath: widget.imagePath,
          sex: widget.sex,
        ),
      ),
    );
  }
}
