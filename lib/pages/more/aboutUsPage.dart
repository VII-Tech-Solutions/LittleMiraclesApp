//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
//PAGES

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithBack(
        title: 'About Us',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 30),
        child: Column(
          children: [
            Text(
              '''Hello!

Our photography takes a colorful and whimsical approach to capturing your little miracles. From all of those special firsts to those adorable little moments that make you smile, we at Little Miracles capture the milestones of life.

It is an honor and a joy to meet you and we can’t wait to capture your little miracles.


XOXO,
LMS Team''',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black45515D,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Image.asset(
                'assets/images/about_us.png',
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
