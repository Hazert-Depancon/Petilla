import 'package:hive/hive.dart';

class PetModel extends HiveObject {
  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String city;
  final String ilce;
  final String petBreed;
  final String petType;
  final String price;
  final String sex;
  bool isFav;

  PetModel({
    this.isFav = false,
    required this.ilce,
    required this.sex,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ageRange,
    required this.city,
    required this.petBreed,
    required this.price,
    required this.petType,
  });
}
