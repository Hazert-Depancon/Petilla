import 'package:patily/product/constants/enums/firebase_collection_enum.dart';
import 'package:patily/product/constants/string_constant/app_firestore_field_names.dart';
import 'package:patily/product/models/patily_sahiplen/pet_model.dart';

class ReportService {
  static ReportService? _instace;
  static ReportService get instance {
    _instace ??= ReportService._init();
    return _instace!;
  }

  ReportService._init();

  void reportPet(PetModel petModel) async {
    await FirebaseCollectionEnum.reportedInserts.reference
        .doc(petModel.docId)
        .set({
      AppFirestoreFieldNames.id: petModel.docId,
    });
  }
}
