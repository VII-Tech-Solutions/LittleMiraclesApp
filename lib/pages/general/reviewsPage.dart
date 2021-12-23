//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
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

  @override
  Widget build(BuildContext context) {
    final reviewsList = context.watch<Bookings>().packageReviews;
    return Scaffold(
      appBar: AppBarWithClose('Reviews', AppColors.pinkFEF2F1),
      backgroundColor: AppColors.pinkFEF2F1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RateSessionContainer('RATE THE SESSION'),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: reviewsList.length,
              padding: EdgeInsets.only(left: 16, right: 10),
              itemBuilder: (ctx, index) => ReviewContainer(
                reviewsList[index],
                borderColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
