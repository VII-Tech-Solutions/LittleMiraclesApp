//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../pages/home/loyaltyPage.dart';
import '../../providers/appData.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/dialogs/showLoadingDialog.dart';
import '../../widgets/dialogs/showOkDialog.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSIONS

class FreeGiftContainer extends StatelessWidget {
  const FreeGiftContainer();

  Widget _giftLogo(bool isClaimed) {
    return isClaimed
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.yellowFFF0CC,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.yellowFFB400,
                        width: 1,
                      )),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.greyE8E9EB,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final giftsCount = context.watch<AppData>().getGiftsCount;
    final hasPreviousGifts = context.watch<AppData>().hasPreviousGifts;

    return Container(
      padding: const EdgeInsets.fromLTRB(11, 30, 11, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            title: 'A free gift awaits…',
            type: TitleTextType.mainHomeTitle,
            customPadding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          TitleText(
            title: giftsCount < 5
                ? 'Complete 5 sessions and get a free gift'
                : 'You have completed 5 sessions with us 🎉 ',
            type: TitleTextType.secondaryTitle,
            customPadding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          Visibility(
            visible: giftsCount < 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _giftLogo(giftsCount >= 1),
                  _giftLogo(giftsCount >= 2),
                  _giftLogo(giftsCount >= 3),
                  _giftLogo(giftsCount >= 4),
                  _giftLogo(giftsCount >= 5),
                ],
              ),
            ),
          ),
          Visibility(
            visible: giftsCount >= 5,
            child: FilledButtonWidget(
              onPress: () {
                ShowLoadingDialog(context);
                context.read<AppData>().claimFreeGiftRequest().then((response) {
                  context.read<AppData>().fetchAndSetGifts().then((_) {
                    ShowLoadingDialog(context, dismiss: true);
                    if (response?.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoyaltyPage(),
                        ),
                      );
                    } else {
                      ShowOkDialog(
                        context,
                        response?.message ?? ErrorMessages.somethingWrong,
                      );
                    }
                  });
                });
              },
              type: ButtonType.outlinedYellow,
              title: 'Claim free gift 🎁',
              margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            ),
          ),
          Visibility(
            visible: hasPreviousGifts == true && giftsCount < 5,
            child: InkWell(
              onTap: () {
                ShowLoadingDialog(context);
                context.read<AppData>().fetchAndSetGifts().then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoyaltyPage(),
                      ),
                    );
                  } else {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Show previous gifts',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey5C6671,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0, left: 4),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: AppColors.grey5C6671,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
