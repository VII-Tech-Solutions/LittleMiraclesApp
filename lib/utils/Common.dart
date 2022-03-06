// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:nb_utils/nb_utils.dart';

// Project imports:
import '../../main.dart';
import 'Constants.dart';

extension IntExt on int {
  Size get size => Size(this.toDouble(), this.toDouble());
}

// void showInterstitialAd(BuildContext context, {bool aIsFinish = true}) {
//   if (myInterstitial == null) {
//     log('attempt to show interstitial before loaded.');
//     if (aIsFinish) {
//       finish(context);
//     }
//     return;
//   }
//   myInterstitial!.fullScreenContentCallback = FullScreenContentCallback(
//     onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
//     onAdDismissedFullScreenContent: (InterstitialAd ad) {
//       log('$ad onAdDismissedFullScreenContent.');
//       createInterstitialAd();
//       myInterstitial!.dispose();
//     },
//     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//       log('$ad onAdFailedToShowFullScreenContent: $error');
//       createInterstitialAd();
//       myInterstitial!.dispose();
//     },
//   );
//   myInterstitial!.show();
// }

