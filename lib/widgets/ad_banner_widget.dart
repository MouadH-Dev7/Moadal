import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  static const String _testAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  static const String _productionAdUnitId =
      'ca-app-pub-6985433383288143/8711391816';

  String get _adUnitId =>
      kDebugMode ? _testAdUnitId : _productionAdUnitId;

  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;
  bool _hasLoadFailed = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: _adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isBannerLoaded = true;
            _hasLoadFailed = false;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!mounted) {
            return;
          }
          setState(() {
            _isBannerLoaded = false;
            _hasLoadFailed = true;
          });
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isBannerLoaded || _bannerAd == null) {
      if (_hasLoadFailed) {
        return const SizedBox.shrink();
      }
      return const SizedBox(height: 0);
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
