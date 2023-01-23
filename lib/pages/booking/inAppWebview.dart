import 'package:LMP0001_LittleMiraclesApp/pages/booking/failurePaymentPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/successPaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  final String link;
  InAppWebViewPage(this.link);

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.link.toString())),
          onLoadStop: (InAppWebViewController controller, url) {
            print("url: $url");
            if (url!.path.endsWith("/approved")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccessPaymentPage('2')),
              );
            } else if (url.path.endsWith("/declined")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FailurePaymentPage('2')),
              );
            }
          },
        ),
      ]),
    );
  }
}
