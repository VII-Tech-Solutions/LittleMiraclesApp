//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class PhotographerPage extends StatefulWidget {
  const PhotographerPage({Key? key}) : super(key: key);

  @override
  _PhotographerPageState createState() => _PhotographerPageState();
}

class _PhotographerPageState extends State<PhotographerPage> {
  @override
  Widget build(BuildContext context) {
    final list = context.watch<AppData>().photographers;
    int? val;

    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Select Photographer',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < list.length; i++)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.greyD0D3D6,
                  ),
                  color: AppColors.whiteFFFFFF,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 68,
                              width: 68,
                              margin: const EdgeInsets.all(16.0),
                              child: CachedImageWidget(
                                list[i].image ?? '',
                                ImageShape.square,
                              ),
                            ),
                            Text(
                              list[i].name ?? '',
                              style: TextStyle(
                                color: AppColors.black45515D,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Radio(
                          value: list[i].id as int,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value as int?;
                            });
                          },
                          activeColor: AppColors.blue8DC4CB,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
