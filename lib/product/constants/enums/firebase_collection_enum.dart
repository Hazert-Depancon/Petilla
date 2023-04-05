import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionEnum {
  users,
  messages,
  chats,
  pets,
  reportAnimal,
  reportedInserts,
  petcook,
  patilyForm,
  answers,
  feedBacks,
  animalHelp;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
