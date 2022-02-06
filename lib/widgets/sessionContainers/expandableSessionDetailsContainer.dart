//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../../global/colors.dart';
//MODELS
import '../../../models/session.dart';
//PROVIDERS
//WIDGETS
import '../general/benefitDetailsRow.dart';
import '../texts/titleText.dart';
import './sessionStatusStepperContainer.dart';
import './sessionButtonsContainer.dart';
//PAGES

class ExpandableSessionDetailsContainer extends StatefulWidget {
  final Session subSession;
  const ExpandableSessionDetailsContainer(this.subSession);

  @override
  State<ExpandableSessionDetailsContainer> createState() =>
      _ExpandableSessionDetailsContainerState();
}

class _ExpandableSessionDetailsContainerState
    extends State<ExpandableSessionDetailsContainer>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late final double _collapsedHeight;
  late final double _expandedHeight;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    double collapsedHeight = 19;
    double expandedHeight = 30;

    final subSession = widget.subSession;
    final double stepperHeight = 422;
    final double buttonsHeight = 167;

    if (subSession.formattedDate != null) collapsedHeight += 37;
    if (subSession.time != null) collapsedHeight += 37;
    if (subSession.formattedPeople != null) collapsedHeight += 37;
    if (subSession.formattedBackdrop != null) collapsedHeight += 37;
    if (subSession.formattedCake != null) collapsedHeight += 37;
    if (subSession.photographerName != null) collapsedHeight += 37;

    _collapsedHeight = collapsedHeight;
    expandedHeight += collapsedHeight + stepperHeight + buttonsHeight;
    _expandedHeight = expandedHeight;

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            title: widget.subSession.title ?? '',
            type: TitleTextType.subTitleBlack,
            weight: FontWeight.w800,
            customPadding: const EdgeInsets.only(bottom: 10),
          ),
          InkWell(
            onTap: () {
              if (!isExpanded) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              height: isExpanded == false ? _collapsedHeight : _expandedHeight,
              duration: Duration(milliseconds: 200),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 9.5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyD0D3D6,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 9.5),
                        Visibility(
                          visible: widget.subSession.formattedDate != null,
                          child: BenefitDetailsRow(
                            widget.subSession.formattedDate ?? '',
                            Icons.today_outlined,
                            false,
                          ),
                        ),
                        Visibility(
                          visible: widget.subSession.time != null,
                          child: BenefitDetailsRow(
                            widget.subSession.time ?? '',
                            Icons.access_time,
                            false,
                          ),
                        ),
                        Visibility(
                          visible: widget.subSession.formattedPeople != null,
                          child: BenefitDetailsRow(
                            widget.subSession.formattedPeople ?? '',
                            Icons.perm_identity_rounded,
                            false,
                          ),
                        ),
                        Visibility(
                          visible: widget.subSession.formattedBackdrop != null,
                          child: BenefitDetailsRow(
                            widget.subSession.formattedBackdrop ?? '',
                            Icons.wallpaper,
                            false,
                          ),
                        ),
                        Visibility(
                          visible: widget.subSession.formattedCake != null,
                          child: BenefitDetailsRow(
                            widget.subSession.formattedCake ?? '',
                            Icons.cake_outlined,
                            false,
                          ),
                        ),
                        Visibility(
                          visible: widget.subSession.photographerName != null,
                          child: BenefitDetailsRow(
                            widget.subSession.photographerName ?? '',
                            Icons.photo_camera_outlined,
                            false,
                          ),
                        ),
                        SizedBox(height: 30),
                        SessionStatusStepperContainer(isSubSession: true),
                        SessionButtonContainer(subSession: widget.subSession),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: (_collapsedHeight / 2) - 19),
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5)
                          .animate(_animationController),
                      child: Icon(
                        Icons.expand_more,
                        size: 24,
                        color: AppColors.black5C6671,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
