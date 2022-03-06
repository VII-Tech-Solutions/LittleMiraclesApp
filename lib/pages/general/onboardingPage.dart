//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../models/onboarding.dart';
import '../../providers/appData.dart';
import '../../providers/auth.dart';
import '../../widgets/buttons/filledButtonWidget.dart';
import './customBottomNavigationBar.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _selectedPage = 0;
  List<Image> images = [];
  late final List<Onboarding> onboardingList;

  //Initiate data
  @override
  void initState() {
    super.initState();

    onboardingList = context.read<AppData>().onboardings;

    images.insert(
      0,
      Image.network(
        '${onboardingList[0].image}',
        fit: BoxFit.cover,
      ),
    );
    images.insert(
      1,
      Image.network(
        '${onboardingList[1].image}',
        fit: BoxFit.cover,
      ),
    );
    images.insert(
      2,
      Image.network(
        '${onboardingList[2].image}',
        fit: BoxFit.cover,
      ),
    );
  }

//Prefetches images into the image cache
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(images[0].image, context);
    precacheImage(images[1].image, context);
    precacheImage(images[2].image, context);
  }

//Main info widget
  Widget _buildPageWidget(int page, String title, String description) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: ShaderMask(
                  shaderCallback: (item) {
                    return LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(
                      Rect.fromLTRB(
                        0,
                        0,
                        item.width,
                        item.height,
                      ),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: images[page],
                ),
              ),
              Positioned(
                bottom: -18,
                right: 20,
                child: SvgPicture.asset('assets/images/onboarding_$page.svg'),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * 0.35,
          padding: EdgeInsets.all(
            size.width * 0.08,
          ),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w800,
                  fontSize: 24.0,
                  letterSpacing: -0.4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                ),
                child: Text(
                  '$description',
                  style: const TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w200,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//Dots widget
  Widget _buildDotWidget(bool isSelected) {
    return Container(
      width: 6,
      height: 6,
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue8DC4CB : AppColors.greyB9BEC2,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final PageController controller =
        PageController(initialPage: _selectedPage);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _selectedPage = page;
              });
            },
            children: <Widget>[
              _buildPageWidget(
                0,
                '${onboardingList[0].title}',
                '${onboardingList[0].content}',
              ),
              _buildPageWidget(
                1,
                '${onboardingList[1].title}',
                '${onboardingList[1].content}',
              ),
              _buildPageWidget(
                2,
                '${onboardingList[2].title}',
                '${onboardingList[2].content}',
              ),
            ],
          ),
          Container(
            height: size.height * 0.3,
            width: 32,
            child: Row(
              children: [
                _buildDotWidget(_selectedPage == 0),
                _buildDotWidget(_selectedPage == 1),
                _buildDotWidget(_selectedPage == 2),
              ],
            ),
          ),
          FilledButtonWidget(
            margin: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 40.0),
            onPress: () {
              final authProvider = context.read<Auth>();
              authProvider.setFirstOpen().then((_) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomBottomNavigationBar(),
                  ),
                  (Route<dynamic> route) => false,
                );
              });
            },
            type: ButtonType.generalGrey,
            title: 'Skip Onboarding',
          ),
        ],
      ),
    );
  }
}
