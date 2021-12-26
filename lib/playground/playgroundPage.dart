//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//GLOBAL
import '../global/colors.dart';
//MODELS
//PROVIDERS
import '../providers/auth.dart';
import '../providers/appData.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../widgets/dialogs/showLoadingDialog.dart';
//PAGES

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          title: 'Playground',
          type: TitleTextType.mainHomeTitle,
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              final user = context.read<Auth>().user;

              print(user?.id);
              print(user?.providerId);
              print(user?.email);

            },
            child: Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
          ),
          Icon(IconData(0xe8fd, fontFamily: 'MaterialIcons')),
          FilledButtonWidget(
            onPress: () {
              final list = context.read<AppData>().cakeCategories;

              print(list.length);
            },
            type: ButtonType.generalBlue,
          ),
          RatingBarIndicator(
            rating: 4.5,
            itemBuilder: (context, index) => Icon(
              Icons.star_rounded,
              color: AppColors.yellowFFB400,
            ),
            unratedColor: AppColors.greyB9BEC2,
            itemCount: 5,
            itemSize: 50.0,
          ),
          RatingBar(
            initialRating: 3,
            direction: Axis.horizontal,
            // allowHalfRating: true,
            itemCount: 5,

            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rounded,
                color: AppColors.yellowFFB400,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: AppColors.yellowFFB400,
              ),
              empty: Icon(
                Icons.star_outline_rounded,
                color: Colors.black,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }
}
