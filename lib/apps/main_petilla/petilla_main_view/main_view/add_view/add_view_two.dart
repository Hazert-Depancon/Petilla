// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/firebase_crud/crud_service.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/jsons/city_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/city/city_select_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/city/ilce_select_view.dart';
import 'package:petilla_app_project/constant/sizes/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes/project_padding.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/dialogs/default_dialog.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class AddViewTwo extends StatefulWidget {
  const AddViewTwo({
    Key? key,
    required this.name,
    required this.description,
    required this.radioValue,
    required this.image,
  }) : super(key: key);

  final String name;
  final String description;
  final XFile image;
  final int radioValue;

  @override
  _AddViewTwoState createState() => _AddViewTwoState();
}

class _AddViewTwoState extends State<AddViewTwo> {
  bool _yuklemeTamamlandiMi = false;

  late String _secilenIl;
  late String _secilenIlce;

  bool _ilSecilmisMi = false;
  bool _ilceSecilmisMi = false;

  List<dynamic> _illerListesi = [];

  List<String> _ilIsimleriListesi = [];
  List<String> _ilceIsimleriListesi = [];

  late int _secilenIlIndexi;
  late int _secilenIlceIndexi;

  Future<void> _illeriGetir() async {
    String jsonString = await rootBundle.loadString('assets/jsons/il-ilce.json');

    final jsonResponse = json.decode(jsonString);

    _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  void _ilIsimleriniGetir() {
    _ilIsimleriListesi = [];

    for (var element in _illerListesi) {
      _ilIsimleriListesi.add(element.ilAdi);
    }

    setState(() {
      _yuklemeTamamlandiMi = true;
    });
  }

  void _secilenIlinIlceleriniGetir(String secilenIl) {
    _ilceIsimleriListesi = [];
    for (var element in _illerListesi) {
      if (element.ilAdi == secilenIl) {
        element.ilceler.forEach((element) {
          _ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    }
  }

  Future<void> _ilSecmeSayfasinaGit() async {
    if (_yuklemeTamamlandiMi) {
      _secilenIlIndexi = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi),
          ));

      _ilSecilmisMi = true;
      _secilenIl = _ilIsimleriListesi[_secilenIlIndexi];
      _secilenIlinIlceleriniGetir(_illerListesi[_secilenIlIndexi].toString());
      setState(() {});
    }
  }

  Future<void> _ilceSecmeSayfasinaGit() async {
    if (_ilSecilmisMi) {
      _secilenIlinIlceleriniGetir(_ilIsimleriListesi[_secilenIlIndexi]);
      _secilenIlceIndexi = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IlceSecmeSayfasi(ilceIsimleri: _ilceIsimleriListesi),
          ));
      _ilceSecilmisMi = true;
      _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi];
      setState(() {});
    }
  }

  final pets = [
    "dog".tr(),
    "cat".tr(),
    "fish".tr(),
    "rabbit".tr(),
    "other".tr(),
  ];

  final List<String> gender = [
    "male".tr(),
    "female".tr(),
  ];

  final List<String> ageRange = [
    "zero_three_months".tr(),
    "three_six_months".tr(),
    "six_months_one_year".tr(),
    "one_three_years".tr(),
    "more_than_three_years".tr(),
  ];

  String? petSelectedValue;
  String? genderSelectedValue;
  String? ageRangeSelectedValue;

  final TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
  }

  String imageUrl = "";

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add_pet_two_for_two".tr()),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: ListView(
        padding: ProjectPaddings.horizontalMainPadding,
        children: [
          mainSizedBox,
          citySelect(),
          mainSizedBox,
          districtSelect(),
          mainSizedBox,
          _petTypeDropDown(),
          mainSizedBox,
          _petGenderDropDown(),
          mainSizedBox,
          _petAgeRangeDropDown(),
          mainSizedBox,
          _textField(),
          mainSizedBox,
          widget.radioValue == 1 ? const SizedBox() : _textField(),
          _submitButton(context),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> _petAgeRangeDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 3, color: LightThemeColors.miamiMarmalade),
        ),
      ),
      hint: Text("pet_age_range".tr()),
      value: ageRangeSelectedValue,
      items: ageRange
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          ageRangeSelectedValue = val;
        });
      },
    );
  }

  DropdownButtonFormField<String> _petGenderDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 3, color: LightThemeColors.miamiMarmalade),
        ),
      ),
      hint: Text("pet_gender".tr()),
      value: genderSelectedValue,
      items: gender
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          genderSelectedValue = val;
        });
      },
    );
  }

  DropdownButtonFormField<String> _petTypeDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 3, color: LightThemeColors.miamiMarmalade),
        ),
      ),
      hint: Text("pet_type".tr()),
      value: petSelectedValue,
      items: pets
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          petSelectedValue = val;
        });
      },
    );
  }

  _textField() {
    return MainTextField(
      controller: _typeController,
      hintText: "pet_race".tr(),
    );
  }

  SizedBox districtSelect() {
    return SizedBox(
      width: 175,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _ilceSecilmisMi ? LightThemeColors.burningOrange : Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        onPressed: () async {
          await _ilceSecmeSayfasinaGit();
        },
        child: Center(
          child: Text(
            _ilceSecilmisMi ? _secilenIlce : "select_district".tr(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox citySelect() {
    return SizedBox(
      width: 175,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _ilSecilmisMi ? LightThemeColors.burningOrange : Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        onPressed: () async {
          await _ilSecmeSayfasinaGit();
          _ilceSecilmisMi = false;
        },
        child: Center(
          child: Text(
            _ilSecilmisMi ? _secilenIl : "city_select",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Align _submitButton(context) {
    return Align(
      child: Button(
        onPressed: () async {
          _onSubmitButton(context);
        },
        text: "add_a_pet".tr(),
        width: ProjectButtonSizes.mainButtonWidth,
        height: ProjectButtonSizes.mainButtonHeight,
      ),
    );
  }

  _onSubmitButton(context) async {
    showDefaultLoadingDialog(false, context);
    CrudService()
        .createPet(
          widget.image,
          imageUrl,
          PetModel(
            currentUid: FirebaseAuth.instance.currentUser!.uid,
            currentEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            gender: genderSelectedValue ?? "error".tr(),
            name: widget.name,
            description: widget.description,
            imagePath: imageUrl,
            ageRange: ageRangeSelectedValue ?? "error".tr(),
            city: _secilenIl,
            ilce: _secilenIlce,
            petBreed: _typeController.text,
            price: widget.radioValue == 1 ? "0" : _typeController.text,
            petType: petSelectedValue ?? "error".tr(),
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
  }
}
