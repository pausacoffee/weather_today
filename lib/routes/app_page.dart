enum APP_PAGE { splash, home, error, geo }

extension AppPageExtension on APP_PAGE {
  String get toPath {
    switch (this) {
      case APP_PAGE.home:
        return "/home";
      case APP_PAGE.splash:
        return "/splash";
      case APP_PAGE.error:
        return "/error";
      //sub
      case APP_PAGE.geo:
        return "geo";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case APP_PAGE.home:
        return "HOME";
      case APP_PAGE.splash:
        return "SPLASH";
      case APP_PAGE.error:
        return "ERROR";
      case APP_PAGE.geo:
        return "GEO";
      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case APP_PAGE.home:
        return "My App";
      case APP_PAGE.splash:
        return "My App Splash";
      case APP_PAGE.error:
        return "My App Error";
      case APP_PAGE.geo:
        return "My App GEO";
      default:
        return "My App";
    }
  }
}
