//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/const.dart';
import '../../global/colors.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/appbars/appBarWithClose.dart';
//PAGES

class GuidelinesButtonWidget extends StatelessWidget {
  final Session? session;
  final EdgeInsetsGeometry? margin;
  const GuidelinesButtonWidget(
    this.session, {
    this.margin = const EdgeInsets.fromLTRB(16, 0, 16, 20),
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: session?.hasGuideline == true &&
          (session?.subSessionsIds == null || session?.subSessionsIds == ''),
      child: FilledButtonWidget(
        onPress: () {
          if (session?.id != null) {
            ShowLoadingDialog(context);
            context
                .read<Bookings>()
                .showSessionGuidelines(session?.id)
                .then((response) {
              ShowLoadingDialog(context, dismiss: true);
              if (response?.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar:
                          AppBarWithClose('Guidelines', AppColors.pinkFEF2F1),
                      backgroundColor: AppColors.pinkFEF2F1,
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.read<Bookings>().guidelineString,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                ShowOkDialog(
                  context,
                  response?.message ?? ErrorMessages.somethingWrong,
                );
              }
            });
          }
        },
        title: 'Guidelines',
        type: ButtonType.generalBlue,
        margin: margin,
      ),
    );
  }
}
