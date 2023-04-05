import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:patily/core/base/model/base_viewmodel.dart';
import 'package:patily/feature/our/service/feedback_service.dart';

part 'feedback_view_view_model.g.dart';

// ignore: library_private_types_in_public_api
class FeedBackViewViewModel = _FeedBackViewViewModelBase
    with _$FeedBackViewViewModel;

abstract class _FeedBackViewViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  Future<void> onSubmitButton(
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) async {
    FeedBackService().onSubmitButton(titleController, descriptionController);
  }
}
