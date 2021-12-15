//PACKAGES
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class PaymentAgreement extends StatefulWidget {
  const PaymentAgreement({Key? key}) : super(key: key);

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
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
            child: Transform.scale(
              scale: 2.0,
              child: Checkbox(
                checkColor: Colors.white,
                splashRadius: 4,
                activeColor: AppColors.blue8DC4CB,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(
                  color: AppColors.greyB9BEC2,
                  width: 0.8,
                ),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
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
                          _launchURL(
                              'https://www.littlemiraclesbys.com/about/');
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
          ),
        ],
      ),
    );
  }
}
