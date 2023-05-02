//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/selectPackagePage.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';

//EXTENSIONS

class SendGift extends StatefulWidget {
  const SendGift();

  @override
  State<SendGift> createState() => _SendGiftState();
}

class _SendGiftState extends State<SendGift> {
  List<int> _isExpandedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithBack(
        title: 'Send a Gift',
        weight: FontWeight.w800,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send a studio package as a gift",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black45515D,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Select any studio package and gift a family member or friend! Just enter their email address and wait for their surprised faces."),
            SizedBox(
              height: 20,
            ),
            Text(
                "You have not sent a gift yet. Once you do, they’ll show up here."),
            Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(bottom: 20),
        child: FilledButtonWidget(
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectPackage(),
              ),
            );
          },
          title: 'Send a Gift',
          type: ButtonType.generalBlue,
        ),
      ),
    );
  }
}
