import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petilla_app_project/core/constants/string_constant/app_firestore_field_names.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_firestore_collection_names.dart';
import 'package:petilla_app_project/view/user/apps/main_petilla/service/models/pet_model.dart';

class ReportService {
  static ReportService? _instace;
  static ReportService get instance {
    _instace ??= ReportService._init();
    return _instace!;
  }

  ReportService._init();

  void reportPet(PetModel petModel) async {
    final db = FirebaseFirestore.instance;

    await db.collection(AppFirestoreCollectionNames.reportedInserts).doc(petModel.docId).set({
      AppFirestoreFieldNames.id: petModel.docId,
    });
  }
}
