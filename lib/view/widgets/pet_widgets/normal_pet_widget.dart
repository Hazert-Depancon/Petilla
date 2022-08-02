// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_icon_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/sizes/project_radius.dart';
import 'package:petilla_app_project/view/widgets/fav_button.dart';

class NormalPetWidget extends StatefulWidget {
  const NormalPetWidget({
    Key? key,
    required this.sex,
    required this.name,
    required this.ageRange,
    required this.petBreed,
    required this.imagePath,
    required this.description,
    required this.location,
    required this.price,
    required this.petType,
  }) : super(key: key);

  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String location;
  final String petBreed;
  final String petType;
  final String price;
  final String sex;

  @override
  State<NormalPetWidget> createState() => _NormalPetWidgetState();
}

class _NormalPetWidgetState extends State<NormalPetWidget> {
  late String name;
  late String price;
  late String location;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    price = widget.price.toString();
    location = widget.location;
    price == 0 ? _isSahiplen = true : _isSahiplen = false;
    imagePath = widget.imagePath;
  }

  late bool _isSahiplen = false;

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;

    return Container(
      decoration: BoxDecoration(
        color: LightThemeColors.white,
        borderRadius: ProjectRadius.allRadius,
      ),
      child: Padding(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _imageContainer(),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameText(subtitle2?.copyWith(fontSize: 16)),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // _isSahiplen ? "Sahiplen" : "${price}TL",
                      "Sahiplen",
                      style: _isSahiplen ? subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade) : subtitle2,
                    ),
                    const SizedBox(height: 4),
                    _location(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text _nameText(TextStyle? subtitle2) => Text(name, style: subtitle2);

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(location),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      Icons.location_on_outlined,
      size: ProjectIconSizes.smallIconSize,
      color: LightThemeColors.pastelStrawberry,
    );
  }

  Container _imageContainer() {
    return Container(
      width: ProjectCardSizes.secondaryCardWidth,
      height: ProjectCardSizes.secondaryCardHeight,
      decoration: BoxDecoration(
        color: LightThemeColors.miamiMarmalade,
        borderRadius: ProjectRadius.allRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
      child: const Align(
        alignment: Alignment.topRight,
        child: FavButton(),
      ),
    );
  }
}
