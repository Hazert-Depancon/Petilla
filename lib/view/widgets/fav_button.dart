import 'package:flutter/material.dart';

class FavButton extends StatefulWidget {
  const FavButton({
    Key? key,
    this.iconSize = 24,
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
  }) : super(key: key);

  final double? iconSize;
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

  _onFav() {
    setState(() {
      isFav = !isFav;
    });
  }
}
