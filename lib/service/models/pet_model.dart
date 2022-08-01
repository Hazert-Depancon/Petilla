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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imagePath": imagePath,
        "ageRange": ageRange,
        "location": location,
        "petBreed": petBreed,
        "price": price,
        "petType": petType,
      };

  static PetModel fromJson(Map<String, dynamic> json) => PetModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imagePath: json["imagePath"],
        ageRange: json["ageRange"],
        location: json["location"],
        petBreed: json["petBreed"],
        price: json["price"],
        petType: json["petType"],
        sex: json["sex"],
      );
}
