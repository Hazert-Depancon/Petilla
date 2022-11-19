import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/main_petilla.dart';
import 'package:petilla_app_project/apps/main_petilla/service/firebase_crud/crud_service.dart';
import 'package:petilla_app_project/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/core/components/dialogs/default_dialog.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';

class AddViewTwoViewModel {
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
