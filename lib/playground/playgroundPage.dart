//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/popularPackagesContainer.dart';
import 'package:flutter/material.dart';
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
import '../widgets/containers/tipsContainer.dart';
import '../widgets/containers/promotionsContainer.dart';
import '../widgets/texts/globalTexts.dart';
import '../../widgets/containers/workshopContainer.dart';
//PAGES

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: ListView(
          children: [
            mainHomeTitle(context, title: 'Your daily tip'),
            TipsContainer(
              title: 'Welcome to Little Miracles by Sherin',
              url: 'https://via.placeholder.com/373x177',
            ),
            TipsContainer(
              title: 'Baby Safety During Photoshoots',
            ),
            mainHomeTitle(context, title: 'Promotions'),
            PromotionsContainer(
              title: 'Your First Photoshoot',
              url:
                  'https://i.picsum.photos/id/988/343/177.jpg?hmac=hBwZZTySe-hInmpgXTymSq5GxhuoWwIOWCDEJOD26TA',
              percentage: '20% Off',
            ),
            mainHomeTitle(context, title: 'Workshop'),
            WorkshopContainer(
              title: 'Family Photoshoot Workshop',
              price: 'BD40',
              date: '8th, January 2022',
              url:
                  'https://i.picsum.photos/id/845/343/177.jpg?hmac=3g0mRIkagUNhIuKOOnL_mW5BBQYIVeFLddy4X3nuquY',
            ),
            mainHomeTitle(context, title: 'Popular packages'),
            PopularPackagesContainer(
              title: 'The Baby Plan',
              price: 'BHD 650',
              description: 'Maternity, newborn, sitting up, & 1st birthday',
            ),
          ],
        ),
      ),
    );
  }
}
