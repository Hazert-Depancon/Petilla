import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/widgets/buttons/button.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/feature/auth/service/auth_service.dart';

class DeleteAccountConfirmView extends StatelessWidget {
  const DeleteAccountConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LightThemeColors.red,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hesabınızı Silmek istediğinize emin misiniz?",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: LightThemeColors.red),
              ),
              context.emptySizedHeightBoxLow,
              Text(
                "Bu işlem geri alınamaz ve hesabınıza dair olan bütün veriler silinir.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              context.emptySizedWidthBoxLow,
              Align(
                child: Button(
                  onPressed: () {
                    AuthService().deleteUser(context);
                  },
                  text: "Hesabı Sil",
                  color: LightThemeColors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
