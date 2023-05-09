//PACKAGES

// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

import '../../../../Global/colors.dart';

// Project imports:

//EXTENSIONS

class PaymentContainerGift extends StatefulWidget {
  final bool? isMultiSession;
  final void Function(int?)? onTapCallback;
  const PaymentContainerGift(
      {@required this.isMultiSession, @required this.onTapCallback});

  @override
  _PaymentContainerGiftState createState() => _PaymentContainerGiftState();
}

class _PaymentContainerGiftState extends State<PaymentContainerGift> {
  int? _selectedPayment;

  Widget _buildSelectionRow(int id, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPayment = id;
        });

        return widget.onTapCallback!(_selectedPayment);
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: _selectedPayment == id
            ? BoxDecoration(
                color: AppColors.blueF4F9FA,
                border: Border.all(
                  color: AppColors.blue8DC4CB,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
        child: Row(
          children: [
            id == 3
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      'assets/images/payment_$id.png',
                      height: 44,
                      width: 38,
                    ),
                  )
                : Image.asset(
                    'assets/images/payment_$id.png',
                    height: 34,
                    width: 48,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black45515D),
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.greyD0D3D6,
                    width: 1,
                  )),
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedPayment == id
                      ? AppColors.blue8DC4CB
                      : Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: AppColors.black45515D,
              ),
            ),
          ),
          _buildSelectionRow(3, 'Debit Card'),
          _buildSelectionRow(4, 'Credit Card'),
        ],
      ),
    );
  }
}