// Dişi erkek kontrolündeki büyük küçük harf sorunu

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_view/petilla_main_widgets/pet_widgets/normal_pet_widget.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/start/select_app_view.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class PetillaHomeView extends StatefulWidget {
  const PetillaHomeView({Key? key}) : super(key: key);

  @override
  State<PetillaHomeView> createState() => _PetillaHomeViewState();
}

class _PetillaHomeViewState extends State<PetillaHomeView> {
  Object? val1 = 0;
  Object? val2 = 0;
  Object? val3 = 0;

  bool isThereAFilter = false;
  String? selectedTypeFilter;
  String? selectedAgeRangeFilter;
  String? selectedGenderFilter;
  @override
  Widget build(BuildContext context) {
    var dogRadioListTile = _typeRadioListTile(1, _ThisPageTexts.dog, context);
    var catradioListTile = _typeRadioListTile(2, _ThisPageTexts.cat, context);
    var rabbitRadioListTile = _typeRadioListTile(3, _ThisPageTexts.rabbit, context);
    var fishRadioListTile = _typeRadioListTile(4, _ThisPageTexts.fish, context);
    var otherRadioListTile = _typeRadioListTile(5, _ThisPageTexts.other, context);

    var zeroThreeMonthsRadioListTile = _ageRangeRadioListTile(1, _ThisPageTexts.zeroThreeMonths, context);
    var threeSixMonthsRadioListTile = _ageRangeRadioListTile(2, _ThisPageTexts.threeSixMonths, context);
    var sixMonthsOneYearRadioListTile = _ageRangeRadioListTile(3, _ThisPageTexts.sixMonthsOneYear, context);
    var oneThreeYearsRadioListTile = _ageRangeRadioListTile(4, _ThisPageTexts.oneThreeYears, context);
    var moreThanThreeYearsRadioListTile = _ageRangeRadioListTile(5, _ThisPageTexts.moreThreeYears, context);

    var maleRadioListTile = _genderRadioListTile(1, _ThisPageTexts.male, context);
    var femaleRadioListTile = _genderRadioListTile(2, _ThisPageTexts.female, context);

    return Scaffold(
      appBar: _appBar(context),
      endDrawer: _drawer(
        context,
        dogRadioListTile,
        catradioListTile,
        rabbitRadioListTile,
        fishRadioListTile,
        otherRadioListTile,
        zeroThreeMonthsRadioListTile,
        threeSixMonthsRadioListTile,
        sixMonthsOneYearRadioListTile,
        oneThreeYearsRadioListTile,
        moreThanThreeYearsRadioListTile,
        maleRadioListTile,
        femaleRadioListTile,
      ),
      body: _streamBuilder(),
    );
  }

