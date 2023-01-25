import 'package:LMP0001_LittleMiraclesApp/pages/booking/failurePaymentPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/successPaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  final String link;
  final selectedPayment;
  InAppWebViewPage(this.link, {this.selectedPayment});

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        // InAppWebView(
        //   initialUrlRequest: URLRequest(url: Uri.parse(widget.link.toString())),
        //   onLoadStop: (InAppWebViewController controller, url) {
        //     print("url: $url");
        //     if (url!.path.endsWith("/approved")) {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) =>
        //                 SuccessPaymentPage(widget.selectedPayment),
        //           ));
        //     } else if (url.path.endsWith("/declined")) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) =>
        //                 FailurePaymentPage(widget.selectedPayment)),
        //       );
        //     }
        //   },
        // ),
        WebView(
          initialUrl: widget.link.toString(),
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String url) {
            print("url: $url");
            if (url.endsWith("/approved")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SuccessPaymentPage(widget.selectedPayment.toString())),
              );
            } else if (url.endsWith("/declined")) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FailurePaymentPage(widget.selectedPayment.toString())),
              );
            }
          },
        )
      ]),
    );
  }
}
