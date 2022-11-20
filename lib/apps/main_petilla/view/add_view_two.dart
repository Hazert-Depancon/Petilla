// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/apps/main_petilla/viewmodel/add_view_two_view_model.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/components/textfields/main_textfield.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';

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
  // bool _yuklemeTamamlandiMi = false;

  // late String _secilenIl;
  // late String _secilenIlce;

  // bool _ilSecilmisMi = false;
  // bool _ilceSecilmisMi = false;

  // List<dynamic> _illerListesi = [];

  // List<String> _ilIsimleriListesi = [];
  // List<String> _ilceIsimleriListesi = [];

  // late int _secilenIlIndexi;
  // late int _secilenIlceIndexi;

  // Future<void> _illeriGetir() async {
  //   String jsonString = await rootBundle.loadString('assets/jsons/il-ilce.json');

  //   final jsonResponse = json.decode(jsonString);

  //   _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  // }

  // void _ilIsimleriniGetir() {
  //   _ilIsimleriListesi = [];

  //   for (var element in _illerListesi) {
  //     _ilIsimleriListesi.add(element.ilAdi);
  //   }

  //   setState(() {
  //     _yuklemeTamamlandiMi = true;
  //   });
  // }

  // void _secilenIlinIlceleriniGetir(String secilenIl) {
  //   _ilceIsimleriListesi = [];
  //   for (var element in _illerListesi) {
  //     if (element.ilAdi == secilenIl) {
  //       element.ilceler.forEach((element) {
  //         _ilceIsimleriListesi.add(element.ilceAdi);
  //       });
  //     }
  //   }
  // }

  // Future<void> _ilSecmeSayfasinaGit() async {
  //   if (_yuklemeTamamlandiMi) {
  //     _secilenIlIndexi = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi),
  //         ));

  //     _ilSecilmisMi = true;
  //     _secilenIl = _ilIsimleriListesi[_secilenIlIndexi];
  //     _secilenIlinIlceleriniGetir(_illerListesi[_secilenIlIndexi].toString());
  //     setState(() {});
  //   }
  // }

  // Future<void> _ilceSecmeSayfasinaGit() async {
  //   if (_ilSecilmisMi) {
  //     _secilenIlinIlceleriniGetir(_ilIsimleriListesi[_secilenIlIndexi]);
  //     _secilenIlceIndexi = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => IlceSecmeSayfasi(ilceIsimleri: _ilceIsimleriListesi),
  //         ));
  //     _ilceSecilmisMi = true;
  //     _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi];
  //     setState(() {});
  //   }
  // }

  final pets = [
    _ThisPageTexts.dog,
    _ThisPageTexts.cat,
    _ThisPageTexts.fish,
    _ThisPageTexts.rabbit,
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

  // @override
  // void initState() {
  //   super.initState();
  //   _illeriGetir().then((value) => _ilIsimleriniGetir());
  // }

  String imageUrl = "";
  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  bool _isSubmitButtonClicked = false;

  late AddViewTwoViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddViewTwoViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        viewModel.illeriGetir().then((value) => viewModel.ilIsimleriniGetir());
      },
      viewModel: AddViewTwoViewModel(),
      onPageBuilder: (context, value) => buildScaffold,
    );
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: _appBar(),
        body: _body(context),
      );

  _body(BuildContext context) {
    return ListView(
      padding: ProjectPaddings.horizontalMainPadding,
      children: [
        mainSizedBox,
        citySelect(context),
        mainSizedBox,
        districtSelect(context),
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
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.addAPetTwoForTwo),
      foregroundColor: LightThemeColors.miamiMarmalade,
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

  DropdownButtonFormField<String> _petGenderDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 3, color: LightThemeColors.miamiMarmalade),
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

  DropdownButtonFormField<String> _petTypeDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 3, color: LightThemeColors.miamiMarmalade),
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

  _textField() {
    return MainTextField(
      controller: _typeController,
      hintText: _ThisPageTexts.petRace,
    );
  }

  SizedBox districtSelect(context) {
    return SizedBox(
      width: 175,
      child: Observer(builder: (_) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: viewModel.ilceSecilmisMi ? LightThemeColors.burningOrange : LightThemeColors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () async {
            setState(() {
              viewModel.ilceSecmeSayfasinaGit(context);
            });
          },
          child: Center(
            child: Observer(builder: (_) {
              return Text(
                viewModel.ilceSecilmisMi ? viewModel.secilenIlce : _ThisPageTexts.selectDistrict,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  SizedBox citySelect(context) {
    return SizedBox(
      width: 175,
      child: Observer(builder: (_) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: viewModel.ilSecilmisMi ? LightThemeColors.burningOrange : LightThemeColors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () async {
            await viewModel.ilSecmeSayfasinaGit(context);
          },
          child: Center(
            child: Text(
              viewModel.ilSecilmisMi ? viewModel.secilenIl : _ThisPageTexts.selectCity,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      }),
    );
  }

  Align _submitButton(context) {
    return Align(
      child: Button(
        onPressed: () {
          _isSubmitButtonClicked == false
              ? setState(() {
                  _isSubmitButtonClicked = AddViewTwoViewModel().onSubmitButton(
                    context,
                    widget.image,
                    imageUrl,
                    genderSelectedValue,
                    widget.name,
                    widget.description,
                    ageRangeSelectedValue,
                    viewModel.secilenIl,
                    viewModel.secilenIlce,
                    _typeController.text,
                    widget.radioValue,
                    petSelectedValue,
                  );
                })
              : null;
        },
        text: _ThisPageTexts.addPet,
        width: ProjectButtonSizes.mainButtonWidth,
        height: ProjectButtonSizes.mainButtonHeight,
      ),
    );
  }
}

class _ThisPageTexts {
  static String dog = LocaleKeys.dog.locale;
  static String cat = LocaleKeys.cat.locale;
  static String fish = LocaleKeys.fish.locale;
  static String rabbit = LocaleKeys.rabbit.locale;
  static String other = LocaleKeys.other.locale;
  static String male = LocaleKeys.male.locale;
  static String female = LocaleKeys.female.locale;
  static String zeroThreeMonths = LocaleKeys.zeroThreeMonths.locale;
  static String threeSixMonths = LocaleKeys.threeSixMonths.locale;
  static String sixMonthsOneYear = LocaleKeys.sixMonthsOneYear.locale;
  static String oneThreeYears = LocaleKeys.oneThreeYears.locale;
  static String moreThanThreeYears = LocaleKeys.moreThanThreeYears.locale;
  static String petAgeRange = LocaleKeys.petAgeRange.locale;
  static String petGender = LocaleKeys.petGender.locale;
  static String petType = LocaleKeys.petType.locale;
  static String petRace = LocaleKeys.petRace.locale;
  static String selectDistrict = LocaleKeys.selectDistrict.locale;
  static String selectCity = LocaleKeys.selectCity.locale;
  static String addPet = LocaleKeys.addAPet.locale;
  static String addAPetTwoForTwo = LocaleKeys.addPetTwoForTwo.locale;
}
