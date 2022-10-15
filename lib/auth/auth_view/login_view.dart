// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/auth/auth_view/register_view.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_card_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/auth_textfield.dart';
import 'package:petilla_app_project/main.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.title),
      centerTitle: true,
    );
  }

  Form _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: ProjectPaddings.horizontalLargePadding,
        child: Column(
          children: [
            _lottie(),
            _mailTextField(),
            mainSizedBox,
            _passwordTextField(),
            mainSizedBox,
            _loginButton(context),
            mainSizedBox,
            _dontHaveAnAccount(context),
            _registerButton(context),
          ],
        ),
      ),
    );
  }

  LottieBuilder _lottie() {
    return Lottie.network(
      ProjectLottieUrls.loginLottie,
      width: ProjectCardSizes.bigLottieWidth,
      height: ProjectCardSizes.bigLottieHeight,
    );
  }

  AuthTextField _mailTextField() {
    return AuthTextField(
      isNext: true,
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHintText,
      prefixIcon: const Icon(
        AppIcons.emailOutlinedIcon,
        color: LightThemeColors.cherrywoord,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  AuthTextField _passwordTextField() {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHintText,
      prefixIcon: const Icon(
        AppIcons.lockOutlinedIcon,
        color: LightThemeColors.cherrywoord,
      ),
      keyboardType: TextInputType.visiblePassword,
      isNext: false,
    );
  }

  Text _dontHaveAnAccount(context) {
    return Text(
      _ThisPageTexts.dontHaveAccount,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  TextButton _registerButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
          (route) => false,
        );
      },
      child: Text(_ThisPageTexts.registerText),
    );
  }

  Button _loginButton(BuildContext context) {
    return Button(
      onPressed: () {
        _onLoginButton(context);
      },
      width: ProjectButtonSizes.mainButtonWidth,
      height: ProjectButtonSizes.mainButtonHeight,
      text: _ThisPageTexts.title,
    );
  }

  void _onLoginButton(context) async {
    if (_formKey.currentState!.validate()) {
      await AuthService()
          .login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            context,
          )
          .then(
            (e) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Petilla(showHome: true),
              ),
            ),
          );
    }
  }
}

class _ThisPageTexts {
  static String title = Localization.login;
  static String mailHintText = Localization.mail;
  static String passwordHintText = Localization.password;
  static String dontHaveAccount = Localization.dontHaveAccount;
  static String registerText = Localization.register;
}
