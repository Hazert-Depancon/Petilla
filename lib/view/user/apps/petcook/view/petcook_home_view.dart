import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/core/base/view/base_view.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/apps/petcook/view/add_post_view.dart';
import 'package:petilla_app_project/view/user/apps/petcook/viewmodel/petcook_home_view_view_model.dart';
import 'package:petilla_app_project/view/user/start/view/select_app_view.dart';

class PetcookHomeView extends StatefulWidget {
  const PetcookHomeView({super.key});

  @override
  State<PetcookHomeView> createState() => _PetcookHomeViewState();
}

class _PetcookHomeViewState extends State<PetcookHomeView> {
  final smallWidthSizedBox = AppSizedBoxs.smallWidthSizedBox;

  late PetcookHomeViewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<PetcookHomeViewViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: PetcookHomeViewViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      // body: StreamBuilder<QuerySnapshot>(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemBuilder: (context, index) {},
      //       );
      //     }
      //   },
      // ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: _backIcon(context),
      title: Text(
        "Anasayfa",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        _addPostButton(),
        smallWidthSizedBox,
        _profileButton(),
        smallWidthSizedBox,
      ],
    );
  }

  GestureDetector _backIcon(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SelectAppView()),
          (route) => false,
        );
      },
      child: const Icon(
        AppIcons.arrowBackIcon,
        color: LightThemeColors.black,
      ),
    );
  }

  GestureDetector _profileButton() {
    return GestureDetector(
      child: SvgPicture.asset(
        ImageConstants.instance.profile,
        height: 24,
      ),
    );
  }

  GestureDetector _addPostButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddPostView(),
          ),
        );
      },
      child: SvgPicture.asset(
        ImageConstants.instance.add,
        height: 24,
      ),
    );
  }
}
