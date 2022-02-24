//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/pages/home/sessions/viewCompletedSessionPhotos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
//EXTENSION
import '../../../extensions/stringExtension.dart';
//GLOBAL
import '../../../global/colors.dart';
import '../../../global/const.dart';
//MODELS
import '../../models/session.dart';
//PROVIDERS
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
//WIDGETS
import '../../../widgets/buttons/filledButtonWidget.dart';
import '../../../widgets/containers/rateSessionContainer.dart';
import '../../../widgets/general/cachedImageWidget.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
//PAGES
import '../../pages/home/sessions/sessionFeedbackPage.dart';
import '../../pages/home/sessions/bookAppointmentPage.dart';

class CompletedSubSessionContainer extends StatelessWidget {
  final Session? subSession;
  const CompletedSubSessionContainer(this.subSession);

  @override
  Widget build(BuildContext context) {
    final images =
        context.watch<AppData>().getSessionMedia(subSession?.mediaIds);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
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
                    subSession?.title ?? '',
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
                      subSession?.date.toString().toSlashddMMMyyyy() ?? '',
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
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.3),
                  border: Border.all(
                    width: 1,
                    color: AppColors.greyD0D3D6,
                  )),
              child: Column(
                children: [
                  Visibility(
                    visible: images.isNotEmpty,
                    replacement: SizedBox(
                      height: 20,
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 10),
                      padding: const EdgeInsets.only(left: 10),
                      child: Swiper(
                        itemHeight: size.height * 0.6,
                        itemWidth: size.width * 0.75,
                        loop: true,
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        layout: SwiperLayout.STACK,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewCompletedSessionPhotos(images[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 6,
                                    offset: Offset(-5, 3),
                                  ),
                                ],
                              ),
                              child: CachedImageWidget(
                                images[index].url,
                                ImageShape.square,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          'Excited for more photos? 😊 Please book an appointment with our ' +
                              'team to see your entire gallery',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 14.0,
                          ),
                        ),
                        Visibility(
                          visible: subSession?.bookingText == null,
                          replacement: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              subSession?.bookingText ?? '',
                              style: TextStyle(
                                color: AppColors.blue8DC4CB,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          child: FilledButtonWidget(
                            onPress: () {
                              ShowLoadingDialog(context);
                              context
                                  .read<Bookings>()
                                  .fetchAndSetAvailableDates()
                                  .then((response) {
                                ShowLoadingDialog(context, dismiss: true);
                                if (response?.statusCode == 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookAppointmentPage(
                                        subSession: subSession,
                                      ),
                                    ),
                                  );
                                } else {
                                  ShowOkDialog(
                                    context,
                                    response?.message ??
                                        ErrorMessages.somethingWrong,
                                  );
                                }
                              });
                            },
                            title: 'Book an Appointment',
                            type: ButtonType.generalGrey,
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyD0D3D6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: RateSessionContainer(
                            subSession: subSession,
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
                                  response?.message ??
                                      ErrorMessages.somethingWrong,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
