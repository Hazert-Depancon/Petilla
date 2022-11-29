class RouterConstants {
  static RouterConstants? _instace;
  static RouterConstants get instance {
    _instace ??= RouterConstants._init();
    return _instace!;
  }

  RouterConstants._init();

  static const String onboarding = "/onboarding";
  static const String login = "login";
  static const String register = "register";
  static const String selectApp = "selectApp";
  static const String reportedPetDetail = "reportedPetDetail";
  static const String petDetail = "petDetail";
  static const String profile = "profile";
  static const String petilla = "petilla";
  static const String citySelect = "citySelect";
  static const String districtSelect = "districtSelect";
  static const String otherProfile = "otherProfile";
  static const String mainPetilla = "mainPetilla";
  static const String addViewTwo = "addViewTwo";
  static const String inChat = "inChat";
  static const String groupChat = "groupChat";
  static const String adminHome = "adminHome";
}
