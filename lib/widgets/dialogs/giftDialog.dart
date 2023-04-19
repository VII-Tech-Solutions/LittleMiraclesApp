//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../../global/colors.dart';
import '../../widgets/buttons/filledButtonWidget.dart';

//EXTENSIONS

class giftDialog {
  final BuildContext context;
  final String? promoCode;
  final String? title;
  final String? validity;
  final void Function(String?)? onTap;

  giftDialog(
    this.context,
    this.promoCode,
    this.title,
    this.validity,
    this.onTap,
  ) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: InkWell(
        onTap: () => {Navigator.pop(context)},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.black45515D,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                // height: 351,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(30, 34, 30, 30),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Congratulations!\n',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black45515D,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'You claim',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontWeight: FontWeight.normal,
                              color: AppColors.black45515D,
                            ),
                          ),
                          TextSpan(
                            text: ' $title! 🥳 ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black45515D,
                            ),
                          ),
                          TextSpan(
                            text: 'Please enter the promo code at check out:',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontWeight: FontWeight.normal,
                              color: AppColors.black45515D,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        bottom: 10.0,
                      ),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.blackE8E9EB,
                        ),
                        child: Center(
                          child: Text(
                            '$promoCode',
                            style: TextStyle(
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black45515D,
                            ),
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '*This gift is valid until $validity',
                        style: TextStyle(
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ),
                    FilledButtonWidget(
                      height: 38,
                      onPress: () {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          elevation: 2,
                          duration: Duration(seconds: 2),
                          content: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Promo Code Copied',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          backgroundColor: AppColors.black2D3B48,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                        Clipboard.setData(
                          ClipboardData(text: promoCode ?? ''),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        onTap!(promoCode);
                        Navigator.pop(context);
                      },
                      margin: const EdgeInsets.only(top: 30.0),
                      type: ButtonType.generalBlue,
                      title: 'Copy Promo Code',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      // barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