  Drawer _drawer(
    BuildContext context,
    RadioListTile<dynamic> dogRadioListTile,
    RadioListTile<dynamic> catradioListTile,
    RadioListTile<dynamic> rabbitRadioListTile,
    RadioListTile<dynamic> fishRadioListTile,
    RadioListTile<dynamic> otherRadioListTile,
    RadioListTile<dynamic> zeroThreeMonthsRadioListTile,
    RadioListTile<dynamic> threeSixMonthsRadioListTile,
    RadioListTile<dynamic> sixMonthsOneYearRadioListTile,
    RadioListTile<dynamic> oneThreeYearsRadioListTile,
    RadioListTile<dynamic> moreThanThreeYearsRadioListTile,
    RadioListTile<dynamic> maleRadioListTile,
    RadioListTile<dynamic> femaleRadioListTile,
  ) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12) + const EdgeInsets.only(left: 16, right: 4),
            child: Row(
              children: [
                _drawerTitle(context),
                const Spacer(),
                _deleteFilterButton(),
              ],
            ),
          ),
          _typeExpansionTile(
            context,
            dogRadioListTile,
            catradioListTile,
            rabbitRadioListTile,
            fishRadioListTile,
            otherRadioListTile,
          ),
          _ageRangeExpansionTile(
            context,
            zeroThreeMonthsRadioListTile,
            threeSixMonthsRadioListTile,
            sixMonthsOneYearRadioListTile,
            oneThreeYearsRadioListTile,
            moreThanThreeYearsRadioListTile,
          ),
          _genderExpansionTile(context, maleRadioListTile, femaleRadioListTile),
        ],
      ),
    );
  }

  IconButton _deleteFilterButton() {
    return IconButton(
      onPressed: _onCloseIcon,
      tooltip: _ThisPageTexts.clear,
      icon: const Icon(AppIcons.closeIcon, color: LightThemeColors.miamiMarmalade),
    );
  }

  void _onCloseIcon() {
    setState(() {
      selectedTypeFilter = null;
      selectedAgeRangeFilter = null;
      selectedGenderFilter = null;
      val1 = 0;
      val2 = 0;
      val3 = 0;
    });
  }

  Text _drawerTitle(BuildContext context) {
    return Text(
      _ThisPageTexts.filterPets,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: LightThemeColors.miamiMarmalade,
            fontSize: 22,
          ),
    );
  }

  ExpansionTile _typeExpansionTile(
      BuildContext context,
      RadioListTile<dynamic> dogRadioListTile,
      RadioListTile<dynamic> catradioListTile,
      RadioListTile<dynamic> rabbitRadioListTile,
      RadioListTile<dynamic> fishRadioListTile,
      RadioListTile<dynamic> otherRadioListTile) {
    return _expansionTile(
      context,
      _ThisPageTexts.petType,
      [
        dogRadioListTile,
        catradioListTile,
        rabbitRadioListTile,
        fishRadioListTile,
        otherRadioListTile,
      ],
    );
  }

  ExpansionTile _ageRangeExpansionTile(
      BuildContext context,
      RadioListTile<dynamic> zeroThreeMonthsRadioListTile,
      RadioListTile<dynamic> threeSixMonthsRadioListTile,
      RadioListTile<dynamic> sixMonthsOneYearRadioListTile,
      RadioListTile<dynamic> oneThreeYearsRadioListTile,
      RadioListTile<dynamic> moreThanThreeYearsRadioListTile) {
    return _expansionTile(
      context,
      _ThisPageTexts.petAgeRange,
      [
        zeroThreeMonthsRadioListTile,
        threeSixMonthsRadioListTile,
        sixMonthsOneYearRadioListTile,
        oneThreeYearsRadioListTile,
        moreThanThreeYearsRadioListTile,
      ],
    );
  }

  ExpansionTile _genderExpansionTile(
      BuildContext context, RadioListTile<dynamic> maleRadioListTile, RadioListTile<dynamic> femaleRadioListTile) {
    return _expansionTile(
      context,
      _ThisPageTexts.petGender,
      [
        maleRadioListTile,
        femaleRadioListTile,
      ],
    );
  }

  ExpansionTile _expansionTile(context, String title, List<Widget> children) {
    return ExpansionTile(
      title: Text(
        title.tr(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
      ),
      children: children,
    );
  }

  RadioListTile _ageRangeRadioListTile(int radioNumber, String title, context) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
      contentPadding: EdgeInsets.zero,
      groupValue: val2,
      value: radioNumber,
      selected: val2 == radioNumber,
      onChanged: (value) {
        setState(() {
          val2 = value;
          isThereAFilter = true;
          selectedAgeRangeFilter = title;
        });
      },
      title: Text(title, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20)),
    );
  }

  RadioListTile _typeRadioListTile(int radioNumber, String title, context) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
      contentPadding: EdgeInsets.zero,
      groupValue: val1,
      value: radioNumber,
      selected: val1 == radioNumber,
      onChanged: (value) {
        setState(() {
          val1 = value;
          isThereAFilter = true;
          selectedTypeFilter = title;
        });
      },
      title: Text(title, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20)),
    );
  }

  RadioListTile _genderRadioListTile(int radioNumber, String title, context) {
    return RadioListTile(
      shape: RoundedRectangleBorder(
        borderRadius: ProjectRadius.buttonAllRadius,
      ),
      contentPadding: EdgeInsets.zero,
      groupValue: val3,
      value: radioNumber,
      selected: val3 == radioNumber,
      onChanged: (value) {
        setState(() {
          val3 = value;
          isThereAFilter = true;
          selectedGenderFilter = title;
        });
      },
      title: Text(title, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20)),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: _backSelectApp(context),
      title: Text(_ThisPageTexts.homePage),
      foregroundColor: LightThemeColors.miamiMarmalade,
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: _ThisPageTexts.filter,
            );
          },
        ),
      ],
    );
  }

  StreamBuilder _streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: isThereAFilter
          ? FirebaseFirestore.instance
              .collection(AppFirestoreCollectionNames.petsCollection)
              .where(AppFirestoreFieldNames.petTypeField, isEqualTo: selectedTypeFilter)
              .where(AppFirestoreFieldNames.ageRangeField, isEqualTo: selectedAgeRangeFilter)
              .where(AppFirestoreFieldNames.genderField, isEqualTo: selectedGenderFilter)
              .snapshots()
          : FirebaseFirestore.instance.collection(AppFirestoreCollectionNames.petsCollection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
            return _notPetYet(context);
          }
          return _gridview(snapshot);
        }
        if (snapshot.hasError) {
          return Center(child: Lottie.network(ProjectLottieUrls.errorLottie));
        }

        return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
      },
    );
  }

  Center _notPetYet(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _ThisPageTexts.notPetYet,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Lottie.network(ProjectLottieUrls.emptyLottie),
        ],
      ),
    );
  }

  GridView _gridview(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return GridView.builder(
      padding: ProjectPaddings.horizontalMainPadding,
      itemCount: snapshot.data!.docs.length,
      gridDelegate: _myGridDelegate(),
      itemBuilder: (context, index) {
        return _petWidget(snapshot.data!.docs[index]);
      },
    );
  }

  IconButton _backSelectApp(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SelectAppView()),
          (route) => false,
        );
      },
      icon: const Icon(AppIcons.arrowBackIcon),
    );
  }

  NormalPetWidget _petWidget(document) {
    return NormalPetWidget(
      petModel: _petModel(document),
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
    return PetModel(
      currentUid: document[AppFirestoreFieldNames.currentUidField],
      currentEmail: document[AppFirestoreFieldNames.currentEmailField],
      ilce: document[AppFirestoreFieldNames.ilceField],
      gender: document[AppFirestoreFieldNames.genderField],
      name: document[AppFirestoreFieldNames.nameField],
      description: document[AppFirestoreFieldNames.descriptionField],
      imagePath: document[AppFirestoreFieldNames.imagePathField],
      ageRange: document[AppFirestoreFieldNames.ageRangeField],
      city: document[AppFirestoreFieldNames.cityField],
      petBreed: document[AppFirestoreFieldNames.petBreedField],
      price: document[AppFirestoreFieldNames.priceField],
      petType: document[AppFirestoreFieldNames.petTypeField],
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _myGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisExtent: 200,
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
    );
  }
}

class _ThisPageTexts {
  static String homePage = Localization.homePage;
  static String filterPets = Localization.filterPets;
  static String clear = Localization.clear;
  static String dog = Localization.dog;
  static String cat = Localization.cat;
  static String rabbit = Localization.rabbit;
  static String fish = Localization.fish;
  static String other = Localization.other;
  static String zeroThreeMonths = Localization.zeroThreeMonths;
  static String threeSixMonths = Localization.threeSixMonths;
  static String sixMonthsOneYear = Localization.sixMonthsOneYear;
  static String oneThreeYears = Localization.oneThreeYears;
  static String moreThreeYears = Localization.moreThanThreeYears;
  static String male = Localization.male;
  static String female = Localization.female;
  static String petType = Localization.petType;
  static String petAgeRange = Localization.petAgeRange;
  static String petGender = Localization.petGender;
  static String filter = Localization.filter;
  static String notPetYet = Localization.notPetYet;
}
