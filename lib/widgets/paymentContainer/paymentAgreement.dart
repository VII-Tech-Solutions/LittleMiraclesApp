//PACKAGES

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../global/colors.dart';

//EXTENSIONS

class PaymentAgreement extends StatefulWidget {
  final void Function(bool)? onTapCallback;
  const PaymentAgreement({@required this.onTapCallback});

  @override
  _PaymentAgreementState createState() => _PaymentAgreementState();
}

class _PaymentAgreementState extends State<PaymentAgreement> {
  bool isChecked = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isChecked = !isChecked;
              });

              return widget.onTapCallback!(isChecked);
            },
            child: Container(
              width: 29,
              height: 29,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isChecked == true ? AppColors.blue8DC4CB : Colors.white,
                borderRadius: BorderRadius.circular(6.4),
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'By proceeding, you agree to our ',
                style: TextStyle(
                  color: AppColors.black45515D,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Terms of Use ',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //todo go to Terms of Use
                        _launchURL('https://www.littlemiraclesbys.com/about/');
                      },
                  ),
                  TextSpan(
                    text: 'and confirm you have read our ',
                  ),
                  TextSpan(
                    text: 'Privacy and Cookie Statement',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //todo go to Privacy and Cookie Statement
                        _launchURL('https://www.littlemiraclesbys.com/faq/');
                      },
                  ),
                  TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
