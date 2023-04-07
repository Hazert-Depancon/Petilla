// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/product/widgets/buttons/button.dart';
import 'package:patily/product/widgets/textfields/main_textfield.dart';
import 'package:patily/core/base/state/base_state.dart';

import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/product/models/city_model.dart';
import 'package:patily/feature/patily_sahiplen/view/city_select_view.dart';
import 'package:patily/feature/patily_sahiplen/view/ilce_select_view.dart';
import 'package:patily/feature/patily_sahiplen/viewmodel/add_view_two_view_model.dart';

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

class _AddViewTwoState extends BaseState<AddViewTwo> {
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
    String jsonString = await rootBundle.loadString(Assets.jsons.ilIlce);

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
            builder: (context) =>
                IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi),
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
            builder: (context) =>
                IlceSecmeSayfasi(ilceIsimleri: _ilceIsimleriListesi),
          ));
      _ilceSecilmisMi = true;
      _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi];
      setState(() {});
    }
  }

  final pets = [
    _ThisPageTexts.dog,
    _ThisPageTexts.cat,
    _ThisPageTexts.fish,
    _ThisPageTexts.rabbit,
    _ThisPageTexts.bird,
    _ThisPageTexts.other,
  ];

  final List<String> gender = [
    _ThisPageTexts.male,
    _ThisPageTexts.female,
  ];

  final List<String> ageRange = [
    _ThisPageTexts.zeroThreeMonths,
    _ThisPageTexts.threeSixMonths,
    _ThisPageTexts.sixMonthsOneYear,
    _ThisPageTexts.oneThreeYears,
    _ThisPageTexts.moreThanThreeYears,
  ];

  String? petSelectedValue;
  String? genderSelectedValue;
  String? ageRangeSelectedValue;

  final TextEditingController _typeController = TextEditingController();

  String imageUrl = "";

  bool _isSubmitButtonClicked = false;

  late AddViewTwoViewModel viewModel;

  void _createInterstitialAd() {
    viewModel.createInterstitialAd();
  }

  void _showInterstitialAd() {
    viewModel.showInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddViewTwoViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        _illeriGetir().then((value) => _ilIsimleriniGetir());
        _createInterstitialAd();
      },
      viewModel: AddViewTwoViewModel(),
      onPageBuilder: (context, value) => _buildScaffold,
    );
  }

  Scaffold get _buildScaffold => Scaffold(
        appBar: _appBar,
        body: _body(context),
      );

  AppBar get _appBar => AppBar(
        title: Text(_ThisPageTexts.addAPetTwoForTwo),
      );

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: context.horizontalPaddingNormal,
        children: [
          context.emptySizedHeightBoxLow3x,
          citySelect,
          context.emptySizedHeightBoxLow3x,
          districtSelect,
          context.emptySizedHeightBoxLow3x,
          _petTypeDropDown,
          context.emptySizedHeightBoxLow3x,
          _petGenderDropDown,
          context.emptySizedHeightBoxLow3x,
          _petAgeRangeDropDown,
          context.emptySizedHeightBoxLow3x,
          _textField,
          context.emptySizedHeightBoxLow3x,
          widget.radioValue == 1 ? const SizedBox() : _textField,
          _submitButton(context),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> get _petAgeRangeDropDown {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: const BorderSide(
            width: 3,
            color: LightThemeColors.miamiMarmalade,
          ),
        ),
      ),
      hint: Text(
        _ThisPageTexts.petAgeRange,
      ),
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

  DropdownButtonFormField<String> get _petGenderDropDown {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: const BorderSide(
              width: 3, color: LightThemeColors.miamiMarmalade),
        ),
      ),
      hint: Text(_ThisPageTexts.petGender),
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

  DropdownButtonFormField<String> get _petTypeDropDown {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: const BorderSide(
              width: 3, color: LightThemeColors.miamiMarmalade),
        ),
      ),
      hint: Text(_ThisPageTexts.petType),
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

  MainTextField get _textField {
    return MainTextField(
      controller: _typeController,
      hintText: _ThisPageTexts.petRace,
    );
  }

  SizedBox get districtSelect {
    return SizedBox(
      width: 175,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _ilceSecilmisMi
              ? LightThemeColors.burningOrange
              : LightThemeColors.grey,
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
            _ilceSecilmisMi ? _secilenIlce : _ThisPageTexts.selectDistrict,
            style: textTheme.bodyMedium!.copyWith(
              color: LightThemeColors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox get citySelect {
    return SizedBox(
      width: 175,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _ilSecilmisMi
              ? LightThemeColors.burningOrange
              : LightThemeColors.grey,
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
            _ilSecilmisMi ? _secilenIl : _ThisPageTexts.selectCity,
            style: textTheme.bodyMedium!.copyWith(
              color: LightThemeColors.white,
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
        onPressed: () {
          if (_isSubmitButtonClicked == false) {
            _showInterstitialAd();
            setState(() {
              _isSubmitButtonClicked = viewModel.onSubmitButton(
                context,
                widget.image,
                imageUrl,
                genderSelectedValue,
                widget.name,
                widget.description,
                ageRangeSelectedValue,
                _secilenIl,
                _secilenIlce,
                _typeController.text,
                widget.radioValue,
                petSelectedValue,
              );
            });
          }
        },
        text: _ThisPageTexts.addPet,
      ),
    );
  }
}

class _ThisPageTexts {
  static String dog = LocaleKeys.animalNames_dog.locale;
  static String cat = LocaleKeys.animalNames_cat.locale;
  static String fish = LocaleKeys.animalNames_fish.locale;
  static String rabbit = LocaleKeys.animalNames_rabbit.locale;
  static String bird = LocaleKeys.animalNames_bird.locale;
  static String other = LocaleKeys.other.locale;
  static String male = LocaleKeys.male.locale;
  static String female = LocaleKeys.female.locale;
  static String zeroThreeMonths = LocaleKeys.ageRanges_zeroThreeMonths.locale;
  static String threeSixMonths = LocaleKeys.ageRanges_threeSixMonths.locale;
  static String sixMonthsOneYear =
      LocaleKeys.ageRanges_sixMonths_one_year.locale;
  static String oneThreeYears = LocaleKeys.ageRanges_one_three_years.locale;
  static String moreThanThreeYears =
      LocaleKeys.ageRanges_more_than_three_years.locale;
  static String petAgeRange = LocaleKeys.petAgeRange.locale;
  static String petGender = LocaleKeys.petGender.locale;
  static String petType = LocaleKeys.petType.locale;
  static String petRace = LocaleKeys.petRace.locale;
  static String selectDistrict = LocaleKeys.selectDistrict.locale;
  static String selectCity = LocaleKeys.citySelect.locale;
  static String addPet = LocaleKeys.patilySahiplenPages_addAPet.locale;
  static String addAPetTwoForTwo = LocaleKeys.addPetTwoForTwo.locale;
}
