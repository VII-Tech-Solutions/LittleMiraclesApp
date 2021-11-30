//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../../widgets/containers/workshopContainer.dart';
import '../widgets/containers/promotionContainer.dart';
import '../widgets/containers/popularPackageContainer.dart';
import '../widgets/containers/actionContainer.dart';
import '../widgets/containers/tipContainer.dart';
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
      body: ListView(
        children: [
          CustomText(
            title: 'Your daily tip',
            type: CustomTextType.mainHomeTitle,
          ),
          TipContainer(title: 'title'),
          CustomText(
            title: 'Promotions',
            type: CustomTextType.mainHomeTitle,
          ),
          PromotionContainer(
            title: 'Your First Photoshoot',
            url:
                'https://i.picsum.photos/id/988/343/177.jpg?hmac=hBwZZTySe-hInmpgXTymSq5GxhuoWwIOWCDEJOD26TA',
            percentage: '20% Off',
          ),
          CustomText(
            title: 'Workshop',
            type: CustomTextType.mainHomeTitle,
          ),
          WorkshopContainer(
            title: 'Family Photoshoot Workshop',
            price: 'BD40',
            date: '8th, January 2022',
            url:
                'https://i.picsum.photos/id/845/343/177.jpg?hmac=3g0mRIkagUNhIuKOOnL_mW5BBQYIVeFLddy4X3nuquY',
          ),
          CustomText(
            title: 'Popular packages',
            type: CustomTextType.mainHomeTitle,
          ),
          PopularPackageContainer(
            title: 'The Baby Plan',
            price: 'BHD 650',
            description: 'Maternity, newborn, sitting up, & 1st birthday',
          ),
          ActionContainer(
            title: 'Make it memorable',
            description:
                'Get a customized photo album or prints to go with your sessions',
            url:
                'https://i.picsum.photos/id/120/343/450.jpg?hmac=AyIGjf9cKGUSUoz8A2DDjOl1Y5ePGkq0IlKmSO49faE',
          ),
        ],
      ),
    );
  }
}
