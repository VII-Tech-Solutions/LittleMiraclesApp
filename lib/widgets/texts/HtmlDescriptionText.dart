//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
//GLOBAL
import '../../Global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class HtmlDescriptionText extends StatelessWidget {
  final String? text;
  HtmlDescriptionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Html(
        data: """$text""",
        shrinkWrap: true,
        style: {
          "body": Style(
            color: AppColors.black45515D,
            fontSize: FontSize(14),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
          ),
        },
        onLinkTap: (String? url, RenderContext context,
            Map<String, String> attributes, element) async {
          print(url);
          if (await canLaunch(url!)) {
            await launch(
              url,
              forceSafariVC: false,
              forceWebView: false,
            );
          } else {
            throw 'Could not launch $url';
          }
        });
  }
}
