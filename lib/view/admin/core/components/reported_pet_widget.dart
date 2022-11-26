import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petilla_app_project/view/admin/core/models/reported_pet_model.dart';

class ReportedPetWidget extends StatelessWidget {
  const ReportedPetWidget({super.key, required this.petModel});
  final ReportedPetModel petModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(petModel.lat), double.parse(petModel.long)),
        ),
      ),
    );
  }
}
