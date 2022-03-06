//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../models/section.dart';
import '../../pages/login/loginPage.dart';
import '../../providers/auth.dart';
import '../../widgets/general/cachedImageWidget.dart';

class ActionContainer extends StatelessWidget {
  final Section section;
  const ActionContainer(this.section);

  // VARIABLES

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (section.goTo) {
          case SectionAction.login:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
            break;
          case SectionAction.packages:
            context.read<Auth>().setSelectedIndex(1);
            break;
          case SectionAction.studio:
            context.read<Auth>().setSelectedIndex(2);
            break;
          default:
            return;
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 450,
              width: double.infinity,
              child: CachedImageWidget(
                section.image ?? '',
                ImageShape.square,
              ),
            ),
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black162534.withOpacity(0.0),
                    AppColors.black162534,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: const EdgeInsets.only(top: 18, bottom: 26.0),
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
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.blue8DC4CB,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Text(
                      section.actionText ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.whiteFFFFFF,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
