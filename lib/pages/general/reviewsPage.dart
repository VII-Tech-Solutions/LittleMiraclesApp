//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithClose.dart';
import '../../widgets/containers/rateSessionContainer.dart';
import '../../widgets/containers/reviewContainer.dart';
//PAGES

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final controller = TextEditingController();
  final items = [
    ReviewContainer(borderColor: AppColors.whiteFFFFFF),
    ReviewContainer(borderColor: AppColors.whiteFFFFFF),
    ReviewContainer(borderColor: AppColors.whiteFFFFFF),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithClose('Reviews', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RateSessionContainer(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              padding: EdgeInsets.only(left: 16, right: 10),
              itemBuilder: (ctx, index) {
                return items[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}
