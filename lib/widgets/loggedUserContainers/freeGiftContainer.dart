//PACKAGES
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
      children: [
        TitleText(
          title: 'A free gift awaits…',
          type: TitleTextType.mainHomeTitle,
        ),
        Text(
          'Complete 5 sessions and get a free gift',
          maxLines: 1,
          style: TextStyle(
            color: AppColors.black45515D,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/logo.png'),
              backgroundColor: AppColors.greyE8E9EB,
            )
          ],
        )
      ],
    );
  }
}
