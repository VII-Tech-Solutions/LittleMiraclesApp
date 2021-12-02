//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class ActionContainer extends StatelessWidget {
  final String? title;
  final String? url;
  final String? description;

  const ActionContainer(
      {Key? key,
      @required this.title,
      @required this.url,
      @required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo go to Daily Tip deatils page
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 10.0),
        child: Stack(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: '$url',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.blue8DC4CB,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 150,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                30.0,
                192.0,
                29.0,
                40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      '$description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 26.0,
                    ),
                    height: 38,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 128,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.blue8DC4CB,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'See Prints',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.whiteFFFFFF),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
