import 'package:flutter/material.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  int listLenght = 0;
  List myList = [];
  String docId = "";

  Future<void> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myList = preferences.getStringList("favs")!;
    listLenght = myList.length;
    for (var i = 0; i < listLenght - 1; i++) {
      setState(() {
        docId = myList[i];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: const [],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(Localization.myFavorites),
      automaticallyImplyLeading: false,
    );
  }
}
