//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class HomeHeaderSliverAppBar extends StatelessWidget {
  const HomeHeaderSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return SliverAppBar(
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
                child: CachedNetworkImage(
                  height: double.infinity,
                  width: double.infinity,
                  imageUrl:
                      'https://littlemiracles.viitech.net/storage/uploads/sections/NPjxgJmn03Xj4FQd.jpg',
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                  imageBuilder: (context, imageProvider) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  fadeInDuration: Duration(milliseconds: 50),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 21, horizontal: 16),
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
      ),
    );
  }
}