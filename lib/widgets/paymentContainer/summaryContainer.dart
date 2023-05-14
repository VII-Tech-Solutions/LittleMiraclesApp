//PACKAGES

// Dart imports:
import 'dart:convert';
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/bookings.dart';

//EXTENSIONS

class SummaryContainer extends StatefulWidget {
  @override
  _SummaryContainerState createState() => _SummaryContainerState();
}

class _SummaryContainerState extends State<SummaryContainer> {
  int? _selectedPayment;

  row(title, amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Container(width: 250, child: Text(title)), Text(amount)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Bookings>().session;
    final package = context.watch<Bookings>().package;
    final promoCode = context.watch<Bookings>().promoCode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          row(
            '${session?.title ?? ''}',
            'BD${package?.price ?? ''}',
          ),
          if (promoCode != null)
            row(
              'Promo code : ${promoCode.codepromo}',
              '- BD ${promoCode.discountPrice ?? ''}',
            ),
          if (package?.additionalCharge != null)
            row(
              'Photographer additional charge',
              'BD${package?.additionalCharge ?? ''}',
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
                    promoCode != null
                        ? 'BD${promoCode.totalPrice ?? ''}'
                        : 'BD${session?.totalPrice ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          row(
              'VAT (10%)',
              promoCode != null
                  ? 'BD${promoCode.vatAmount ?? ''}'
                  : 'BD${session?.vatAmount ?? ''}'),
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
                    promoCode != null
                        ? 'BD${json.decode(promoCode.totalPrice.toString())! + json.decode(promoCode.vatAmount.toString())}'
                        : 'BD${session!.subtotal}',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
