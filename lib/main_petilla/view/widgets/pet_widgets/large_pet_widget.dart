import 'package:flutter/material.dart';
import 'package:petilla_app_project/main_petilla/view/other_view/detail_view.dart';
import 'package:petilla_app_project/main_petilla/view/widgets/fav_button.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class LargePetWidget extends StatefulWidget {
  const LargePetWidget({
    Key? key,
    required this.sex,
    required this.name,
    required this.ageRange,
    required this.petBreed,
    required this.imagePath,
    required this.description,
    required this.city,
    required this.price,
    required this.petType,
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
  State<LargePetWidget> createState() => _LargePetWidgetState();
}

class _LargePetWidgetState extends State<LargePetWidget> {
  late bool _isSahiplen;

  @override
  void initState() {
    super.initState();
    widget.price == "0" ? _isSahiplen = true : _isSahiplen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(
                friendEmail: widget.friendEmail,
                friendUId: widget.friendUId,
                name: widget.name,
                description: widget.description,
                imagePath: widget.imagePath,
                ageRange: widget.ageRange,
                city: widget.city,
                ilce: widget.ilce,
                petBreed: widget.petBreed,
                petType: widget.petType,
                price: widget.price,
                sex: widget.sex,
              ),
            ),
          );
        },
        child: _mainContainer(context),
      ),
    );
  }

  Container _mainContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightThemeColors.snowbank,
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: _imageContainer(),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    _nameText(context),
                    const Spacer(),
                    _favButton(),
                  ],
                ),
                Row(
                  children: [
                    _paidText(context),
                    const Spacer(),
                    _location(),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _descriptionText(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _nameText(BuildContext context) => Text(widget.name, style: Theme.of(context).textTheme.headline6);

  FavButton _favButton() {
    return FavButton(
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

  Text _paidText(BuildContext context) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${widget.price} TL",
      style: _isSahiplen
          ? Theme.of(context).textTheme.subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade)
          : Theme.of(context).textTheme.subtitle2,
    );
  }

  SizedBox _descriptionText(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey[600]),
      ),
    );
  }

  Container _imageContainer() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: LightThemeColors.miamiMarmalade,
        borderRadius: ProjectRadius.allRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.imagePath),
        ),
      ),
    );
  }

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(widget.city, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      Icons.location_on_outlined,
      size: 20,
      color: LightThemeColors.pastelStrawberry,
    );
  }
}
