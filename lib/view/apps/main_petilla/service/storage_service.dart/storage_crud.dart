import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petilla_app_project/core/utility/asset_utils/compress_utils.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';

class StorageCrud {
  static final StorageCrud _storageService = StorageCrud._internal();
  factory StorageCrud() {
    return _storageService;
  }
  StorageCrud._internal();

  Future addPhotoToStorage(XFile image, String imageUrl) async {
    String imagedowlandUrl = "";
    Reference ref = FirebaseStorage.instance.ref().child(AppFirestoreCollectionNames.petsCollection).child(image.name);

    var sizedImage = await CompressUtils().compressAndGetFile(File(image.path));

    await ref.putFile(sizedImage!).whenComplete(() async {
      return imagedowlandUrl = await ref.getDownloadURL();
    });
    return imagedowlandUrl;
  }
}
