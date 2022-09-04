// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/firebase_crud/crud_service.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/jsons/city_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/city/city_select_view.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/main_view/add_view/city/ilce_select_view.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';

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
  final String image;
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
        ),
      );

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
        ),
      );
      _ilceSecilmisMi = true;
      _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi];
      setState(() {});
    }
  }

  final List<String> pets = [
    'Köpek',
    'Kedi',
    'Balık',
    'Tavşan',
    "Diğer",
  ];

  final List<String> gender = [
    'Erkek',
    'Dişi',
  ];

  final List<String> ageRange = [
    "0 - 3 Ay",
    "3 - 6 Ay",
    "6 Ay - 1 Yıl",
    "1 - 3 Yıl",
    "3 Yıldan Fazla",
  ];

  String? _petSelectedValue;
  String? _genderSelectedValue;
  String? _ageRangeSelectedValue;

  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
    print(_petSelectedValue);
    print(_genderSelectedValue);
    print(_ageRangeSelectedValue);
  }

  @override
  void dispose() {
    super.dispose();
    print(_petSelectedValue);
    print(_genderSelectedValue);
    print(_ageRangeSelectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evcil Hayvan Ekle 2/2"),
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: ListView(
        padding: ProjectPaddings.horizontalMainPadding,
        children: [
          const SizedBox(height: 24),
          citySelect(),
          const SizedBox(height: 24),
          districtSelect(),
          const SizedBox(height: 24),
          _DropDown(selectedValue: _petSelectedValue, list: pets, hint: "Evcil Hayvan Türü"),
          const SizedBox(height: 24),
          _DropDown(selectedValue: _genderSelectedValue, list: gender, hint: "Evcil Hayvan Cinsiyeti"),
          const SizedBox(height: 24),
          _DropDown(selectedValue: _ageRangeSelectedValue, list: ageRange, hint: "Evcil Hayvan Yaş Aralığı"),
          const SizedBox(height: 24),
          widget.radioValue == 1 ? const SizedBox() : _priceTextField(),
          _submitButton(),
        ],
      ),
    );
  }

  SizedBox _priceTextField() {
    return SizedBox(
      width: 175,
      child: MainTextField(
        controller: _priceController,
        hintText: "Ücret",
        minLines: 1,
        maxLines: 1,
        maxLength: 10,
        prefixIcon: const Icon(Icons.attach_money_rounded),
        keyboardType: TextInputType.number,
        suffix: "TL",
      ),
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
            _ilceSecilmisMi ? _secilenIlce : "İlçe Seçiniz",
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
            _ilSecilmisMi ? _secilenIl : "İl Seçiniz",
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

  Align _submitButton() {
    return Align(
      child: Button(
        onPressed: _onSubmitButton,
        text: "Evcil Hayvan Ekle",
        width: ProjectButtonSizes.mainButtonWidth,
        height: ProjectButtonSizes.mainButtonHeight,
      ),
    );
  }

  void _onSubmitButton() {
    CrudService()
        .createPet(
          PetModel(
            currentUid: FirebaseAuth.instance.currentUser!.uid,
            currentEmail: FirebaseAuth.instance.currentUser!.email.toString(),
            gender: _genderSelectedValue!,
            name: widget.name,
            description: widget.description,
            imagePath: widget.image,
            ageRange: _ageRangeSelectedValue!,
            city: _secilenIl,
            ilce: _secilenIlce,
            petBreed: "Buldog",
            price: widget.radioValue == 1 ? "0" : _priceController.text,
            petType: _petSelectedValue!,
          ),
          context,
        )
        .whenComplete(
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPetilla(),
            ),
          ),
        );
  }
}

class _DropDown extends StatefulWidget {
  _DropDown({Key? key, this.selectedValue, required this.list, required this.hint}) : super(key: key);

  String? selectedValue;
  final List list;
  final String hint;

  @override
  State<_DropDown> createState() => __DropDownState();
}

class __DropDownState extends State<_DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            // Hint
            Expanded(
              child: Text(
                widget.hint,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // List
        items: widget.list
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        // Selected value
        onChanged: (value) {
          setState(() {
            widget.selectedValue = value as String;
          });
          print("${widget.hint}:${widget.selectedValue}");
        },
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 24,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.white,
        buttonHeight: 50,
        buttonWidth: 175,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: LightThemeColors.burningOrange,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: LightThemeColors.burningOrange,
        ),
      ),
    );
  }
}
