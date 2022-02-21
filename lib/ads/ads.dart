import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static bool _testMode = false;
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905~9893859862";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId1 {
    if (_testMode == true) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/7427672146";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId2 {
    if (_testMode == true) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/1723827439";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId3 {
    if (_testMode == true) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/6401439042";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId4 {
    if (_testMode == true) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/2270622346";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId5 {
    if (_testMode == true) {
      return BannerAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/8913607614";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId2 {
    if (_testMode == true) {
      return InterstitialAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/5577025114";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId1 {
    if (_testMode == true) {
      return InterstitialAd.testAdUnitId;
    } else if (Platform.isAndroid) {
      return "ca-app-pub-1362904048674905/8147256240";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
