import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:patily/product/constants/other_constant/icon_names.dart';
import 'package:patily/product/init/theme/light_theme/light_theme_colors.dart';
import 'package:patily/product/widgets/patily_media/heart_animation_widget.dart';
import 'package:patily/product/models/patily_media/post_model.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key, required this.postModel});

  final PostModel postModel;

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  bool isHeartAnimating = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.horizontalPaddingNormal,
            child: Row(
              children: [
                _circleAvatar(),
                const SizedBox(width: 12),
                _senderUserNameOnTop(context),
              ],
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                isHeartAnimating = true;
                isLiked = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                _image(),
                _favOnImageButton(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: context.horizontalPaddingNormal,
            child: RichText(
              text: _senderName(context),
            ),
          ),
          context.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Text _senderUserNameOnTop(BuildContext context) {
    return Text(
      widget.postModel.senderUserName,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  CircleAvatar _circleAvatar() {
    return CircleAvatar(
      child: Text(widget.postModel.senderUserName.characters.first),
    );
  }

  TextSpan _senderName(BuildContext context) {
    return TextSpan(
      text: "${widget.postModel.senderUserName} ",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 16,
          ),
      children: <TextSpan>[
        _descriptionText(context),
      ],
    );
  }

  TextSpan _descriptionText(BuildContext context) {
    return TextSpan(
      text: widget.postModel.description,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16,
          ),
    );
  }

  Opacity _favOnImageButton() {
    return Opacity(
      opacity: isHeartAnimating ? 1 : 0,
      child: HeartAnimatonWidget(
        duration: const Duration(milliseconds: 700),
        onEnd: () => setState(() {
          isHeartAnimating = false;
        }),
        isAnimating: isHeartAnimating,
        child: const Icon(
          AppIcons.favoriteIcon,
          color: LightThemeColors.white,
          size: 100,
        ),
      ),
    );
  }

  AspectRatio _image() {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        widget.postModel.postDowlandUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
