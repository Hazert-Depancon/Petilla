import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/auth/auth_view/register_view.dart';
import 'package:petilla_app_project/general/general_widgets/button.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/auth_textfield.dart';
import 'package:petilla_app_project/main.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/theme/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_ThisPageTexts.title),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: ProjectPaddings.horizontalLargePadding,
            children: [
              Column(
                children: [
                  Lottie.network(
                    ProjectLottieUrls.loginLottie,
                    height: ProjectCardSizes.bigLottieHeight,
                    width: ProjectCardSizes.bigLottieWidth,
                  ),
                  _mailTextField(),
                  const SizedBox(height: 24),
                  _passwordTextField(),
                  _forgotPassword(),
                  const SizedBox(height: 24),
                  _loginButton(context),
                  const SizedBox(height: 24),
                  _dontHaveAnAccount(context),
                  _registerButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AuthTextField _mailTextField() {
    return AuthTextField(
      isNext: true,
      false,
      controller: _emailController,
      hintText: _ThisPageTexts.mailHintText,
      prefixIcon: const Icon(
        Icons.mail_outlined,
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
        Icons.lock_outline,
        color: LightThemeColors.cherrywoord,
      ),
      keyboardType: TextInputType.visiblePassword,
      isNext: false,
    );
  }

  Button _loginButton(BuildContext context) {
    return Button(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          AuthService().login(_emailController.text.trim(), _passwordController.text.trim(), context).whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Petilla(showHome: true),
                  ),
                ),
              );
        } else {
          return;
        }
      },
      width: ProjectButtonSizes.mainButtonWidth,
      height: ProjectButtonSizes.mainButtonHeight,
      text: _ThisPageTexts.title,
    );
  }

  Text _dontHaveAnAccount(BuildContext context) {
    return Text(
      _ThisPageTexts.dontHaveAccount,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  TextButton _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
          (route) => false,
        );
      },
      child: const Text(_ThisPageTexts.registerText),
    );
  }

  TextButton _forgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(_ThisPageTexts.forgotPasswordText),
    );
  }
}

class _ThisPageTexts {
  static const String title = "Giriş Yap";
  static const String mailHintText = "E-posta";
  static const String passwordHintText = "Şifre";
  static const String forgotPasswordText = "Şifremi Unuttum";
  static const String dontHaveAccount = "Hesabınız yok mu?";
  static const String registerText = "Kayıt Ol";
}
