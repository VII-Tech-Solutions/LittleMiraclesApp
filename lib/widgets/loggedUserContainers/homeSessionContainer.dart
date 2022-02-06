//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSION
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
import '../../providers/appData.dart';
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES
import '../../pages/home/sessions/upcomingSessionDetailsPage.dart';
import '../../pages/home/sessions/completedSessionDetailsPage.dart';

class HomeSessionContainer extends StatelessWidget {
  final Session? session;
  const HomeSessionContainer(this.session);

  String _statusText() {
    var value = "";
    switch (session?.status) {
      case SessionStatus.booked:
        value = 'Upcoming Session';
        break;

      case SessionStatus.gettingInOrder:
      case SessionStatus.magicMaking:
      case SessionStatus.photoShootDay:
        value = 'In Progress...';
        break;
      default:
        value = 'Completed';
    }
    return value;
  }

  String _sessionDate(BuildContext context) {
    if (session?.subSessionsIds != null) {
      String date = '';
      final subSessionsList =
          context.read<AppData>().getSubSessionsByIds(session?.subSessionsIds);

      if (subSessionsList.isNotEmpty) {
        date = subSessionsList.first.date.toString().toSlashddMMMyyyy();
      }

      return date;
    } else {
      return session?.date.toString().toSlashddMMMyyyy() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: session?.status == 5 ? Colors.white : AppColors.blueE8F3F5,
      padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 27.0),
      child: InkWell(
        onTap: () {
          context.read<AppData>().assignSessionById(session?.id).then((_) {
            if (session?.status == 5) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedSessionDetailsPage(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpcomingSessionDetailsPage(),
                ),
              );
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 177,
              width: double.infinity,
              child: CachedImageWidget(
                session?.featuredImage ?? '',
                ImageShape.rectangle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.688,
                    child: Text(
                      session?.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Text(
                    _sessionDate(context),
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                _statusText(),
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w200,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
