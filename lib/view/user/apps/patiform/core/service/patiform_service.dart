import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patily/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:patily/view/user/apps/patiform/core/models/answer_form_model.dart';
import 'package:patily/view/user/apps/patiform/core/models/question_form_model.dart';

class PatiformService {
  void addQuestionToForm(QuestionFormModel formModel) {
    final firestore = FirebaseFirestore.instance;
    firestore.collection(AppFirestoreCollectionNames.patiform).add({
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
        .collection(AppFirestoreCollectionNames.patiform)
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
