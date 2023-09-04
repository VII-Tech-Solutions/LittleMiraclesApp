//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/general/customBottomNavigationBar.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../providers/bookings.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/paymentContainer/paymentDetailsContainer.dart';
import '../home/sessions/upcomingSessionDetailsPage.dart';

//EXTENSIONS

class SuccessPaymentPage extends StatelessWidget {
  final String? paymentMethod;
  const SuccessPaymentPage(this.paymentMethod);

  // void _confirmSignelSession(BuildContext context) {
  //   ShowLoadingDialog(context);
  //   context.read<Bookings>().bookASession().then((bookResponse) {
  //     context.read<Bookings>().confirmASession().then((confirmResponse) {
  //       context.read<AppData>().fetchAndSetSessions().then((_) {
  //         context.read<AppData>().fetchAndSetAppData().then((_) {
  //           ShowLoadingDialog(context, dismiss: true);
  //           if (bookResponse?.statusCode == 200 &&
  //               confirmResponse?.statusCode == 200) {
  //             // Navigator.pushAndRemoveUntil(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) =>
  //             //         SuccessPaymentPage(widget.selectedPayment.toString()),
  //             //   ),
  //             //   (Route<dynamic> route) => false,
  //             // );
  //           } else if (bookResponse?.statusCode != 200) {
  //             ShowOkDialog(
  //               context,
  //               bookResponse?.message ?? ErrorMessages.somethingWrong,
  //             );
  //           } else {
  //             ShowOkDialog(
  //               context,
  //               confirmResponse?.message ?? ErrorMessages.somethingWrong,
  //             );
  //           }
  //         });
  //       });
  //     });
  //   });
  // }

// reset app data without payment ..
  Future<void> resetData(BuildContext context) async {
    ShowLoadingDialog(context);
    context.read<AppData>().fetchAndSetSessions().then((_) {
      context.read<AppData>().fetchAndSetAppData().then((_) {
        ShowLoadingDialog(context, dismiss: true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final session = context.watch<Bookings>().session;
    final promoCode = context.watch<Bookings>().promoCode;
    context.read<Bookings>().showAppRate();
    // _confirmSignelSession(context);
    print(session?.id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: MaterialButton(
            elevation: 0,
            onPressed: () async {
              if (paymentMethod == null) {
                await resetData(context);
                context.read<Auth>().setSelectedIndex(0);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomBottomNavigationBar(),
                  ),
                  (Route<dynamic> route) => false,
                );
              } else {
                context.read<Auth>().setSelectedIndex(0);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomBottomNavigationBar(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.close,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 26),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 100,
                  color: AppColors.green22D896,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    paymentMethod == null ? "Success" : 'Payment Successful',
                    style: TextStyle(
                      color: AppColors.green22D896,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    // 'BD ${promoCode?.totalPrice  ?? package?.price  ?? ''}',
                    'BD ${promoCode?.totalPrice ?? session!.subtotal ?? ''}',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Order ID #15978',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                paymentMethod == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "No Payment",
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '${paymentMethod ?? ''} Payment',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.greyE8E9EB,
            margin: const EdgeInsets.only(top: 48.5, bottom: 15.5),
          ),
          PaymentDetailsContainer(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          // margin: const EdgeInsets.only(bottom: 30),
          child: FilledButtonWidget(
            onPress: () async {
              if (paymentMethod == null) {
                await resetData(context);
                context.read<Auth>().setSelectedIndex(0);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomBottomNavigationBar(),
                  ),
                  (Route<dynamic> route) => false,
                );
              } else {
                context
                    .read<AppData>()
                    .assignSessionById(session?.id)
                    .then((_) {
                  context.read<Auth>().setSelectedIndex(0);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomBottomNavigationBar(),
                    ),
                    (Route<dynamic> route) => false,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpcomingSessionDetailsPage(),
                    ),
                  );
                });
              }
            },
            title: 'Go To Booking Details',
            type: ButtonType.generalBlue,
          ),
        ),
      ),
    );
  }
}
