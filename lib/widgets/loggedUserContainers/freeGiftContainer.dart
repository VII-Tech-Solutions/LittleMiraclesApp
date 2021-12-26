//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class FreeGiftContainer extends StatelessWidget {
  const FreeGiftContainer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'A free gift awaits…',
          type: TitleTextType.mainHomeTitle,
          customPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        TitleText(
          title: 'Complete 5 sessions and get a free gift',
          type: TitleTextType.secondaryTitle,
          customPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.yellowFFB400,
                radius: 30.5,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.white,
                  radius: 28,
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColors.yellowFFB400,
                radius: 30.5,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.white,
                  radius: 28,
                ),
              ),
              CircleAvatar(
                radius: 30.5,
                backgroundColor: AppColors.greyE8E9EB,
              ),
              CircleAvatar(
                radius: 30.5,
                backgroundColor: AppColors.greyE8E9EB,
              ),
              CircleAvatar(
                radius: 30.5,
                backgroundColor: AppColors.greyE8E9EB,
              ),
            ],
          ),
        ),
        FilledButtonWidget(
          onPress: () {},
          type: ButtonType.outlinedYellow,
          title: 'Claim free gift 🎁',
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        ),
      ],
    );
  }
}
