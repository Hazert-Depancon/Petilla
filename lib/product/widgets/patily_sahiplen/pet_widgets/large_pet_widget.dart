import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/core/base/state/base_state.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/utility/widget_utility/fav_button_service.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';
import 'package:patily/feature/patily_sahiplen/view/patily_sahiplen_detail_view.dart';

class LargePetWidget extends StatefulWidget {
  const LargePetWidget({Key? key, required this.petModel, this.isMe})
      : super(key: key);

  final PetModel petModel;
  final bool? isMe;

  @override
  State<LargePetWidget> createState() => _LargePetWidgetState();
}

class _LargePetWidgetState extends BaseState<LargePetWidget> {
  late bool _isClaim;
  late bool _isMe;
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
    widget.petModel.currentUid == FirebaseAuth.instance.currentUser?.uid
        ? _isMe = true
        : _isMe = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          _callDetailView(context);
        },
        child: _mainContainer(context),
      ),
    );
  }

  void _callDetailView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailView(
          petModel: _petModel(),
        ),
      ),
    );
  }

  PetModel _petModel() {
    return widget.petModel;
  }

  Container _mainContainer(BuildContext context) {
    return Container(
      decoration: _boxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: _imageContainer(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.emptySizedHeightBoxLow,
                Row(
                  children: [
                    _nameText(context),
                    const Spacer(),
                    _isMe || (widget.isMe ?? false)
                        ? _deleteIconButton()
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _paidText(context),
                    const Spacer(),
                    _location(),
                    const SizedBox(width: 12),
                  ],
                ),
                context.emptySizedHeightBoxLow,
                _descriptionText(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _deleteIconButton() {
    return IconButton(
      onPressed: () {
        FirebaseCollectionEnum.pets.reference
            .doc(widget.petModel.docId)
            .delete();
      },
      icon: const Icon(AppIcons.deleteIcon),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: LightThemeColors.snowbank,
      borderRadius: context.normalBorderRadius,
    );
  }

  Text _nameText(BuildContext context) {
    return Text(widget.petModel.name, style: textTheme.headlineSmall);
  }

  Text _paidText(BuildContext context) {
    return Text(
      _isClaim ? LocaleKeys.adopt.locale : "${widget.petModel.price} TL",
      style: _isClaim
          ? textTheme.titleSmall
              ?.copyWith(color: LightThemeColors.miamiMarmalade)
          : textTheme.titleSmall,
    );
  }

  _descriptionText(BuildContext context) {
    return Text(
      widget.petModel.description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: textTheme.labelLarge?.copyWith(color: Colors.grey[600]),
    );
  }

  Container _imageContainer() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: LightThemeColors.miamiMarmalade,
        borderRadius: context.normalBorderRadius,
        image: DecorationImage(
            fit: BoxFit.cover, image: NetworkImage(widget.petModel.imagePath)),
      ),
      child: _isMe || (widget.isMe ?? false) ? null : _favButton(),
    );
  }

  Row _location() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _placeIcon(),
        Text(widget.petModel.city,
            overflow: TextOverflow.clip, style: textTheme.titleLarge),
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
