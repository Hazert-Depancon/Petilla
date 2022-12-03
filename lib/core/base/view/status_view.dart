import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:petilla_app_project/core/constants/enums/status_keys_enum.dart';
import 'package:petilla_app_project/core/constants/string_constant/project_lottie_urls.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key, required this.status});
  final StatusKeysEnum status;

  lottie() {
    switch (status) {
      case StatusKeysEnum.CONNECTION_ERROR:
        return ProjectLottieUrls.connectionErrorLottie;
      case StatusKeysEnum.EMPTY:
        return ProjectLottieUrls.emptyLottie;
      case StatusKeysEnum.ERROR:
        return ProjectLottieUrls.errorLottie;
      case StatusKeysEnum.LOADING:
        return ProjectLottieUrls.loadingLottie;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(lottie(), width: 300, height: 300),
    );
  }
}
