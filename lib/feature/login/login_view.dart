// ignore_for_file: must_be_immutable, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:patily/product/widgets/buttons/auth_button.dart';
import 'package:patily/product/widgets/textfields/auth_textfield.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/constants/sizes_constant/app_sized_box.dart';
import 'package:patily/product/constants/sizes_constant/project_padding.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';
import 'package:patily/feature/auth/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var mainSizedBox = AppSizedBoxs.mainHeightSizedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Form(
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
            image: AssetImage(Assets.images.loginBackgroundImage.path),
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
      LocaleKeys.auth_welcomeAgain.locale,
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
      prefixIcon: AppIcons.emailOutlinedIcon,
      keyboardType: TextInputType.emailAddress,
    );
  }

  AuthTextField get _passwordTextField {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHintText,
      prefixIcon: AppIcons.lockOutlinedIcon,
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
        LoginViewModel().callRegisterView(context);
      },
      child: Text(_ThisPageTexts.registerText),
    );
  }

  void _onLoginButton(context) async {
    if (_formKey.currentState!.validate()) {
      LoginViewModel().onLoginButton(
          context, _emailController.text, _passwordController.text);
    }
  }
}

class _ThisPageTexts {
  static String title = LocaleKeys.auth_login.locale;
  static String mailHintText = LocaleKeys.auth_mail.locale;
  static String passwordHintText = LocaleKeys.auth_password.locale;
  static String dontHaveAccount = LocaleKeys.auth_dontHaveAccount.locale;
  static String registerText = LocaleKeys.auth_register.locale;
}
