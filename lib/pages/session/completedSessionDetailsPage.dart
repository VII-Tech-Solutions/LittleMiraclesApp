//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/rateSessionContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/containers/reviewContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/general/cachedImageWidget.dart';
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/completedSessionContainers/topContainer.dart';
//PAGES

class CompletedSessionDetailsPage extends StatelessWidget {
  const CompletedSessionDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(elevation: 0.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Completed',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w200,
                    fontSize: 14.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
                height: 420,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      left: 65,
                      child: Container(
                        width: 279,
                        height: 365,
                        child: CachedImageWidget(
                          'https://i.picsum.photos/id/1062/300/405.jpg?hmac=gDXHdsg-bVFqtLDgyvCvvAvc3MczuCf2VfZwwmCSUIU',
                          ImageShape.square,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 30,
                      child: Container(
                        width: 294,
                        height: 385,
                        child: CachedImageWidget(
                          'https://i.picsum.photos/id/1062/300/405.jpg?hmac=gDXHdsg-bVFqtLDgyvCvvAvc3MczuCf2VfZwwmCSUIU',
                          ImageShape.square,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Container(
                        width: 300,
                        height: 405,
                        child: CachedImageWidget(
                          'https://i.picsum.photos/id/1062/300/405.jpg?hmac=gDXHdsg-bVFqtLDgyvCvvAvc3MczuCf2VfZwwmCSUIU',
                          ImageShape.square,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              spreadRadius: 0,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Excited for more photos? 😊 Please book an appointment with our ' +
                    'team to see your entire gallery',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14.0,
                ),
              ),
              FilledButtonWidget(
                onPress: () {},
                title: 'Book an Appointment',
                type: ButtonType.generalGrey,
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: RateSessionContainer(),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyD0D3D6),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              Text(
                'We would love to hear from you! Please spare us a few minutes ' +
                    'to give us your feedback. It would mean so much to us!',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14.0,
                ),
              ),
              FilledButtonWidget(
                onPress: () {},
                title: 'Complete a customer feedback form',
                type: ButtonType.generalGrey,
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
