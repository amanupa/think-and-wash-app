import 'package:flutter/material.dart';

import '../../core/ads/ads_manager.dart';
import '../../core/ads/banner_ad.dart';
import '../../core/app_colors.dart';

class WatchAndEarn extends StatefulWidget {
  const WatchAndEarn({super.key});

  @override
  State<WatchAndEarn> createState() => _WatchAndEarnState();
}

class _WatchAndEarnState extends State<WatchAndEarn> {
  bool isAdReady = false;

  @override
  void initState() {
    super.initState();
    AdManager.instance.loadRewardedAd(
      onLoaded: () {
        if (mounted) {
          setState(() => isAdReady = true);
        }
      },
    );
  }

  void watchAd() {
    if (!isAdReady) return;

    AdManager.instance.showRewardedAd(
      onReward: (amount, type) {
        debugPrint("User earned reward: $amount $type");

        /// 👉 give coins / points here
      },
    );

    setState(() => isAdReady = false);
  }

  @override
  void dispose() {
    AdManager.instance.disposeRewarded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: Text(
          'Watch & Earn',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),

      bottomNavigationBar: const GlobalBannerAd(),
      body: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -2,
                color: AppColors.boxShadowPink,
              ),
            ],
          ),
          child: TextButton(
            onPressed: isAdReady ? watchAd : null,
            child:
                isAdReady
                    ? Text(
                      "Watch Ad & Earn",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                    : const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
          ),
        ),
      ),
    );
  }
}
