import "package:image_picker/image_picker.dart";
import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/models/patily_media/post_model.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/feature/patily_sahiplen/service/storage_service.dart/storage_crud.dart';

class LoadPostToFirebase {
  static LoadPostToFirebase? _instace;
  static LoadPostToFirebase get instance {
    _instace ??= LoadPostToFirebase._init();
    return _instace!;
  }

  LoadPostToFirebase._init();

  Future<void> loadPhoto(PostModel postModel, XFile image) async {
    var imageURL =
        await StorageCrud().addPhotoToStorage(image, "petcook_images");
    FirebaseCollectionEnum.petcook.reference.add({
      AppFirestoreFieldNames.senderIdField: postModel.senderUserId,
      AppFirestoreFieldNames.currentEmailField: postModel.senderUserEmail,
      AppFirestoreFieldNames.currentNameField: postModel.senderUserName,
      AppFirestoreFieldNames.imagePathField: imageURL,
      AppFirestoreFieldNames.descriptionField: postModel.description,
      AppFirestoreFieldNames.dateField: DateTime.now(),
    });
  }
}
