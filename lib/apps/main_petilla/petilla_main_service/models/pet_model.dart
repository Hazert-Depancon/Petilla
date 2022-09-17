class PetModel {
  final String name;
  final String description;
  final String imagePath;
  final String ageRange;
  final String city;
  final String ilce;
  final String petBreed;
  final String petType;
  final String price;
  final String gender;
  final String currentEmail;
  final String currentUid;

  PetModel({
    required this.currentUid,
    required this.currentEmail,
    required this.ilce,
    required this.gender,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.ageRange,
    required this.city,
    required this.petBreed,
    required this.price,
    required this.petType,
  });
  Map<String, dynamic> toJson() => {
        "currentUid": currentUid,
        "currentEmail": currentEmail,
        "ilce": ilce,
        "gender": gender,
        "name": name,
        "description": description,
        "imagePath": imagePath,
        "ageRange": ageRange,
        "city": city,
        "petBreed": petBreed,
        "price": price,
        "petType": petType,
      };
}
