//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../../global/const.dart';
import '../../../providers/appData.dart';
import '../../../providers/bookings.dart';
import '../../../widgets/dialogs/showLoadingDialog.dart';
import '../../../widgets/dialogs/showOkDialog.dart';
import '../../global/colors.dart';
import '../../models/session.dart';
import '../../widgets/buttons/filledButtonWidget.dart';

//EXTENSIONS

class RateSessionContainer extends StatefulWidget {
  final Session? subSession;
  const RateSessionContainer({this.subSession});

  @override
  State<RateSessionContainer> createState() => _RateSessionContainerState();
}

class _RateSessionContainerState extends State<RateSessionContainer> {
  late final TextEditingController _textController;
  late final TextEditingController _userRating;

  @override
  void initState() {
    _textController = TextEditingController();
    _userRating = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _userRating.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionId =
        widget.subSession?.id ?? context.watch<AppData>().session?.id;

    return Container(
      height: 284,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.whiteFFFFFF,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RATE THE SESSION',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1,
                color: AppColors.grey737C85,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  height: 49,
                  width: 67,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.pinkFEF2F1,
                  ),
                  child: TextField(
                    controller: _userRating,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                    decoration: InputDecoration(
                      hintText: '4.0',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  updateOnDrag: true,
                  glow: false,
                  itemSize: widget.subSession != null ? 32 : 38,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rounded,
                    color: AppColors.yellowFFB400,
                  ),
                  onRatingUpdate: (rating) {
                    _userRating.text = '$rating';
                  },
                ),
              ],
            ),
            TextField(
              controller: _textController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyF2F3F3,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 11.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyF2F3F3),
                ),
                hintText: 'Add a review (optional)',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: AppColors.black45515D,
                ),
              ),
            ),
            FilledButtonWidget(
              onPress: () {
                if (_userRating.text.isEmpty) {
                  _userRating.text = '4';
                }
                ShowLoadingDialog(context);
                context
                    .read<Bookings>()
                    .submitSessionReview(
                        sessionId, _userRating.text, _textController.text)
                    .then((response) {
                  ShowLoadingDialog(context, dismiss: true);
                  if (response?.statusCode == 200) {
                    ShowOkDialog(
                      context,
                      response?.message ?? 'Thanks for your review.',
                      title: "Yaaay",
                    );
                  } else {
                    ShowOkDialog(
                      context,
                      response?.message ?? ErrorMessages.somethingWrong,
                    );
                  }
                });
              },
              margin: const EdgeInsets.only(top: 16.0),
              type: ButtonType.generalBlue,
              customWidth: 148,
              title: 'Submit Review',
            )
          ],
        ),
      ),
    );
  }
}
