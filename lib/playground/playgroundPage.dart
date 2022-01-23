//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
import '../providers/bookings.dart';
//WIDGETS
import '../widgets/texts/titleText.dart';
import '../../../widgets/texts/titleText.dart';
//PAGES

class PlayrgoundPage extends StatefulWidget {
  const PlayrgoundPage({Key? key}) : super(key: key);

  @override
  _PlayrgoundPageState createState() => _PlayrgoundPageState();
}

class _PlayrgoundPageState extends State<PlayrgoundPage> {
  Map<int, List<int>> cakes = {
    1: [1, 2],
    2: [3, 5]
  };

  final something = {
    "package_id": 5,
    "date": "2021-12-30",
    "time": "12:00 PM",
    "payment_method": 1,
    "comments": "",
    "sub_sessions": [
      {
        "sub_package_id": 1,
        "date": "2022-01-01",
        "time": "12:00PM",
        "include_me": true,
        "people": [1, 2],
        "backdrops": [1, 2],
        "cakes": [1, 2],
        "photographer": 1,
        "custom_backdrop": null,
        "custom_cake": null
      },
      {
        "sub_package_id": 2,
        "date": "2020-02-01",
        "time": "12:00PM",
        "include_me": true,
        "people": [1, 2],
        "backdrops": [1, 2],
        "cakes": [1, 2],
        "photographer": 1,
        "custom_backdrop": null,
        "custom_cake": null
      },
      {
        "sub_package_id": 3,
        "date": "2022-03-01",
        "time": "12:00PM",
        "include_me": true,
        "people": [1, 2],
        "backdrops": [1, 2],
        "cakes": [1, 2],
        "photographer": 1,
        "custom_backdrop": null,
        "custom_cake": null
      },
      {
        "sub_package_id": 4,
        "date": "2022-04-01",
        "time": "12:00PM",
        "include_me": true,
        "people": [1, 2],
        "backdrops": [1, 2],
        "cakes": [1, 2],
        "photographer": 1,
        "custom_backdrop": null,
        "custom_cake": null
      }
    ]
  };

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
                print(cakes);

                print(cakes.containsKey('2'));

                print(cakes[1]);

                cakes.addAll({
                  2: [1, 3, 4]
                });
              },
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.red,
              ),
            ),
            InkWell(
              onTap: () {
                print(something.containsKey('sub_sessions'));
                final something2 =
                    something['sub_sessions'] as List<Map<String, dynamic>>;

                something2.forEach((element) {
                  print(element);
                });
              },
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.blue,
              ),
            )
          ],
        ));
  }
}
