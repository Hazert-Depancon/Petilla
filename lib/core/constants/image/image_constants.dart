class ImageConstants {
  ImageConstants._init();
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get home => toSvg("home");
  String get homeOutline => toSvg("home_outline");
  String get cat => toSvg("cat");
  String get rabbit => toSvg("rabbit");
  String get fish => toSvg("fish");
  String get dog => toSvg("dog");
  String get general => toSvg("language");
  String get onboardingOne => toSvg("onboarding_one");
  String get onboardingThree => toSvg("onboarding_three");
  String get onboardingTwo => toSvg("onboarding_two");
  String get petform => toPng("petform");
  String get petilla => toPng("petilla_image");
  String get animalReport => toPng("animal_report");
  String get helpMe => toPng("help_me");
  String get loginBackgroundImage => toPng("login_background_image");
  String get petcook => toPng("petcook");
  String get add => toSvg("plus");
  String get profile => toSvg("profile");
  String get settings => toSvg("settings");
  String get eyeOpen => toSvg("eye_open");
  String get eyeClose => toSvg("eye_close");
  String get chat => toSvg("chat");
  String get send => toSvg("send");
  String get filter => toSvg("filter");

  String toSvg(String imageName) => "assets/svg/$imageName.svg";
  String toPng(String imageName) => "assets/images/$imageName.png";
}
