// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/petilla_main_service/storage_service.dart/storage_crud.dart';
import 'package:petilla_app_project/constant/strings_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/constant/strings_constant/project_firestore_collection_names.dart';

class CrudService {
  static final CrudService _crudService = CrudService._internal();
  factory CrudService() {
    return _crudService;
  }
  CrudService._internal();

  Future<void> createPet(XFile image, String imageUrl, PetModel pet, context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      var dowlandLink = await StorageCrud().addPhotoToStorage(image, imageUrl);
      await db.collection(AppFirestoreCollectionNames.petsCollection).add({
        AppFirestoreFieldNames.nameField: pet.name,
        AppFirestoreFieldNames.descriptionField: pet.description,
        AppFirestoreFieldNames.imagePathField: dowlandLink,
        AppFirestoreFieldNames.ageRangeField: pet.ageRange,
        AppFirestoreFieldNames.cityField: pet.city,
        AppFirestoreFieldNames.ilceField: pet.ilce,
        AppFirestoreFieldNames.petBreedField: pet.petBreed,
        AppFirestoreFieldNames.petTypeField: pet.petType,
        AppFirestoreFieldNames.genderField: pet.gender,
        AppFirestoreFieldNames.priceField: pet.price,
        AppFirestoreFieldNames.currentUidField: pet.currentUid,
        AppFirestoreFieldNames.currentEmailField: pet.currentEmail,
        AppFirestoreFieldNames.currentNameField: pet.currentUserName,
      });
    } catch (e) {
      print(e);
    }
  }
}
