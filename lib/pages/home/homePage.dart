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
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            stretch: false,
            toolbarHeight: statusBarHeight - 25,
            backgroundColor: Colors.white,
            expandedHeight: size.height * 0.7 - kBottomNavigationBarHeight,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.pinkFCE6E3,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://littlemiracles.viitech.net/storage/uploads/sections/NPjxgJmn03Xj4FQd.jpg',
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 21, horizontal: 16),
                      child: Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Welcome ',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black45515D,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'to Little\nMiracles by Sherin',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black45515D,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Check out our photo session packages to get you started',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          stretch: false,
          backgroundColor: Colors.white,
          expandedHeight: 175,
          collapsedHeight: 175,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
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
                    margin: const EdgeInsets.only(top: 10),
                  )
                ],
              ),
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
