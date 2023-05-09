//PACKAGES

// Flutter imports:
import 'dart:convert';

import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/components/giftInfoContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/components/packageBottomBar.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/components/paymentContainerGift.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/inAppWebviewGift.dart';
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/successPaymentPage.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../global/globalEnvironment.dart';
import '../../../providers/auth.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../../widgets/paymentContainer/paymentAgreement.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/studioContainers/studioSuccessPaymentPage.dart';

//EXTENSIONS

class ReviewAndPayGift extends StatefulWidget {
  final giftInformation;

  const ReviewAndPayGift({required this.giftInformation});

  @override
  State<ReviewAndPayGift> createState() => _ReviewAndPayGiftState();
}

class _ReviewAndPayGiftState extends State<ReviewAndPayGift> {
  bool _isAgreementChecked = false;
  String? _selectedPayment = null;
  final _scrollController = new ScrollController();

  var authProvider;

  @override
  void initState() {
    authProvider = Provider.of<Auth>(context, listen: false);

    super.initState();
  }

  Future<dynamic> giftCheckout() async {
    ShowLoadingDialog(context);
    var requestData = {
      'payment_method': _selectedPayment,
    };
    try {
      var url = Uri.parse(
          apiLink + '/gifts/${widget.giftInformation['gift_id']}/checkout');

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer ${authProvider.token}'
          },
          body: requestData);

      if (response.statusCode == 200) {
        // API call successful

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        ShowLoadingDialog(context, dismiss: true);

        var giftInformation = widget.giftInformation;
        giftInformation['payment_url'] = jsonResponse['data']['payment_url'];
        giftInformation['success_indicator'] =
            jsonResponse['data']['success_indicator'] ?? "";

        return giftInformation;
      } else {
        // API call failed
        print('Response body: ${response.body}');
      }
      ShowLoadingDialog(context, dismiss: true);
      return null;
    } catch (e) {
      print(e);
      ShowLoadingDialog(context, dismiss: true);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    row(title, amount) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Container(width: 280, child: Text(title)), Text(amount)],
        ),
      );
    }

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Review & Pay',
        weight: FontWeight.w800,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          controller: _scrollController,
          // padding: EdgeInsets.only(top: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.giftInformation.toString()),
              GiftInfoContainer(giftInformation: widget.giftInformation),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: AppColors.black45515D,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    row(
                      widget.giftInformation['package_name'] +
                          " " +
                          widget.giftInformation['package_tag'],
                      'BD ${widget.giftInformation['package_price'] ?? ''}',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 250,
                              child: Text(
                                'Subtotal',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Text(
                              'BD ${widget.giftInformation['package_price'] ?? ''}',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    row(
                      'VAT (10%)',
                      'BD ${(double.parse(widget.giftInformation['package_price']) * 0.1)}',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 250,
                              child: Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Text(
                              'BD ${double.parse(widget.giftInformation['package_price']) + (double.parse(widget.giftInformation['package_price']) * 0.1)}',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.greyE8E9EB,
              ),
              PaymentContainerGift(
                onTapCallback: (val) {
                  print(val);
                  if (val == 4) {
                    setState(() {
                      _selectedPayment = "1";
                    });
                  } else if (val == 3) {
                    setState(() {
                      _selectedPayment = "2";
                    });
                  }
                },
              ),
              PaymentAgreement(onTapCallback: (val) {
                _isAgreementChecked = val;
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PackageBottomBar(
          price:
              'BD ${double.parse(widget.giftInformation['package_price']) + (double.parse(widget.giftInformation['package_price']) * 0.1)}',
          onTap: () async {
            if (_selectedPayment == null) {
              ShowOkDialog(
                context,
                "Please choose a Payment method !",
                title: "Oops",
              );
            } else if (_isAgreementChecked == false) {
              ShowOkDialog(
                context,
                "Please check terms and agreements !",
                title: "Oops",
              );
            } else {
              var giftInformation = await giftCheckout();
              print(giftInformation);
              if (giftInformation != null) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => InAppWebViewPageGift(
                //       giftInformation: giftInformation,
                //     ),
                //   ),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GiftSuccessPaymentPage(
                      giftInformation,
                    ),
                  ),
                );
              }
            }
          }),
    );
  }
}
