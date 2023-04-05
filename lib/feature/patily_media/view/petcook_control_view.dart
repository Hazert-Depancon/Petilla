import 'package:flutter/material.dart';
import 'package:patily/feature/patily_media/view/petcook_home_view.dart';

class PetCookControlView extends StatefulWidget {
  const PetCookControlView({super.key});

  @override
  State<PetCookControlView> createState() => _PetCookControlViewState();
}

class _PetCookControlViewState extends State<PetCookControlView> {
  @override
  Widget build(BuildContext context) {
    return PetcookHomeView();
  }
}
