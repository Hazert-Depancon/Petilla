import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/question_form_model.dart';

class PetformService {
  void addQuestionToForm(
    String docId,
    QuestionFormModel formModel,
  ) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection(AppFirestoreCollectionNames.petform).doc(docId).set({
      AppFirestoreFieldNames.animalType: formModel.animalType,
      AppFirestoreFieldNames.createdTimeField: formModel.createdTime,
      AppFirestoreFieldNames.currentEmailField: formModel.currentEmail,
      AppFirestoreFieldNames.currentUidField: formModel.currentUid,
      AppFirestoreFieldNames.currentNameField: formModel.currentUserName,
      AppFirestoreFieldNames.descriptionField: formModel.description,
      AppFirestoreFieldNames.title: formModel.title,
    });
  }
}
