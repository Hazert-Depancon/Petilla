// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_view/login_view/login_view.dart';
import 'package:petilla_app_project/auth/auth_view/register_view/register_view_model.dart';
import 'package:petilla_app_project/constant/localization/localization.dart';
import 'package:petilla_app_project/constant/other_constant/icon_names.dart';
import 'package:petilla_app_project/constant/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_card_sizes.dart';
import 'package:petilla_app_project/constant/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/constant/strings_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/auth_textfield.dart';
import 'package:petilla_app_project/theme/light_theme/light_theme_colors.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
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
            _nameTextField(),
            mainSizedBox,
            _emailTextField(),
            mainSizedBox,
            _passwordTextField(),
            mainSizedBox,
            _registerButton(context),
            mainSizedBox,
            _alreadyHaveAnAccount(context),
            _logInButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(_ThisPageTexts.register),
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  LottieBuilder _lottie() {
    return Lottie.network(
      ProjectLottieUrls.registerLottie,
      width: ProjectCardSizes.bigLottieWidth,
      height: ProjectCardSizes.bigLottieHeight,
    );
  }

  AuthTextField _passwordTextField() {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHint,
      isNext: false,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(AppIcons.lockOutlinedIcon, color: LightThemeColors.cherrywoord),
    );
  }

  AuthTextField _emailTextField() {
    return AuthTextField(
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHint,
      isNext: true,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(AppIcons.emailOutlinedIcon, color: LightThemeColors.cherrywoord),
    );
  }

  AuthTextField _nameTextField() {
    return AuthTextField(
      false,
      controller: _nameController,
      hintText: _ThisPageTexts.nameHint,
      isNext: true,
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(AppIcons.personOutlineIcon, color: LightThemeColors.cherrywoord),
    );
  }

  Button _registerButton(context) {
    return Button(
      onPressed: () {
        _onRegister(context);
      },
      width: ProjectButtonSizes.mainButtonWidth,
      height: ProjectButtonSizes.mainButtonHeight,
      text: _ThisPageTexts.register,
    );
  }

  void _onRegister(context) {
    if (_formKey.currentState!.validate()) {
      RegisterViewModel()
          .onRegisterButton(_emailController.text, _passwordController.text, _nameController.text, context);
    }
  }

  Text _alreadyHaveAnAccount(context) {
    return Text(
      _ThisPageTexts.alreadyHaveAnAccount,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  TextButton _logInButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
      },
      child: Text(
        _ThisPageTexts.logIn,
      ),
    );
  }
}

class _ThisPageTexts {
  static String nameHint = Localization.name;
  static String mailHint = Localization.mail;
  static String passwordHint = Localization.password;
  static String alreadyHaveAnAccount = Localization.alreadyHaveAnAccount;
  static String logIn = Localization.login;
  static String register = Localization.register;
}
