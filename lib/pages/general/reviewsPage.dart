//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../../widgets/appbars/appBarWithClose.dart';
import '../../widgets/containers/reviewContainer.dart';

//EXTENSIONS

class ReviewsPage extends StatefulWidget {
  const ReviewsPage();

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
      body: ListView.builder(
        itemCount: reviewsList.length,
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        itemBuilder: (ctx, index) => ReviewContainer(
          reviewsList[index],
          borderColor: Colors.white,
        ),
      ),
    );
  }
}
