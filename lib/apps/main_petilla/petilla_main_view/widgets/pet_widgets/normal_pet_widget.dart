import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/other_view/petilla_detail_view.dart';
import 'package:petilla_app_project/general/general_widgets/fav_button.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_card_sizes.dart';
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
  late String price;
  late bool _isSahiplen;

  @override
  void initState() {
    super.initState();
    price = widget.petModel.price;
    price == "0" ? _isSahiplen = true : _isSahiplen = false;
  }

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;

    return InkWell(
      borderRadius: ProjectRadius.allRadius,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              petModel: _petModel(),
            ),
          ),
        );
      },
      child: Container(
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
                  Expanded(
                    flex: 45,
                    child: _nameText(
                      subtitle2?.copyWith(fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Spacer(flex: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Expanded(
                      flex: 45,
                      child: _priceText(subtitle2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              _location(),
            ],
          ),
        ),
      ),
    );
  }

  PetModel _petModel() {
    return PetModel(
      currentUid: widget.petModel.currentUid,
      currentEmail: widget.petModel.currentEmail,
      ilce: widget.petModel.ilce,
      sex: widget.petModel.sex,
      name: widget.petModel.name,
      description: widget.petModel.description,
      imagePath: widget.petModel.imagePath,
      ageRange: widget.petModel.ageRange,
      city: widget.petModel.city,
      petBreed: widget.petModel.petBreed,
      price: price,
      petType: widget.petModel.petType,
    );
  }

  Text _priceText(TextStyle? subtitle2) {
    return Text(
      _isSahiplen ? "Sahiplen" : "${price}TL",
      style: _isSahiplen
          ? subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade, overflow: TextOverflow.ellipsis)
          : subtitle2?.copyWith(overflow: TextOverflow.ellipsis),
    );
  }

  Text _nameText(TextStyle? subtitle2) => Text(widget.petModel.name, style: subtitle2);

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(widget.petModel.city, overflow: TextOverflow.clip),
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
          image: NetworkImage(widget.petModel.imagePath),
        ),
      ),
      child: const Align(
        alignment: Alignment.topRight,
        child: FavButton(),
      ),
    );
  }
}
