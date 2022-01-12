//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//GLOBAL
import '../../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../../widgets/appbars/mainPagesSliverAppBar.dart';
import '../../widgets/texts/titleText.dart';
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class StudioPage extends StatefulWidget {
  const StudioPage({Key? key}) : super(key: key);

  @override
  _StudioPageState createState() => _StudioPageState();
}

class _StudioPageState extends State<StudioPage> {
  @override
  Widget build(BuildContext context) {
    final _list = context.watch<AppData>().studioList;
    return CustomScrollView(
      slivers: <Widget>[
        MainPagesSliverAppBar('Printing', 'Studio ♥️'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: 1 / 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: CachedImageWidget(
                          'https://i.picsum.photos/id/519/500/300.jpg?hmac=83TIFVeExRO0IX7DY_pC9kSeIVFF-hhXAtqQXCSB-os',
                          ImageShape.rectangle,
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.black162534.withOpacity(0.0),
                              AppColors.black162534,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                              customPadding: const EdgeInsets.only(bottom: 5.0),
                              title: 'Photo Albums',
                              type: TitleTextType.containerMainTitle,
                            ),
                            TitleText(
                              customPadding: null,
                              title: 'Starting from BHD 100',
                              type: TitleTextType.subContainerMainTitle,
                              weight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: _list.length,
          ),
        ),
      ],
    );
  }
}
