import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/constant/assets_build_constant/svg_build_constant.dart';

class MainPetMedia extends StatelessWidget {
  const MainPetMedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(onTap: () {}, child: SvgPicture.asset(svgBuildConstant("home"))),
      ),
    );
  }
}
