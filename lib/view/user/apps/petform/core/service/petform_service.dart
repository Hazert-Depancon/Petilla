import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/answer_form_model.dart';
import 'package:petilla_app_project/view/user/apps/petform/core/models/question_form_model.dart';

class PetformService {
  void addQuestionToForm(QuestionFormModel formModel) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection(AppFirestoreCollectionNames.petform).add({
      AppFirestoreFieldNames.animalType: formModel.animalType,
      AppFirestoreFieldNames.createdTimeField: formModel.createdTime,
      AppFirestoreFieldNames.currentEmailField: formModel.currentEmail,
      AppFirestoreFieldNames.currentUidField: formModel.currentUid,
      AppFirestoreFieldNames.currentNameField: formModel.currentUserName,
      AppFirestoreFieldNames.descriptionField: formModel.description,
      AppFirestoreFieldNames.title: formModel.title,
    });
  }

  void reciveQuestion(AnswerFormModel answerFormModel) {
    final firestore = FirebaseFirestore.instance;
    firestore
        .collection(AppFirestoreCollectionNames.petform)
        .doc(answerFormModel.answeredDocId)
        .collection(AppFirestoreCollectionNames.answers)
        .add({
      AppFirestoreFieldNames.answeredDocId: answerFormModel.answeredDocId,
      AppFirestoreFieldNames.createdTimeField: answerFormModel.createdTime,
      AppFirestoreFieldNames.descriptionField: answerFormModel.description,
      AppFirestoreFieldNames.currentNameField: answerFormModel.currentUserName,
      AppFirestoreFieldNames.currentEmailField: answerFormModel.currentEmail,
      AppFirestoreFieldNames.currentUidField: answerFormModel.currentUid,
    });
  }
}
