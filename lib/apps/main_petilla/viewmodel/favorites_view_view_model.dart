// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_view_view_model.g.dart';

class FavoritesViewViewModel = _FavoritesViewViewModelBase with _$FavoritesViewViewModel;

abstract class _FavoritesViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  int? listLenght = 0;

  @observable
  List? myList;

  @observable
  List<String> list = [];

  @action
  Future<void> getShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myList = preferences.getStringList(SharedKeys.FAVS.toString()) ?? [];
    listLenght = myList?.length ?? 0;

    for (var i = 0; i < listLenght!; i++) {
      list.add(myList![i]);
    }
  }
}
