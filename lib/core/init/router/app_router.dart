// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petilla_app_project/core/base/view/profile_view.dart';
import 'package:petilla_app_project/core/constants/app/router_contants.dart';
import 'package:petilla_app_project/core/constants/enums/locale_keys_enum.dart';
import 'package:petilla_app_project/view/user/auth/onboard/view/onboarding.dart';
import 'package:petilla_app_project/view/user/auth/view/login_view.dart';
import 'package:petilla_app_project/view/user/start/view/select_app_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouterConstants.onboarding,
        path: "/",
        pageBuilder: (context, state) {
          return const MaterialPage(child: Onboarding());
        },
      ),
      GoRoute(
        name: RouterConstants.login,
        path: "/login",
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginView());
        },
      ),
      GoRoute(
        name: RouterConstants.selectApp,
        path: "/selectApp",
        pageBuilder: (context, state) {
          return MaterialPage(child: SelectAppView());
        },
      ),
      GoRoute(
        name: RouterConstants.profile,
        path: "/selectApp",
        pageBuilder: (context, state) {
          return MaterialPage(child: ProfileView());
        },
      ),
      // GoRoute(
      //   name: RouterConstants.reportedPetDetail,
      //   path: "/reportedPetDetail",
      //   pageBuilder: (context, state) {
      //     return MaterialPage(child: R);
      //   },
      // ),
    ],
    redirect: (context, state) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool showHome = preferences.getBool(SharedKeys.SHOWHOME.toString()) ?? false;
      if (showHome) {
        if (FirebaseAuth.instance.currentUser != null) {
          return state.namedLocation(RouterConstants.selectApp);
        } else {
          return state.namedLocation(RouterConstants.login);
        }
      }
      return state.namedLocation(RouterConstants.onboarding);
    },
  );
}
