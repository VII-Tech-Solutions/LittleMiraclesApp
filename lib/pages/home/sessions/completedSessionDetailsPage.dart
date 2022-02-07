//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
//EXTENSION
import '../../../extensions/stringExtension.dart';
//GLOBAL
import '../../../global/colors.dart';
import '../../../global/const.dart';
//MODELS
//PROVIDERS
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/appbars/appBarWithBack.dart';
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/containers/rateSessionContainer.dart';
import '../../../widgets/general/cachedImageWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
//PAGES
import './sessionFeedbackPage.dart';

class CompletedSessionDetailsPage extends StatelessWidget {
  const CompletedSessionDetailsPage();

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://i.picsum.photos/id/504/200/300.jpg?hmac=mycti8qYrnGcag5zUhsVOq7hQwb__R-Zf--aBJAH_ec',
      'https://i.picsum.photos/id/384/200/300.jpg?hmac=XxaMr3mI-4OhEVSNwfLw4oqF4Je819ACxZKz52AzXvQ',
      'https://i.picsum.photos/id/66/200/300.jpg?hmac=zvcP8mVCNIMoM5f8iC-xSgDhR1VklmBY2SON28P4TOo',
      'https://i.picsum.photos/id/603/200/300.jpg?hmac=7egn04uCRc_cYvj1RxmKD8W1ySpBC3Ut8GFrvACb4x0',
    ];

    final size = MediaQuery.of(context).size;

    final session = context.watch<AppData>().session;

    return Scaffold(
      appBar: AppBarWithBack(elevation: 0.0),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      session?.title ?? '',
                      maxLines: 3,
                      style: TextStyle(
                        color: AppColors.black45515D,
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        session?.date.toString().toSlashddMMMyyyy() ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: AppColors.black45515D,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                padding: const EdgeInsets.only(left: 0, top: 25, bottom: 25),
                child: Swiper(
                  itemHeight: size.height * 0.6,
                  itemWidth: size.width * 0.8,
                  loop: true,
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.0135),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: Offset(-5, 0),
                          ),
                        ],
                      ),
                      child: CachedImageWidget(
                        images[index],
                        ImageShape.square,
                      ),
                    );
                  },
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
                margin: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30.0),
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
                onPress: () {
                  ShowLoadingDialog(context);
                  context
                      .read<Bookings>()
                      .fetchAndSetFeedbackQuestions()
                      .then((response) {
                    ShowLoadingDialog(context, dismiss: true);
                    if (response?.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionFeedbackPage(),
                        ),
                      );
                    } else {
                      ShowOkDialog(
                        context,
                        response?.message ?? ErrorMessages.somethingWrong,
                      );
                    }
                  });
                },
                title: 'Complete a customer feedback form',
                type: ButtonType.generalGrey,
                margin: const EdgeInsets.symmetric(vertical: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
