// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:petilla_app_project/core/components/buttons/auth_button.dart';
import 'package:petilla_app_project/core/components/textfields/auth_textfield.dart';
import 'package:petilla_app_project/core/constants/other_constant/icon_names.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/app_sized_box.dart';
import 'package:petilla_app_project/core/constants/sizes_constant/project_padding.dart';
import 'package:petilla_app_project/core/extension/string_lang_extension.dart';
import 'package:petilla_app_project/core/init/lang/locale_keys.g.dart';
import 'package:petilla_app_project/core/init/theme/light_theme/light_theme_colors.dart';
import 'package:petilla_app_project/core/gen/assets.gen.dart';
import 'package:petilla_app_project/view/auth/view/login_view.dart';
import 'package:petilla_app_project/view/auth/viewmodel/register_view_model.dart';

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
      resizeToAvoidBottomInset: false,
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
          child: _welcomeText(),
        ),
      ),
    );
  }

  Text _welcomeText() {
    return Text(
      LocaleKeys.auth_welcome.locale,
      style: const TextStyle(
        color: LightThemeColors.white,
        fontWeight: FontWeight.w700,
        fontSize: 55,
      ),
    );
  }

  AuthTextField _passwordTextField() {
    return AuthTextField(
      true,
      controller: _passwordController,
      hintText: _ThisPageTexts.passwordHint,
      isNext: false,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: AppIcons.lockOutlinedIcon,
    );
  }

  AuthTextField _emailTextField() {
    return AuthTextField(
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHint,
      isNext: true,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: AppIcons.emailOutlinedIcon,
    );
  }

  AuthTextField _nameTextField() {
    return AuthTextField(
      false,
      controller: _nameController,
      hintText: _ThisPageTexts.nameHint,
      isNext: true,
      keyboardType: TextInputType.name,
      prefixIcon: AppIcons.personOutlineIcon,
    );
  }

  AuthButton _registerButton(context) {
    return AuthButton(
      onPressed: () {
        _onRegister(context);
      },
      text: _ThisPageTexts.register,
    );
  }

  void _onRegister(context) {
    if (_formKey.currentState!.validate()) {
      RegisterViewModel().onRegisterButton(_emailController.text,
          _passwordController.text, _nameController.text, context);
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      },
      child: Text(
        _ThisPageTexts.logIn,
      ),
    );
  }
}

class _ThisPageTexts {
  static String nameHint = LocaleKeys.name.locale;
  static String mailHint = LocaleKeys.auth_mail.locale;
  static String passwordHint = LocaleKeys.auth_password.locale;
  static String alreadyHaveAnAccount =
      LocaleKeys.auth_already_have_an_account.locale;
  static String logIn = LocaleKeys.auth_login.locale;
  static String register = LocaleKeys.auth_register.locale;
}
