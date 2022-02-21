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
  static const String paymentMethods = 'paymentMethods';
  static const String backdropCategories = 'backdropCategories';
  static const String cakeCategories = 'cakeCategories';
  static const String familyMembers = 'familyMembers';
  static const String familyInfo = 'familyInfo';
  static const String studioPackages = 'studioPackages';
  static const String studioMetadata = 'studioMetadata';
  static const String faqs = 'faqs';
  static const String sessions = 'sessions';
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

class SessionStatus {
  static const int booked = 1;
  static const int photoShootDay = 2;
  static const int magicMaking = 3;
  static const int gettingInOrder = 4;
  static const int ready = 5;
}

class StudioMetaCategory {
  static const albumSize = 1;
  static const spreads = 2;
  static const paperType = 3;
  static const coverType = 4;
  static const canvasThickness = 5;
  static const canvasSize = 6;
  static const printType = 7;
  static const paperSize = 8;
}

class StudioPackageTypes {
  static const album = 1;
  static const canvasPrint = 2;
  static const photoPaper = 3;
}

class SocialIconAsset {
  static const String instagram = 'assets/images/iconsSocialInstagram.png';
  static const String facebook = 'assets/images/iconsSocialFacebook.svg';
  static const String snapchat = 'assets/images/iconsSocialSnapchat.svg';
  static const String twitter = 'assets/images/iconsSocialTwitter.svg';
  static const String youtube = 'assets/images/iconsSocialYoutube.svg';
  static const String pinterest = 'assets/images/iconsSocialPinterest.svg';
}

class SubSessionBookingDetailsType {
  static const backdrop = 1;
  static const cake = 2;
  static const photographer = 3;
  static const subSession = 4;
}
