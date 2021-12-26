//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../general/cachedImageWidget.dart';
//PAGES
import '../../pages/session/completedSessionDetailsPage.dart';

class YourSessionContainer extends StatelessWidget {
  //final Session? session;
  final bool isCompleted;
  const YourSessionContainer(this.isCompleted);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCompleted ? Colors.white : AppColors.blueE8F3F5,
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
                      'Glimmer Newborn Studio Session',
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w800,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '01/08/2021',
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
                  isCompleted ? 'Completed' : 'Upcoming Session',
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
