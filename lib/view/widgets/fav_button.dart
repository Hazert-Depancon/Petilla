import 'package:flutter/material.dart';

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
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.black,
      ),
    );
  }

  void _onFav() {
    return setState(() {
      isFav = !isFav;
    });
  }
}
