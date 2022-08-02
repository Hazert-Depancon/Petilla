import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/view/auth_view/register_view.dart';
import 'package:petilla_app_project/view/theme/light_theme_colors.dart';
import 'package:petilla_app_project/view/theme/sizes/project_button_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_card_sizes.dart';
import 'package:petilla_app_project/view/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/view/theme/strings/project_lottie_urls.dart';
import 'package:petilla_app_project/view/widgets/button.dart';
import 'package:petilla_app_project/view/widgets/textfields/auth_textfield.dart';

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
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: Get.height * 0.9,
              child: Padding(
                padding: ProjectPaddings.horizontalLargePadding,
                child: Column(
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
                    const Spacer(),
                    _loginButton(context),
                    const SizedBox(height: 24),
                    _dontHaveAnAccount(context),
                    _registerButton(),
                  ],
                ),
              ),
            ),
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
      onPressed: () {},
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
