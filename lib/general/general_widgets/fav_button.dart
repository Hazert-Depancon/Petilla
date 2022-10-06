import 'package:flutter/material.dart';
import 'package:petilla_app_project/constant/others_constant/icon_names.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class FavButton extends StatefulWidget {
  const FavButton({Key? key, this.iconSize = 24}) : super(key: key);

  final double? iconSize;

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.iconSize,
      onPressed: _onFav,
      icon: _favIcon(),
    );
  }

  Icon _favIcon() {
    return Icon(
      isFav ? AppIcons.favoriteIcon : AppIcons.favoriteBorderIcon,
      color: isFav ? LightThemeColors.red : LightThemeColors.black,
    );
  }

  _onFav() {
    setState(() {
      isFav = !isFav;
    });
  }
}
