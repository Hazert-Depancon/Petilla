import 'package:flutter/material.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';

class SelectAppWidget extends StatelessWidget {
  const SelectAppWidget({
    Key? key,
    this.isBig = false,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  final bool isBig;
  final String title;
  final String imagePath;
  final Widget onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTap));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: isBig ? 220 : 105,
        decoration: _boxDecoration(),
        child: _imageContainer(context),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: LightThemeColors.grey.withOpacity(0.6),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(24),
      color: LightThemeColors.white,
    );
  }

  Stack _imageContainer(context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        _text(context),
      ],
    );
  }

  Padding _text(context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
