// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/apps/main_petilla/service/models/jsons/city_model.dart';
import 'package:petilla_app_project/apps/main_petilla/view/city_select_view.dart';
import 'package:petilla_app_project/apps/main_petilla/view/ilce_select_view.dart';
import 'package:petilla_app_project/apps/main_petilla/view/main_petilla.dart';
import 'package:petilla_app_project/apps/main_petilla/service/firebase_crud/crud_service.dart';
import 'package:petilla_app_project/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/core/components/dialogs/default_dialog.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:mobx/mobx.dart';
import 'package:petilla_app_project/core/base/model/base_view_model.dart';

part 'add_view_two_view_model.g.dart';

class AddViewTwoViewModel = _AddViewTwoViewModelBase with _$AddViewTwoViewModel;

abstract class _AddViewTwoViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  bool yuklemeTamamlandiMi = false;

  @observable
  late String secilenIl;

  @observable
  late String secilenIlce;

  @observable
  bool ilSecilmisMi = false;

  @observable
  bool ilceSecilmisMi = false;

  @observable
  List<dynamic> illerListesi = [];

  @observable
  List<String> ilIsimleriListesi = [];

  @observable
  List<String> ilceIsimleriListesi = [];

  @observable
  late int secilenIlIndexi;

  @observable
  late int secilenIlceIndexi;

  @action
  Future<void> illeriGetir() async {
    String jsonString = await rootBundle.loadString('assets/jsons/il-ilce.json');

    final jsonResponse = json.decode(jsonString);

    illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  @action
  void ilIsimleriniGetir() {
    ilIsimleriListesi = [];

    for (var element in illerListesi) {
      ilIsimleriListesi.add(element.ilAdi);
    }

    yuklemeTamamlandiMi = true;
  }

  @action
  void secilenIlinIlceleriniGetir(String secilenIl) {
    ilceIsimleriListesi = [];
    for (var element in illerListesi) {
      if (element.ilAdi == secilenIl) {
        element.ilceler.forEach((element) {
          ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    }
  }

  @action
  Future<void> ilSecmeSayfasinaGit(context) async {
    if (yuklemeTamamlandiMi) {
      secilenIlIndexi = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IlSecimiSayfasi(ilIsimleri: ilIsimleriListesi),
          ));

      ilSecilmisMi = true;
      secilenIl = ilIsimleriListesi[secilenIlIndexi];
      secilenIlinIlceleriniGetir(illerListesi[secilenIlIndexi].toString());
    }
  }

  @action
  Future<void> ilceSecmeSayfasinaGit(context) async {
    if (ilSecilmisMi) {
      secilenIlinIlceleriniGetir(ilIsimleriListesi[secilenIlIndexi]);
      secilenIlceIndexi = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IlceSecmeSayfasi(ilceIsimleri: ilceIsimleriListesi),
          ));
      ilceSecilmisMi = true;
      secilenIlce = ilceIsimleriListesi[secilenIlceIndexi];
    }
  }

  @action
  onSubmitButton(
    context,
    image,
    imageUrl,
    genderSelectedValue,
    name,
    description,
    ageRangeSelectedValue,
    secilenIl,
    secilenIlce,
    type,
    radioValue,
    petSelectedValue,
  ) {
    showDefaultLoadingDialog(false, context);
    CrudService()
        .createPet(
          image,
          imageUrl,
          PetModel(
            currentUserName: FirebaseAuth.instance.currentUser!.displayName!,
            currentUid: FirebaseAuth.instance.currentUser!.uid,
            currentEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            gender: genderSelectedValue ?? LocaleKeys.error,
            name: name,
            description: description,
            imagePath: imageUrl,
            ageRange: ageRangeSelectedValue ?? LocaleKeys.error,
            city: secilenIl,
            ilce: secilenIlce,
            petBreed: type,
            price: radioValue == 1 ? "0" : "",
            petType: petSelectedValue ?? LocaleKeys.error,
          ),
          context,
        )
        .then(
          (value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPetilla()),
            (route) => false,
          ),
        );
    return true;
  }
}
