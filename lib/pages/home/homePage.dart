//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import '../../widgets/buttons/iconButtonWidget.dart';
//PAGES

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          snap: false,
          floating: false,
          backgroundColor: AppColors.pinkFCE6E3,
          expandedHeight: size.height * 0.7 - kBottomNavigationBarHeight,
          flexibleSpace: Container(),
        ),
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: true,
          backgroundColor: Colors.white,
          expandedHeight: 175,
          collapsedHeight: 175,
          stretch: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(16, 19, 16, 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(
                      title: 'Hi there ♥️',
                      type: TitleTextType.mainHomeTitle,
                    ),
                    Row(
                      children: [
                        IconButtonWidget(
                            onPress: () {}, icon: Icons.shopping_cart),
                        SizedBox(width: 16),
                        IconButtonWidget(onPress: () {}, icon: Icons.forum),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19.5),
                  child: Text(
                    'Sign up with us to get the full Little Miracles experience and capture those special moments',
                    style: TextStyle(
                      color: AppColors.black162534,
                    ),
                  ),
                ),
                FilledButtonWidget(
                  onPress: () {
                    print('go to login');
                  },
                  type: ButtonType.generalBlue,
                  title: 'Login',
                  margin: EdgeInsets.only(top: 10),
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
