// ignore_for_file: must_be_immutable, iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/core/base/view/base_view.dart';
import 'package:patily/feature/auth/viewmodel/login_view_model.dart';
import 'package:patily/product/constants/enums/auht_textfield_enum.dart';
import 'package:patily/product/widgets/buttons/auth_button.dart';
import 'package:patily/product/widgets/textfields/auth_textfield.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/extension/string_lang_extension.dart';
import 'package:patily/product/init/lang/locale_keys.g.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/core/gen/assets.gen.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: LoginViewModel(),
      onPageBuilder: (context, value) => Scaffold(
        body: _body(context),
      ),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _loginDecorationImage(),
            const SizedBox(height: 24),
            Padding(
              padding: context.horizontalPaddingNormal,
              child: Column(
                children: [
                  _mailTextField,
                  context.emptySizedHeightBoxLow3x,
                  _passwordTextField,
                  context.emptySizedHeightBoxLow3x,
                  _loginButton(context),
                  context.emptySizedHeightBoxLow3x,
                  _dontHaveAnAccount(context),
                  _registerButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _loginDecorationImage() {
    return Container(
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
      textfieldType: AuthTextfieldEnum.mail,
      isNext: true,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHintText,
      prefixIcon: AppIcons.emailOutlinedIcon,
      keyboardType: TextInputType.emailAddress,
    );
  }

  AuthTextField get _passwordTextField {
    return AuthTextField(
      textfieldType: AuthTextfieldEnum.password,
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
        viewModel.callRegisterView(context);
      },
      child: Text(
        _ThisPageTexts.registerText,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
      ),
    );
  }

  void _onLoginButton(context) async {
    if (_formKey.currentState!.validate()) {
      viewModel.onLoginButton(
        context,
        _emailController.text,
        _passwordController.text,
      );
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
