import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();
  static final AdManager instance = AdManager._();

  BannerAd? _banner;

  BannerAd? get banner => _banner;

  Future<BannerAd?> loadAdaptiveBanner(int width) async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      width,
    );

    if (size == null) return null;

    _banner?.dispose();

    _banner = BannerAd(
      size: size,
      adUnitId: _bannerId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    )..load();

    return _banner;
  }

  String get _bannerId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
  }

  void disposeBanner() {
    _banner?.dispose();
    _banner = null;
  }
}
