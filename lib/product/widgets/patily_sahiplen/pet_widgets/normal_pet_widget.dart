// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/utility/widget_utility/fav_button_service.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';
import 'package:patily/feature/patily_sahiplen/view/patily_sahiplen_detail_view.dart';

class NormalPetWidget extends StatefulWidget {
  const NormalPetWidget({Key? key, required this.petModel, this.isFav})
      : super(key: key);

  final PetModel petModel;
  final bool? isFav;

  @override
  State<NormalPetWidget> createState() => _NormalPetWidgetState();
}

class _NormalPetWidgetState extends BaseState<NormalPetWidget> {
  late bool _isClaim;
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
  void initState() {
    super.initState();
    widget.petModel.price == "0" ? _isClaim = true : _isClaim = false;
  }

  callDetailView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DetailView(
            petModel: widget.petModel,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle2 = textTheme.labelMedium
        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14);
    return GestureDetector(
      onTap: () {
        callDetailView();
      },
      child: _mainContainer(subtitle2),
    );
  }

  Container _mainContainer(TextStyle? subtitle2) {
    return Container(
      decoration: _boxDecoration(),
      child: Padding(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            context.emptySizedHeightBoxLow,
            _imageContainer(),
            context.emptySizedHeightBoxLow,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameText(subtitle2),
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
            context.emptySizedHeightBoxLow
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: context.normalBorderRadius,
      color: LightThemeColors.snowbank,
    );
  }

  Text _priceText(TextStyle? subtitle2) {
    return Text(
      _isClaim ? LocaleKeys.claim.locale : "${widget.petModel.price}TL",
      style: _isClaim
          ? subtitle2?.copyWith(
              color: LightThemeColors.miamiMarmalade,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold)
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
          style: context.textTheme.bodySmall?.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Icon _placeIcon() {
    return const Icon(
      AppIcons.locationOnOtlinedIcon,
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
          borderRadius: context.normalBorderRadius,
          color: LightThemeColors.grey,
          image: DecorationImage(
            image: NetworkImage(widget.petModel.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.isFav ?? false ? null : _favButton(),
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
                ? const Icon(AppIcons.favoriteIcon, color: Colors.red)
                : const Icon(AppIcons.favoriteBorderIcon),
          ),
        );
      },
    );
  }
}
