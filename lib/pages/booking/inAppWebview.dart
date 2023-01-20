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
    print(widget.link);
    return Scaffold(
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.link.toString())),
        ),
      ]),
    );
  }
}
