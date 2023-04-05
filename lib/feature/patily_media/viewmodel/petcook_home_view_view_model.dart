// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/patily_media/view/add_post_view.dart';

part 'petcook_home_view_view_model.g.dart';

class PetcookHomeViewViewModel = _PetcookHomeViewViewModelBase
    with _$PetcookHomeViewViewModel;

abstract class _PetcookHomeViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callAddPhotoView() {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => const AddPostView(),
      ),
    );
  }
}
