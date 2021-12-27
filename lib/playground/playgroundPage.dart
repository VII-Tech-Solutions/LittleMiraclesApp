//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../global/colors.dart';
//MODELS
//PROVIDERS
import '../providers/auth.dart';
import '../providers/appData.dart';
import '../providers/bookings.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
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
              final provider = context.read<Bookings>();

              provider.fetchAndSetAvailableDates().then((value) {
                print(provider.availableDates.first.date);
                print(provider.availableDates.first.timings);
              });
            },
            child: Container(
              width: double.infinity,
              height: 100,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
