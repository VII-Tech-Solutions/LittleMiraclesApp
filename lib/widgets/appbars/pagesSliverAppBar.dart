//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../buttons/iconButtonWidget.dart';
//PAGES

class PagesSliverAppBar extends StatelessWidget {
  const PagesSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      stretch: false,
      backgroundColor: Colors.white,
      expandedHeight: 100,
      collapsedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Photo ',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.black45515D,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Sessions 📸',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColors.black45515D,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButtonWidget(
                          onPress: () {
                            print('go to cart');
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(width: 16),
                      IconButtonWidget(
                          onPress: () {
                            print('go to chat');
                          },
                          icon: Icons.forum),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
