import 'dart:io';

import 'package:LMP0001_LittleMiraclesApp/pages/booking/failurePaymentPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/successPaymentPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebViewPageGift extends StatefulWidget {
  final dynamic giftInformation;
  // final String link;
  // final selectedPayment;
  // final String? successIndicator;
  InAppWebViewPageGift({required this.giftInformation});

  @override
  State<InAppWebViewPageGift> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPageGift> {
  @override
  void initState() {
    super.initState();

    print(widget.giftInformation);
    // print(widget.successIndicator);
    // Android keyboard fix
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl: widget.giftInformation['payment_url'].toString(),
                javascriptMode: JavascriptMode.unrestricted,
                gestureRecognizers: Set()
                  ..add(
                    Factory<DragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer(),
                    ),
                  ),
                onPageStarted: (url) {
                  print("hehe");
                  if (widget.giftInformation['payment_url']
                      .contains('Credimax')) {
                    if (url.contains('hc-action-cancel')) {
                      Navigator.pop(context);
                    } else if (url.contains('resultIndicator') &&
                        url.contains(
                            widget.giftInformation['success_indicator'])) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SuccessPaymentPage(
                      //           widget.selectedPayment.toString())),
                      // );
                    }
                  } else {
                    // if (url.contains('paymentcancel')) {
                    //   Navigator.pop(context);
                    // }
                  }
                },
                onPageFinished: (String url) {
                  print("url: $url");
                  if (url.endsWith("/approved")) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SuccessPaymentPage(
                    //           widget.selectedPayment.toString())),
                    // );
                  } else if (url.endsWith("/declined")) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FailurePaymentPage("77")),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
