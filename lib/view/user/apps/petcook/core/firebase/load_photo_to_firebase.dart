import "package:cloud_firestore/cloud_firestore.dart";
import "package:image_picker/image_picker.dart";
import "package:patily/core/constants/string_constant/app_firestore_field_names.dart";
import "package:patily/core/constants/string_constant/project_firestore_collection_names.dart";
import "package:patily/view/user/apps/patilla/service/storage_service.dart/storage_crud.dart";
import "package:patily/view/user/apps/petcook/core/models/post_model.dart";

class LoadPostToFirebase {
  static LoadPostToFirebase? _instace;
  static LoadPostToFirebase get instance {
    _instace ??= LoadPostToFirebase._init();
    return _instace!;
  }

  LoadPostToFirebase._init();

  final _firebase = FirebaseFirestore.instance;

  Future<void> loadPhoto(PostModel postModel, XFile image) async {
    var imageURL =
        await StorageCrud().addPhotoToStorage(image, "petcook_images");
    _firebase.collection(AppFirestoreCollectionNames.petCook).add({
      AppFirestoreFieldNames.senderIdField: postModel.senderUserId,
      AppFirestoreFieldNames.currentEmailField: postModel.senderUserEmail,
      AppFirestoreFieldNames.currentNameField: postModel.senderUserName,
      AppFirestoreFieldNames.imagePathField: imageURL,
      AppFirestoreFieldNames.descriptionField: postModel.description,
      AppFirestoreFieldNames.dateField: DateTime.now(),
    });
  }
}
