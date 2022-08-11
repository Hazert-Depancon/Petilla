import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/main_petilla/service/auth_service/auth_service.dart';
import 'package:petilla_app_project/main_petilla/view/auth_view/login_view.dart';
import 'package:petilla_app_project/main_petilla/view/widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    AuthService().getUserData(context);
  }

  TextEditingController name = TextEditingController(text: AuthService.name);
  TextEditingController email = TextEditingController(text: AuthService.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _exitButton(context),
          const SizedBox(
            width: 4,
          )
        ],
      ),
      body: FutureBuilder(
        future: AuthService().getUserData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: _loadingLottie());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Hata oluştu'));
          }
          return Center(
            child: ListView(
              padding: ProjectPaddings.horizontalMainPadding,
              children: [
                _circleAvatar(context),
                const SizedBox(height: 16),
                _name(),
                const SizedBox(height: 16),
                _mail(),
                const SizedBox(height: 16),
                _phone(),
              ],
            ),
          );
        },
      ),
    );
  }

  LottieBuilder _loadingLottie() {
    return Lottie.network(ProjectLottieUrls.loadingLottie);
  }

  IconButton _exitButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        AuthService().logout(context).whenComplete(
              () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                (Route route) => false,
              ),
            );
      },
    );
  }

  Container _circleAvatar(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
        color: Colors.orange[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: _nameFirst(context),
      ),
    );
  }

  Text _nameFirst(BuildContext context) {
    return Text(name.text[0], style: Theme.of(context).textTheme.headline5);
  }

  MainTextField _phone() {
    return const MainTextField(
      enabled: false,
      hintText: "Telefon numarası ekle",
      prefixIcon: Icon(Icons.phone),
    );
  }

  MainTextField _mail() {
    return MainTextField(
      enabled: false,
      controller: email,
      prefixIcon: const Icon(Icons.mail_outline),
    );
  }

  MainTextField _name() {
    return MainTextField(
      enabled: false,
      controller: name,
      prefixIcon: const Icon(Icons.person_outline),
    );
  }
}
