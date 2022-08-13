import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:petilla_app_project/general/general_widgets/ads/ads_detail_view.dart';
import 'package:petilla_app_project/theme/light_theme_colors.dart';

class AdsWidget extends StatefulWidget {
  const AdsWidget(
      {Key? key, required this.images, required this.titles, required this.descriptions, required this.urls})
      : super(key: key);
  final List<String> images;
  final List<String> titles;
  final List<String> descriptions;
  final List<String> urls;

  @override
  State<AdsWidget> createState() => _AdsWidgetState();
}

class _AdsWidgetState extends State<AdsWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.images.map((image) {
            return _adsContainer(image);
          }).toList(),
          options: _carouselOptions(),
        ),
        _customIndicator(),
      ],
    );
  }

  Row _customIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.images.map((url) {
        int index = widget.images.indexOf(url);
        return _indicatorContainer(index);
      }).toList(),
    );
  }

  Container _indicatorContainer(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index ? LightThemeColors.miamiMarmalade : const Color.fromRGBO(0, 0, 0, 0.4),
      ),
    );
  }

  CarouselOptions _carouselOptions() {
    return CarouselOptions(
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      pauseAutoPlayOnTouch: true,
      aspectRatio: 2.3,
      height: 175,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      onPageChanged: _onPageChanged,
    );
  }

  _onPageChanged(index, reason) {
    setState(() {
      _current = index;
    });
  }

  InkWell _adsContainer(String image) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdsDetailView(
              description: widget.descriptions[widget.images.indexOf(image)],
              url: widget.urls[widget.images.indexOf(image)],
              image: image,
              title: widget.titles[widget.images.indexOf(image)],
            ),
          ),
        );
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _adsTitle(),
        ),
      ),
    );
  }

  Text _adsTitle() {
    return Text(
      widget.titles[_current],
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
