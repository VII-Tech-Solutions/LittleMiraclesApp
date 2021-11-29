//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/buttons/filledButtonWidget.dart';
//PAGES
import 'customBottomNavigationBar.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _selectedPage = 0;
  List<Image> images = [];

  //
  @override
  void initState() {
    super.initState();

    images.insert(
      0,
      Image.network(
        'https://i.picsum.photos/id/73/2000/3000.jpg?hmac=Jspw7y56WDEQnVpO7SljydpKPiuykaswRil7QwFY9mU',
        fit: BoxFit.cover,
      ),
    );
    images.insert(
      1,
      Image.network(
        'https://i.picsum.photos/id/820/2000/3000.jpg?hmac=NkZ9UIBB8GPKFhlvBtGnoO2nYn_J_GwMq1Ay57QO_0M',
        fit: BoxFit.cover,
      ),
    );
    images.insert(
      2,
      Image.network(
        'https://i.picsum.photos/id/5/2000/3000.jpg?hmac=513kUuGPVkVcvFLEsVyDcCSm48jRQ9N7euwpd-LskD8',
        fit: BoxFit.cover,
      ),
    );
  }

//Prefetches an image into the image cache.
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
              _buildPageWidget(0, 'Capture Special Moments',
                  'Get professional portraits and capture those special moments with your little miracles. They’re only little for a little while.'),
              _buildPageWidget(1, 'The right milestones',
                  'Make every milestone count. From maternity, to welcoming your newborn, to their 1st birthday. Find the right package to capture these milestones.'),
              _buildPageWidget(2, 'Book in seconds',
                  'We’ll stay in touch with you as your due date approaches to fit you in at the perfect time. Book your session in advance and we’ll take care of the rest.'),
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
            margin: EdgeInsets.fromLTRB(
              size.width * 0.08,
              size.height * 0.5,
              size.width * 0.08,
              size.height * 0.05,
            ),
            onPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            type: ButtonType.generalWhite,
            title: 'Skip Onboarding',
          ),
        ],
      ),
    );
  }
}
