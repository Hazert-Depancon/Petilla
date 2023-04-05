import 'package:geolocator/geolocator.dart';
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/models/patily_help/patily_help_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PatilyHelpService {
  Future<void> showInMap(HelpMeModel helpMeModel) async {
    String googleURL =
        "https://www.google.com/maps/search/?api=1&query=${helpMeModel.lat},${helpMeModel.long}";
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw "ERROR";
  }

  Future<void> loadFirestore(HelpMeModel helpMeModel) async {
    FirebaseCollectionEnum.animalHelp.reference.add({
      AppFirestoreFieldNames.title: helpMeModel.title.trim(),
      AppFirestoreFieldNames.descriptionField: helpMeModel.description.trim(),
      AppFirestoreFieldNames.isFoodHelp: helpMeModel.isFoodHelp,
      AppFirestoreFieldNames.isVetHelp: helpMeModel.isVetHelp,
      AppFirestoreFieldNames.lat: helpMeModel.lat,
      AppFirestoreFieldNames.long: helpMeModel.long,
      AppFirestoreFieldNames.imagePathField: helpMeModel.imageDowlandUrl,
      AppFirestoreFieldNames.otherNeeds: helpMeModel.otherNeeds,
      AppFirestoreFieldNames.currentEmailField: helpMeModel.currentUserEmail,
      AppFirestoreFieldNames.uidField: helpMeModel.currentUserId,
      AppFirestoreFieldNames.nameField: helpMeModel.currentUserName,
    });
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("ERROR");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("ERROR");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("ERROR");
    }
    return await Geolocator.getCurrentPosition();
  }
}
