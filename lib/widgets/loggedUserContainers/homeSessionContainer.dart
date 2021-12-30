//PACKAGES
import 'package:flutter/material.dart';
//EXTENSION
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
import '../../global/const.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES
import '../../pages/session/completedSessionDetailsPage.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: session?.status == 5 ? Colors.white : AppColors.blueE8F3F5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompletedSessionDetailsPage(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 177,
                width: double.infinity,
                child: CachedImageWidget(
                  //TODO:: chage it to session image
                  'https://i.picsum.photos/id/102/343/177.jpg?hmac=e1sICk0f4rw_aK6rvEOObRMe3OPobO35sP3CUiIZJCE',
                  ImageShape.rectangle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      session?.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      session?.date.toString().toSlashddMMMyyyy() ?? '',
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
      ),
    );
  }
}
