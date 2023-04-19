import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/iconButtonWidget.dart';
import 'package:provider/provider.dart';

import '../../Global/colors.dart';
import '../../providers/bookings.dart';

// showDialog(
//   context: context,
//   builder: (_) {
//     return AlertDialog(
//       insetPadding: const EdgeInsets.all(0),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       content: RateDialog(),
//     );
//   },
// );

class RateDialog extends StatelessWidget {
  const RateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionLength = context.watch<AppData>().sessions.length;
    final InAppReview inAppReview = InAppReview.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonWidget(
            onPress: (() {
              context.read<Bookings>().hideAppRate();
              Navigator.pop(context);
            }),
            icon: Icons.close),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * (10 / 812),
            bottom: MediaQuery.of(context).size.height * (30 / 812),
          ),
          padding:
              EdgeInsets.all(MediaQuery.of(context).size.height * (30 / 812)),
          height: MediaQuery.of(context).size.height * (365 / 812),
          width: MediaQuery.of(context).size.width * (343 / 375),
          decoration: BoxDecoration(
            color: AppColors.whiteFFFFFF,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Rate the Little Miracles App ",
                          style: TextStyle(
                            fontFamily: GoogleFonts.manrope().fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black45515D,
                          ),
                        ),
                        WidgetSpan(
                          child: Image(
                            image: AssetImage('assets/images/applogo.png'),
                            height:
                                MediaQuery.of(context).size.height * (30 / 812),
                            width:
                                MediaQuery.of(context).size.width * (30 / 375),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * (30 / 812)),
                  Text(
                    "Your feedback helps us improve your experience. Are you enjoying the Little Miracles App?",
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black45515D,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  FilledButtonWidget(
                    height: MediaQuery.of(context).size.height * (42 / 812),
                    onPress: () async {
                      if (await inAppReview.isAvailable() &&
                          sessionLength >= 1 &&
                          context.read<Bookings>().showAppRateDiag == true) {
                        inAppReview.requestReview();
                        Navigator.pop(context);
                        context.read<Bookings>().hideAppRate();
                      }
                    },
                    type: ButtonType.generalBlue,
                    title: 'Love It! ♥️',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: FilledButtonWidget(
                      height: MediaQuery.of(context).size.height * (42 / 812),
                      onPress: () {
                        inAppReview.openStoreListing(
                            appStoreId: '...'); //TODO:: Chnage AppID
                        context.read<Bookings>().hideAppRate();
                        Navigator.pop(context);
                      },
                      type: ButtonType.generalGrey,
                      title: 'No, Share feedback',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
