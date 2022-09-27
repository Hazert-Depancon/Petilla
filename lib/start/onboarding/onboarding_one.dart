// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petilla_app_project/auth/auth_view/login_view.dart';
import 'package:petilla_app_project/constant/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _bottomSheet(),
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          controller: controller,
          children: [
            _pageOne(context),
            _pageTwo(context),
            _pageThree(context),
          ],
        ),
      ),
    );
  }

  // BottomSheet
  _bottomSheet() {
    return isLastPage
        ? _getStartedButton()
        : Container(
            color: LightThemeColors.scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _backButton(),
                Center(
                  child: _indicator(),
                ),
                _nextButton(),
              ],
            ),
          );
  }

  TextButton _getStartedButton() {
    return TextButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("showHome", true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: LightThemeColors.miamiMarmalade,
        minimumSize: const Size.fromHeight(80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: const Text("Başla"),
    );
  }

  // Next button
  TextButton _nextButton() {
    return TextButton(
      onPressed: () => controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
      child: const Text("Devam"),
    );
  }

  // Indicator
  SmoothPageIndicator _indicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: const WormEffect(
        dotColor: Colors.grey,
        activeDotColor: LightThemeColors.miamiMarmalade,
        dotWidth: 15,
        dotHeight: 15,
        spacing: 16,
      ),
      onDotClicked: _onDotClicked,
    );
  }

  void _onDotClicked(index) => controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );

  // Back button
  TextButton _backButton() {
    return TextButton(
      onPressed: () => controller.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
      child: const Text("Geri", style: TextStyle(color: LightThemeColors.miamiMarmalade)),
    );
  }

  // Page 1
  Padding _pageOne(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_svgPicOne(context), const SizedBox(height: 24), _textOne(context)],
      ),
    );
  }

  Text _textOne(BuildContext context) {
    return Text(
      _ThisPageTexts.msg1,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  SvgPicture _svgPicOne(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/onboarding_one.svg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.35,
    );
  }

  // Page 2
  Padding _pageTwo(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_svgPicTwo(context), const SizedBox(height: 24), _textTwo(context)],
      ),
    );
  }

  Text _textTwo(BuildContext context) {
    return Text(
      _ThisPageTexts.msg2,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  SvgPicture _svgPicTwo(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/onboarding_two.svg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.35,
    );
  }

  // Page 3
  Padding _pageThree(BuildContext context) {
    return Padding(
      padding: ProjectPaddings.horizontalLargePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _svgPicThree(context),
          const SizedBox(height: 24),
          _textThree(context),
        ],
      ),
    );
  }

  Text _textThree(BuildContext context) {
    return Text(
      _ThisPageTexts.msg3,
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  SvgPicture _svgPicThree(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/onboarding_three.svg',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.35,
    );
  }
}

class _ThisPageTexts {
  static const msg1 =
      "Evcil hayvnalarını sahiplendir veya satarak gelir oluştur. Kaybolan evcil hayvanlarını bul. Onların ihtiyaçlarını sağla.";

  static const msg2 = "Evcil hayvanının sorunları için başka evcil hayvan sahipleriyle iletişime geçin!";

  static const msg3 = "Evcil hayvanlarınızın tatlı ve komik anlarını diğer insanlarla paylaşın!";
}
