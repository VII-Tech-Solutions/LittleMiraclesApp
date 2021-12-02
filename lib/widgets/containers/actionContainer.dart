//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
import '../../models/section.dart';
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class ActionContainer extends StatelessWidget {
  final Section section;
  const ActionContainer(this.section);

  // VARIABLES

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
              child: CachedImageWidget(
                section.image ?? '',
                ImageShape.square,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 192.0, 29.0, 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      section.content ?? '',
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
                          section.actionText ?? '',
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
