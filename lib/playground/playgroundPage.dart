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
          TitleText(
            title: 'Playground',
            type: TitleTextType.mainHomeTitle,
          ),
        ],
      ),
    );
  }
}
