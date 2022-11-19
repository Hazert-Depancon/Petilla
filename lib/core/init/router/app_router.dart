import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/apps/main_petilla/service/models/pet_model.dart';
import 'package:petilla_app_project/apps/main_petilla/view/in_chat_view.dart';
import 'package:petilla_app_project/apps/main_petilla/view/petilla_detail_view.dart';
part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: DetailView, path: "/detail"),
    AutoRoute(page: InChatView, path: "/inChat"),
    AutoRoute(page: Control, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
