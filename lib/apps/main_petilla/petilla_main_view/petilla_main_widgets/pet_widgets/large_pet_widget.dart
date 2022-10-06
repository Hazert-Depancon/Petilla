import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/other_view/petilla_detail_view.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes/project_radius.dart';
import 'package:petilla_app_project/general/general_widgets/fav_button.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class LargePetWidget extends StatefulWidget {
  const LargePetWidget({Key? key, required this.petModel}) : super(key: key);

  final PetModel petModel;

  @override
  State<LargePetWidget> createState() => _LargePetWidgetState();
}

class _LargePetWidgetState extends State<LargePetWidget> {
  late bool _isClaim;

  @override
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isClaim = true : _isClaim = false;
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
                petModel: _petModel(),
              ),
            ),
          );
        },
        child: _mainContainer(context),
      ),
    );
  }

  PetModel _petModel() {
    return PetModel(
      currentUid: widget.petModel.currentUid,
      currentEmail: widget.petModel.currentEmail,
      ilce: widget.petModel.ilce,
      gender: widget.petModel.gender,
      name: widget.petModel.name,
      description: widget.petModel.description,
      imagePath: widget.petModel.imagePath,
      ageRange: widget.petModel.ageRange,
      city: widget.petModel.city,
      petBreed: widget.petModel.petBreed,
      price: widget.petModel.price,
      petType: widget.petModel.petType,
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

  Text _nameText(BuildContext context) => Text(widget.petModel.name, style: Theme.of(context).textTheme.headline6);

  FavButton _favButton() {
    return const FavButton();
  }

  Text _paidText(BuildContext context) {
    return Text(
      _isClaim ? "claim".tr() : "${widget.petModel.price} TL",
      style: _isClaim
          ? Theme.of(context).textTheme.subtitle2?.copyWith(color: LightThemeColors.miamiMarmalade)
          : Theme.of(context).textTheme.subtitle2,
    );
  }

  SizedBox _descriptionText(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.petModel.description,
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
          image: NetworkImage(widget.petModel.imagePath),
        ),
      ),
    );
  }

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(widget.petModel.city, overflow: TextOverflow.clip, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      AppIcons.locationOnOtlinedIcon,
      size: 20,
      color: LightThemeColors.pastelStrawberry,
    );
  }
}
