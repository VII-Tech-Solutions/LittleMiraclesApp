import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/iconButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Global/colors.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButtonWidget(
            onPress: (() => Navigator.pop(context)), icon: Icons.close),
        Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          padding: const EdgeInsets.all(30),
          height: MediaQuery.of(context).size.height * (365 / 812),
          width: MediaQuery.of(context).size.width * (343 / 375),
          decoration: BoxDecoration(
            color: AppColors.whiteFFFFFF,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Rate the Little Miracles by Sherin App ",
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
                        height: MediaQuery.of(context).size.height * (32 / 812),
                        width: MediaQuery.of(context).size.width * (30 / 375),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (30 / 812),
                  bottom: MediaQuery.of(context).size.height * (60 / 812),
                ),
                child: Text(
                  "Your feedback helps us improve your experience. Are you enjoying the Little Miracles by Sherin App?",
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black45515D,
                  ),
                ),
              ),
              FilledButtonWidget(
                onPress: () {},
                type: ButtonType.generalBlue,
                title: 'Love It! ♥️',
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (10 / 812),
                ),
                child: FilledButtonWidget(
                  onPress: () {},
                  type: ButtonType.generalGrey,
                  title: 'No, Share feedback',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
