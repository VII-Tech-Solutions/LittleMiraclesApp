//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/pages/more/gifting/selectPackagePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/colors.dart';
import '../../../providers/auth.dart';
import '../../../providers/giftingProvider.dart';
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/general/cachedImageWidget.dart';

//EXTENSIONS

class SendGift extends StatefulWidget {
  const SendGift();

  @override
  State<SendGift> createState() => _SendGiftState();
}

class _SendGiftState extends State<SendGift> {
  List<int> _isExpandedList = [];

  var authProvider;
  late GiftingData giftingProvider;

  @override
  void initState() {
    giftingProvider = Provider.of<GiftingData>(context, listen: false);

    print(giftingProvider.userGifts.length);

    super.initState();
  }

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
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
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
            giftingProvider.userGifts.length == 0
                ? Text(
                    "You have not sent a gift yet. Once you do, they’ll show up here.")
                : Expanded(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: giftingProvider.userGifts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(giftingProvider
                            //     .userGifts[giftingProvider.userGifts.length]
                            //     .title
                            //     .toString()),
                            SizedBox(
                              height: 180,
                              child: CachedImageWidget(
                                index,
                                giftingProvider.userGifts[index].packageImage ??
                                    null,
                                ImageShape.square,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  (giftingProvider
                                              .userGifts[index].packageTitle ??
                                          "") +
                                      " " +
                                      (giftingProvider
                                              .userGifts[index].packageTag ??
                                          ""),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black45515D,
                                  ),
                                ),
                                Text(
                                  "${giftingProvider.userGifts[index].createdAt.day.toString().padLeft(2, '0')} / ${giftingProvider.userGifts[index].createdAt.month.toString().padLeft(2, '0')} /${giftingProvider.userGifts[index].createdAt.year}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.black45515D,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "To : " +
                                  giftingProvider.userGifts[index].to
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: AppColors.black45515D,
                              ),
                            ),

                            SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
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
