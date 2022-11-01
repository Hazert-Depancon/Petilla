import 'package:flutter/material.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  Future shared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favorites");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.myFavorites),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
