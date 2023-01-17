// ignore_for_file: must_be_immutable, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/components/buttons/auth_button.dart';
import 'package:petilla_app_project/core/components/textfields/auth_textfield.dart';
import 'package:petilla_app_project/core/constants/image/image_constants.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/auth/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  String adminMails = "DukSrKR6Gxo5KZdYnJZiWeW6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _loginDecorationImage(),
          const SizedBox(height: 24),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: ProjectPaddings.horizontalLargePadding,
              child: Column(
                children: [
                  _mailTextField,
                  mainSizedBox,
                  _passwordTextField,
                  mainSizedBox,
                  _loginButton(context),
                  mainSizedBox,
                  _dontHaveAnAccount(context),
                  _registerButton(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded _loginDecorationImage() {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.instance.loginBackgroundImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 64, left: 32),
          child: _welcomeBackText(),
        ),
      ),
    );
  }

  Text _welcomeBackText() {
    return Text(
      LocaleKeys.welcomeAgain.locale,
      style: const TextStyle(
        color: LightThemeColors.white,
        fontWeight: FontWeight.w700,
        fontSize: 55,
      ),
    );
  }

  AuthButton _loginButton(BuildContext context) {
    return AuthButton(
      onPressed: () {
        _onLoginButton(context);
      },
      text: _ThisPageTexts.title,
    );
  }

  AuthTextField get _mailTextField {
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

  AuthTextField get _passwordTextField {
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
        LoginViewModel().goRegisterView(context);
      },
      child: Text(_ThisPageTexts.registerText),
    );
  }

  void _onLoginButton(context) async {
    if (adminMails == _emailController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        _snackBar(),
      );
      LoginViewModel().goAdminView(context);
    }
    if (_formKey.currentState!.validate()) {
      LoginViewModel().onLoginButton(context, _emailController.text, _passwordController.text);
    }
  }

  SnackBar _snackBar() {
    return SnackBar(
      content: Text(_ThisPageTexts.signInWithAdmin),
      backgroundColor: LightThemeColors.green,
    );
  }
}

class _ThisPageTexts {
  static String title = LocaleKeys.login.locale;
  static String mailHintText = LocaleKeys.mail.locale;
  static String passwordHintText = LocaleKeys.password.locale;
  static String dontHaveAccount = LocaleKeys.dontHaveAnAccount.locale;
  static String registerText = LocaleKeys.register.locale;
  static String signInWithAdmin = LocaleKeys.signInWithAdmin.locale;
}
