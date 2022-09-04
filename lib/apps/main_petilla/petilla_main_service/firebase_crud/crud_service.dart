// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class CrudService {
  _showDialog(context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
          child: Lottie.network(ProjectLottieUrls.loadingLottie),
        );
      },
    );
  }

  Future createPet(PetModel pet, context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    _showDialog(context);
    try {
      await db.collection('pets').add({
        "name": pet.name,
        "description": pet.description,
        "imagePath": pet.imagePath,
        "ageRange": pet.ageRange,
        "city": pet.city,
        "ilce": pet.ilce,
        "petBreed": pet.petBreed,
        "petType": pet.petType,
        "gender": pet.gender,
        "price": pet.price,
        "currentUid": pet.currentUid,
        "currentEmail": pet.currentEmail,
      });
    } catch (e) {
      print(e);
    }
  }
}
