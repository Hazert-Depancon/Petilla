// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/other_view/petilla_detail_view.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_icon_sizes.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/sizes/project_radius.dart';

class NormalPetWidget extends StatefulWidget {
  const NormalPetWidget({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<NormalPetWidget> createState() => _NormalPetWidgetState();
}

class _NormalPetWidgetState extends State<NormalPetWidget> {
  late bool _isSahiplen;
  @override
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isSahiplen = true : _isSahiplen = false;
  }

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailView(
            petModel: widget.petModel,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ProjectRadius.allRadius,
          color: Colors.white,
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
                  Expanded(child: _nameText(subtitle2)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _priceText(subtitle2),
                        const SizedBox(height: 4),
                        _location(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Text _priceText(TextStyle? subtitle2) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${widget.petModel.price}TL",
      style: _isSahiplen
          ? subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade, overflow: TextOverflow.ellipsis)
          : subtitle2?.copyWith(overflow: TextOverflow.ellipsis),
    );
  }

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(
          widget.petModel.city,
        ),
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

  Text _nameText(TextStyle? subtitle2) => Text(
        widget.petModel.name,
        style: subtitle2,
        overflow: TextOverflow.clip,
      );

  Expanded _imageContainer() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ProjectRadius.allRadius,
          color: Colors.grey,
          image: DecorationImage(
            image: NetworkImage(widget.petModel.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
