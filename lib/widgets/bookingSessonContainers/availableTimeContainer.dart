//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class AvailableTimeContainer extends StatefulWidget {
  const AvailableTimeContainer({Key? key}) : super(key: key);

  @override
  State<AvailableTimeContainer> createState() => _AvailableTimeContainerState();
}

class _AvailableTimeContainerState extends State<AvailableTimeContainer> {
  String selectedValue = '';
  bool isSelected = false;

  List availableTimes = [
    '03:00 PM',
    '04:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '10:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'Available Times',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          height: 100,
          child: _buildTimeSlots(),
        ),
      ],
    );
  }

  _buildTimeSlots() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      //physics: NeverScrollableScrollPhysics(),
      itemCount: availableTimes.length,
      itemBuilder: (context, index) {
        final item = availableTimes[index];

        return InkWell(
          onTap: () {
            setState(() {
              isSelected = true;
              if (isSelected) {
                selectedValue = availableTimes[index];
              } else {
                selectedValue = '';
              }
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 111,
            height: 28,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            decoration: BoxDecoration(
              color: availableTimes[index] == selectedValue
                  ? AppColors.black45515D
                  : AppColors.greyF2F3F3,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: availableTimes[index] == selectedValue
                    ? AppColors.black45515D
                    : AppColors.greyF2F3F3,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: availableTimes[index] == selectedValue
                      ? Colors.white
                      : AppColors.black45515D,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
