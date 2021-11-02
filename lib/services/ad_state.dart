import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movement_measure/utilities/constants.dart';

class AdState with ChangeNotifier {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId =>
      Platform.isAndroid ? androidAdUnitId : iosAdUnitId;

  BannerAd initBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(),
      request: AdRequest(),
    );
  }
}
