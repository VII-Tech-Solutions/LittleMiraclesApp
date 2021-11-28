//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//GLOBAL
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _selectedPage = 0;

//Main info widget
  Widget _buildPageWidget(
      BuildContext context, int page, String title, String description) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/images/sample.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 18,
                child: SvgPicture.asset(
                    'assets/images/onboarding_$_selectedPage.svg'),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.width * 0.65,
          padding: EdgeInsets.fromLTRB(30, 12, 30, 0),
          color: Colors.white,
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
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 11),
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
    final PageController controller =
        PageController(initialPage: _selectedPage);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _selectedPage = page;
              });
            },
            children: <Widget>[
              _buildPageWidget(context, 0, 'Capture Special Moments',
                  'Get professional portraits and capture those special moments with your little miracles. They’re only little for a little while.'),
              _buildPageWidget(context, 1, 'The right milestones',
                  'Make every milestone count. From maternity, to welcoming your newborn, to their 1st birthday. Find the right package to capture these milestones.'),
              _buildPageWidget(context, 2, 'Book in seconds',
                  'We’ll stay in touch with you as your due date approaches to fit you in at the perfect time. Book your session in advance and we’ll take care of the rest.'),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.7,
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
            margin: EdgeInsets.fromLTRB(30, 40, 30, 54),
            onPress: () {},
            type: ButtonType.generalWhite,
            title: 'Skip Onboarding',
          ),
        ],
      ),
    );
  }
}
