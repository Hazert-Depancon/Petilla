import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/base/view/status_view.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_radius.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/core/base/state/base_state.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/core/components/pet_widgets/normal_pet_widget.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/view/user/start/view/select_app_view.dart';

class PetillaHomeView extends StatefulWidget {
  const PetillaHomeView({Key? key}) : super(key: key);

  @override
  State<PetillaHomeView> createState() => _PetillaHomeViewState();
}

class _PetillaHomeViewState extends BaseState<PetillaHomeView> {
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
      style: textTheme.titleLarge!.copyWith(
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
        title,
        style: textTheme.titleLarge!.copyWith(fontSize: 18),
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
      title: Text(title, style: textTheme.bodyText2!.copyWith(fontSize: 20)),
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
      title: Text(title, style: textTheme.bodyText2!.copyWith(fontSize: 20)),
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
      title: Text(title, style: textTheme.bodyText2!.copyWith(fontSize: 20)),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: _backSelectApp(context),
      title: Text(_ThisPageTexts.homePage),
      foregroundColor: LightThemeColors.miamiMarmalade,
      actions: [
        _filterButton(),
        AppSizedBoxs.normalWidthSizedBox,
      ],
    );
  }

  Builder _filterButton() {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: const Icon(
            AppIcons.filterIcon,
          ),
        );
      },
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
          return _errorLottie();
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return _connectionErrorLottie();
        }

        return _loadingLottie();
      },
    );
  }

  _loadingLottie() {
    return const StatusView(status: StatusKeysEnum.LOADING);
  }

  _connectionErrorLottie() {
    return const StatusView(status: StatusKeysEnum.CONNECTION_ERROR);
  }

  _errorLottie() {
    return const StatusView(status: StatusKeysEnum.ERROR);
  }

  _notPetYet(BuildContext context) {
    return const StatusView(status: StatusKeysEnum.EMPTY);
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

  _backSelectApp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectAppView()));
      },
      child: const Icon(
        AppIcons.arrowBackIcon,
      ),
    );
  }

  NormalPetWidget _petWidget(document) {
    return NormalPetWidget(
      petModel: _petModel(document),
      isFav: _petModel(document).currentUid == FirebaseAuth.instance.currentUser!.uid,
    );
  }

  PetModel _petModel(DocumentSnapshot<Object?> document) {
    return PetModel(
      currentUserName: document[AppFirestoreFieldNames.currentNameField],
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
      docId: document.id,
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
  static String homePage = LocaleKeys.homePage.locale;
  static String filterPets = LocaleKeys.filterPets.locale;
  static String clear = LocaleKeys.clear.locale;
  static String dog = LocaleKeys.dog.locale;
  static String cat = LocaleKeys.cat.locale;
  static String rabbit = LocaleKeys.rabbit.locale;
  static String fish = LocaleKeys.fish.locale;
  static String other = LocaleKeys.other.locale;
  static String zeroThreeMonths = LocaleKeys.zeroThreeMonths.locale;
  static String threeSixMonths = LocaleKeys.threeSixMonths.locale;
  static String sixMonthsOneYear = LocaleKeys.sixMonthsOneYear.locale;
  static String oneThreeYears = LocaleKeys.oneThreeYears.locale;
  static String moreThreeYears = LocaleKeys.moreThanThreeYears.locale;
  static String male = LocaleKeys.male.locale;
  static String female = LocaleKeys.female.locale;
  static String petType = LocaleKeys.petType.locale;
  static String petAgeRange = LocaleKeys.petAgeRange.locale;
  static String petGender = LocaleKeys.petGender.locale;
}
