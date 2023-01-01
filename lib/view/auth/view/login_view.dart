// ignore_for_file: must_be_immutable, iterable_contains_unrelated_type

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
import 'package:petilla_app_project/view/admin/view/admin_home_view.dart';
import 'package:petilla_app_project/view/auth/view/register_view.dart';
import 'package:petilla_app_project/view/auth/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  List<String> adminMails = [
    "DukSrKR6Gxo5KZdYnJZiWeW6",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
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
    if (adminMails.contains(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        _snackBar(),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeView()),
        (route) => false,
      );
    }
    if (_formKey.currentState!.validate()) {
      LoginViewModel().onLoginButton(context, _emailController.text, _passwordController.text);
    }
  }

  SnackBar _snackBar() {
    return const SnackBar(
      content: Text("Admin hesabı ile giriş yapıldı."),
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
}
