//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
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
  List<int> list = [1];
  Map<int, List<int>> cakes = {
    1: [1, 2],
    2: [3, 5]
  };

  List<Map<String, dynamic>> something2 = [];

  Map<int, Map<String, dynamic>> _subSessionsTemporaryBooked = {
    1: {
      'sub_package_id': 1,
      'date': 2022 - 02 - 02,
      'time': '9:00 AM',
      'include_me': true,
      'people': [6],
      'backdrops': [3],
      'cakes': [3],
      'photographer': 2
    },
    2: {
      'sub_package_id': 2,
      'date': 2022 - 02 - 02,
      'time': '10:00 AM',
      'include_me': true,
      'people': [5, 6],
      'backdrops': [3],
      'cakes': [3],
      'photographer': 2
    }
  };

  Map<String, dynamic> something = {
    "package_id": 5,
    "date": "2021-12-30",
    "time": "12:00 PM",
    "payment_method": 1,
    "comments": "",
    // "sub_sessions": [
    //   {
    //     "sub_package_id": 1,
    //     "date": "2022-01-01",
    //     "time": "12:00PM",
    //     "include_me": true,
    //     "people": [1, 2],
    //     "backdrops": [1, 2],
    //     "cakes": [1, 2],
    //     "photographer": 1,
    //     "custom_backdrop": null,
    //     "custom_cake": null
    //   },
    //   {
    //     "sub_package_id": 2,
    //     "date": "2020-02-01",
    //     "time": "12:00PM",
    //     "include_me": true,
    //     "people": [1, 2],
    //     "backdrops": [1, 2],
    //     "cakes": [1, 2],
    //     "photographer": 1,
    //     "custom_backdrop": null,
    //     "custom_cake": null
    //   },
    //   {
    //     "sub_package_id": 3,
    //     "date": "2022-03-01",
    //     "time": "12:00PM",
    //     "include_me": true,
    //     "people": [1, 2],
    //     "backdrops": [1, 2],
    //     "cakes": [1, 2],
    //     "photographer": 1,
    //     "custom_backdrop": null,
    //     "custom_cake": null
    //   },
    //   {
    //     "sub_package_id": 4,
    //     "date": "2022-04-01",
    //     "time": "12:00PM",
    //     "include_me": true,
    //     "people": [1, 2],
    //     "backdrops": [1, 2],
    //     "cakes": [1, 2],
    //     "photographer": 1,
    //     "custom_backdrop": null,
    //     "custom_cake": null
    //   }
    // ]
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
                print(list.firstWhereOrNull((element) => element == 2));
              },
              child: Container(
                width: double.infinity,
                height: 100,
                color: Colors.red,
              ),
            ),
            InkWell(
              onTap: () {
                // print(something.containsKey('sub_sessions'));
                // final something2 =
                //     something['sub_sessions'] as List<Map<String, dynamic>>;

                print(_subSessionsTemporaryBooked);

                _subSessionsTemporaryBooked.addAll({
                  1: {
                    'sub_package_id': 1,
                    'date': 2022 - 02 - 02,
                    'time': '9:00 AM',
                    'include_me': true,
                    'people': [6],
                    'backdrops': [3],
                    'cakes': [3],
                    'photographer': 2
                  },
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
