import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petilla_app_project/service/models/pet_model.dart';

class CrudService {
  Future<void> createPet(PetModel pet) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return db.collection('pets').add({
      "name": pet.name,
      "description": pet.description,
      "imagePath": pet.imagePath,
      "ageRange": pet.ageRange,
      "city": pet.city,
      "ilce": pet.ilce,
      "petBreed": pet.petBreed,
      "petType": pet.petType,
      "sex": pet.sex,
      "price": pet.price,
    });
  }
}
