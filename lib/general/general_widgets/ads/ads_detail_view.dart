import 'package:flutter/material.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';
import 'package:petilla_app_project/theme/sizes/project_padding.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdsDetailView extends StatefulWidget {
  const AdsDetailView(
      {Key? key, required this.image, required this.title, required this.description, required this.url})
      : super(key: key);

  final String image;
  final String title;
  final String description;
  final String url;

  @override
  State<AdsDetailView> createState() => _AdsDetailViewState();
}

class _AdsDetailViewState extends State<AdsDetailView> {
  Future<void> _launchUrl() async {
    if (!await launchUrlString(widget.url)) {
      throw 'Could not launch ${widget.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: LightThemeColors.miamiMarmalade,
      ),
      body: Padding(
        padding: ProjectPaddings.horizontalMainPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageContainer(),
            const SizedBox(height: 12),
            _titleText(),
            const SizedBox(height: 12),
            ReadMoreText(
              widget.description,
              trimLines: 4,
              colorClickableText: LightThemeColors.miamiMarmalade,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Daha fazla',
              trimExpandedText: 'Kapat',
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: LightThemeColors.miamiMarmalade,
              ),
              lessStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: LightThemeColors.miamiMarmalade,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _launchUrl,
              child: const Text(
                "Daha falzla bilgi için tıklayınız.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: LightThemeColors.miamiMarmalade),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _titleText() {
    return Text(
      widget.title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Container _imageContainer() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(widget.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
