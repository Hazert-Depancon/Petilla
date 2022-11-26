// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/core/components/button.dart';
import 'package:petilla_app_project/core/components/textfields/auth_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_button_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_card_sizes.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_lottie_urls.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/user/auth/view/login_view.dart';
import 'package:petilla_app_project/view/user/auth/viewmodel/register_view_model.dart';

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
  static String nameHint = LocaleKeys.name.locale;
  static String mailHint = LocaleKeys.mail.locale;
  static String passwordHint = LocaleKeys.password.locale;
  static String alreadyHaveAnAccount = LocaleKeys.alreadyHaveAnAccount.locale;
  static String logIn = LocaleKeys.login.locale;
  static String register = LocaleKeys.register.locale;
}
