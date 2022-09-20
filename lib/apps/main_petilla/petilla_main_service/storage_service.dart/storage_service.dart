// ignore_for_file: unused_element

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  addPhotoToStorage(XFile image, String imageURL) async {
    Reference ref = FirebaseStorage.instance.ref("pets").child(image.name);

    await ref.putFile(File(image.path));
    await ref.getDownloadURL().then((value) {
      imageURL = value;
    });
  }
}
