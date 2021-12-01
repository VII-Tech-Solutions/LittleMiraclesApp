//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
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
    final dailyTipList = context.read<AppData>().dailyTips;
    final promotionList = context.read<AppData>().promotions;
    final workshopList = context.read<AppData>().workshops;

    print(dailyTipList.length);
    print(promotionList.length);
    print(workshopList.length);

    return Scaffold(
      body: ListView(
        children: [
          CustomText(
            title: 'Your daily tip',
            type: CustomTextType.mainHomeTitle,
          ),
          TipContainer(dailyTipList.first),
          CustomText(
            title: 'Promotions',
            type: CustomTextType.mainHomeTitle,
          ),
          PromotionContainer(promotionList.last),
          CustomText(
            title: 'Workshop',
            type: CustomTextType.mainHomeTitle,
          ),
          WorkshopContainer(workshopList.first),
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
                'https://i.picsum.photos/id/127/343/450.jpg?hmac=4XbgfyFPlCRsfVUZRRFdMC7K_314nhISKohXg3wKZBI',
          ),
        ],
      ),
    );
  }
}
