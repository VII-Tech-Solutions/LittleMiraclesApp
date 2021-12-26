//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
//PAGES

class PaymentContainer extends StatefulWidget {
  const PaymentContainer();

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  int? _selectedPayment;

  Widget _buildSelectionRow(int id, String title) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPayment = id;
        });
      },
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: true == true
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
            Container(
              color: Colors.red,
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
                  color: true == true ? AppColors.blue8DC4CB : Colors.white,
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
    final list = context.watch<AppData>().paymentMethods;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: AppColors.black45515D,
          ),
        ),
        _buildSelectionRow(0, 'Paypal'),
        _buildSelectionRow(1, 'Apple Pay'),
        _buildSelectionRow(2, 'Debit Card'),
        _buildSelectionRow(3, 'Credit Card'),
      ],
    );
  }
}
