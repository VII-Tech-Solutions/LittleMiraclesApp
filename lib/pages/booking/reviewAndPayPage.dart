//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/booking/inAppWebview.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/booking/successPaymentPage.dart';
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/paymentContainer/paymentAgreement.dart';
import '../../widgets/paymentContainer/paymentBottomContainer.dart';
import '../../widgets/paymentContainer/paymentContainer.dart';
import '../../widgets/paymentContainer/paymentDetailsContainer.dart';
import '../../widgets/paymentContainer/promoCodeContainer.dart';
import '../../widgets/sessionContainers/guidelinesButtonWidget.dart';

//EXTENSIONS

class ReviewAndPayPage extends StatefulWidget {
  const ReviewAndPayPage();

  @override
  State<ReviewAndPayPage> createState() => _ReviewAndPayPageState();
}

class _ReviewAndPayPageState extends State<ReviewAndPayPage> {
  bool _isAgreementChecked = false;
  String? _selectedPayment = null;
  final _scrollController = new ScrollController();

  void _confirmSignelSession(BuildContext context) {
    ShowLoadingDialog(context);
    context.read<Bookings>().bookASession().then((bookResponse) {
      context.read<Bookings>().confirmASession().then((confirmResponse) {
        context.read<AppData>().fetchAndSetSessions().then((_) {
          context.read<AppData>().fetchAndSetAppData().then((_) {
            ShowLoadingDialog(context, dismiss: true);
            if (bookResponse?.statusCode == 200 &&
                confirmResponse?.statusCode == 200) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessPaymentPage(_selectedPayment),
                ),
                (Route<dynamic> route) => false,
              );
            } else if (bookResponse?.statusCode != 200) {
              ShowOkDialog(
                context,
                bookResponse?.message ?? ErrorMessages.somethingWrong,
              );
            } else {
              ShowOkDialog(
                context,
                confirmResponse?.message ?? ErrorMessages.somethingWrong,
              );
            }
          });
        });
      });
    });
  }

  void _confirmMultiSession(BuildContext context) {
    ShowLoadingDialog(context);
    context.read<Bookings>().bookMultiSessions().then((bookResponse) {
      context.read<Bookings>().confirmASession().then((confirmResponse) {
        context.read<AppData>().fetchAndSetSessions().then((_) {
          context.read<AppData>().fetchAndSetAppData().then((_) {
            ShowLoadingDialog(context, dismiss: true);
            if (bookResponse?.statusCode == 200 &&
                confirmResponse?.statusCode == 200) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessPaymentPage(_selectedPayment),
                ),
                (Route<dynamic> route) => false,
              );
            } else if (bookResponse?.statusCode != 200) {
              ShowOkDialog(
                context,
                bookResponse?.message ?? ErrorMessages.somethingWrong,
              );
            } else {
              ShowOkDialog(
                context,
                confirmResponse?.message ?? ErrorMessages.somethingWrong,
              );
            }
          });
        });
      });
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Bookings>().session;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Review & Pay',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GuidelinesButtonWidget(session),
              PaymentDetailsContainer(),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
                margin: const EdgeInsets.only(top: 20),
              ),
              PromoCodeContainer(),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
              ),
              PaymentContainer(
                isMultiSession: session?.subSessionsIds != null,
                onTapCallback: (val) {
                  _selectedPayment = val;
                },
              ),
              PaymentAgreement(onTapCallback: (val) {
                _isAgreementChecked = val;
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaymentBottomContainer(
        onTapCallback: () {
          if (_selectedPayment == null) {
            ShowOkDialog(context, 'Please select a payment method');
          } else if (_isAgreementChecked == false) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          } else {
            final bookingsProvider = context.read<Bookings>();

            // _launchURL(bookingsProvider.paymentLink);
            print(bookingsProvider.session!.id);
            print(bookingsProvider.paymentLink);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    InAppWebViewPage(bookingsProvider.paymentLink),
              ),
            );
            session?.subSessionsIds != null
                ? _confirmMultiSession(context)
                : _confirmSignelSession(context);
          }
        },
      ),
    );
  }
}
