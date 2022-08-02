class PetModel {
  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String location;
  final String petBreed;
  final String petType;
  final String price;
  final String sex;
  String id;

  PetModel({
    required this.sex,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ageRange,
    required this.location,
    required this.petBreed,
    required this.price,
    required this.petType,
    this.id = "",
  });
}
