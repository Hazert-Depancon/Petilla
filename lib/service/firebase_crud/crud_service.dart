import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petilla_app_project/service/models/pet_model.dart';

class CrudService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future writePet({required String name}) async {
  //   final docPet = _firestore.collection("pets").doc();

  //   final pet = PetModel(
  //     sex: "",
  //     id: docPet.id,
  //     name: name,
  //     description: "description",
  //     imagePath: "imagePath",
  //     ageRange: "ageRange",
  //     location: "location",
  //     petBreed: "petBreed",
  //     price: "150",
  //     petType: "petType",
  //   );

  //   final json = pet.toJson();

  //   await docPet.set(json);
  // }

  Future createPet(PetModel pet) async {
    final docPet = FirebaseFirestore.instance.collection("pets").doc();
    pet.id = docPet.id;

    final json = pet.toJson();
    await docPet.set(json);
  }
}
