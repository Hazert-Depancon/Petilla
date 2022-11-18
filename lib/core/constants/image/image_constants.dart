class ImageConstants {
  ImageConstants._init();
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get home => toSvg("home");
  String get homeOutline => toSvg("home_outline");
  String get cat => toSvg("home_outline");
  String get rabbit => toSvg("rabbit");
  String get fish => toSvg("fish");
  String get dog => toSvg("fish");
  String get onboardingOne => toSvg("onboarding_one");
  String get onboardingThree => toSvg("onboarding_three");
  String get onboardingTwo => toSvg("onboarding_two");
  String get petform => toSvg("petform");
  String get petilla => toSvg("petilla_image");

  String toSvg(String imageName) => "assets/svg/$imageName.svg";
}
