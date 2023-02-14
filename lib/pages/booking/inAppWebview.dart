import 'package:LMP0001_LittleMiraclesApp/pages/booking/failurePaymentPage.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/booking/successPaymentPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../global/const.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  final String link;
  final selectedPayment;
  InAppWebViewPage(this.link, {this.selectedPayment});

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  void _confirmSignelSession(BuildContext context) {
    ShowLoadingDialog(context);
    context.read<Bookings>().bookASession().then((bookResponse) {
      context.read<Bookings>().confirmASession().then((confirmResponse) {
        context.read<AppData>().fetchAndSetSessions().then((_) {
          context.read<AppData>().fetchAndSetAppData().then((_) {
            ShowLoadingDialog(context, dismiss: true);
            if (bookResponse?.statusCode == 200 &&
                confirmResponse?.statusCode == 200) {
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         SuccessPaymentPage(widget.selectedPayment.toString()),
              //   ),
              //   (Route<dynamic> route) => false,
              // );
            } else if (bookResponse?.statusCode != 200) {
              // ShowOkDialog(
              //   context,
              //   bookResponse?.message ?? ErrorMessages.somethingWrong,
              // );
            } else {
              // ShowOkDialog(
              //   context,
              //   confirmResponse?.message ?? ErrorMessages.somethingWrong,
              // );
            }
          });
        });
      });
    });
  }

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
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         SuccessPaymentPage(widget.selectedPayment.toString()),
              //   ),
              //   (Route<dynamic> route) => false,
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SuccessPaymentPage(widget.selectedPayment.toString())),
              );
              _confirmSignelSession(context);
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
