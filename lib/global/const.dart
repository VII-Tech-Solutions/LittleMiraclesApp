class APIEnvironment {
  static const String staging = 'https://littlemiracles.viitech.net';
  static const String production = '';
}

class ErrorMessages {
  static const String somethingWrong =
      'Something went wrong, please try again later.';
  static const String fillRequiredInfo =
      'Please fill in all the required information';
}

class Timeout {
  static const int value = 90;
}

class LastUpdate {
  static const String appData = 'appData';
}

class Placeholders {
  // EXAMPLES
  // static const String _basePath = 'assets/images/';
  // static const String userPlaceholder = '${_basePath}user-placeholder.png';
}

class Tables {
  static const String onboarding = 'onboardings';
  static const String photographers = 'photographers';
  static const String cakes = 'cakes';
  static const String backdrops = 'backdrops';
  static const String dailyTips = 'dailyTips';
  static const String promotions = 'promotions';
  static const String workshops = 'workshops';
  static const String sections = 'sections';
  static const String packages = 'packages';
}

class SectionType {
  static const int header = 1;
  static const int card = 2;
}

class SectionAction {
  static const String login = 'login';
  static const String packages = 'packages';
  static const String studio = 'studio';
}

class SSOType {
  static const String google = 'google';
  static const String facebook = 'facebook';
  static const String snapchat = 'snapchat';
  static const String apple = 'apple';
}

class UserStatus {
  static const int completed = 1;
  static const int draft = 2;
  static const int incomplete = 3;
}
