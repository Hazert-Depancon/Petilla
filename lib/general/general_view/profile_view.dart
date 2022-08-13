import 'package:flutter/material.dart';
import 'package:petilla_app_project/auth/auth_service/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().logout(context);
            },
            child: const Icon(Icons.exit_to_app),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
