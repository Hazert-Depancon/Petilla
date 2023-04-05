// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/core/base/view/profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

part 'select_app_view_view_model.g.dart';

class SelectAppViewViewModel = _SelectAppViewViewModelBase
    with _$SelectAppViewViewModel;

abstract class _SelectAppViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callProfileView() {
    Navigator.push(viewModelContext,
        MaterialPageRoute(builder: (context) => const ProfileView()));
  }

  @action
  Future<void> instagramLaunch() async {
    var url = 'https://www.instagram.com/patily.turkiye/';

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }
}
