import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';
import 'package:petilla_app_project/general/general_widgets/textfields/main_textfield.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:petilla_app_project/theme/strings/project_lottie_urls.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
        title: const Text('Profile'),
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().logout(context);
            },
            child: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: ProjectPaddings.horizontalMainPadding,
              children: [
                CircleAvatar(
                  radius: 60,
                  child: Center(
                    child: Text(
                      snapshot.data!['name'].toString().substring(0, 1),
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                MainTextField(
                  enabled: false,
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: snapshot.data!["name"],
                ),
                const SizedBox(height: 12),
                MainTextField(
                  enabled: false,
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: snapshot.data!["email"],
                ),
              ],
            );
          } else {
            return Center(child: Lottie.network(ProjectLottieUrls.loadingLottie));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}
