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
  int? _value;

  List availableTimes = [
    '03:00 PM',
    '04:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
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
        _buildTimeSlots(),
      ],
    );
  }

  _buildTimeSlots() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.greyD0D3D6,
          width: 1,
        ),
      ),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: availableTimes.map(
          (val) {
            return Container(
              width: 111,
              child: ChoiceChip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5.0),
                selectedShadowColor: null,
                elevation: 0,
                pressElevation: 0,
                label: Text(
                  val,
                  style: TextStyle(
                    color: _value == availableTimes.indexOf(val)
                        ? Colors.white
                        : AppColors.black45515D,
                  ),
                ),
                selected: _value == availableTimes.indexOf(val),
                selectedColor: _value == availableTimes.indexOf(val)
                    ? AppColors.black45515D
                    : AppColors.greyF2F3F3,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? availableTimes.indexOf(val) : null;
                  });
                },
              ),
            );
          },
        ).toList(),
      ),
    );

    // return ListView.builder(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   //physics: NeverScrollableScrollPhysics(),
    //   itemCount: availableTimes.length,
    //   itemBuilder: (context, index) {
    //     final item = availableTimes[index];

    //     return InkWell(
    //       onTap: () {
    //         setState(() {
    //           isSelected = true;
    //           if (isSelected) {
    //             selectedValue = availableTimes[index];
    //           } else {
    //             selectedValue = '';
    //           }
    //         });
    //       },
    //       child: AnimatedContainer(
    //         duration: Duration(milliseconds: 200),
    //         width: 111,
    //         height: 28,
    //         margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
    //         decoration: BoxDecoration(
    //           color: availableTimes[index] == selectedValue
    //               ? AppColors.black45515D
    //               : AppColors.greyF2F3F3,
    //           borderRadius: BorderRadius.circular(24.0),
    //           border: Border.all(
    //             color: availableTimes[index] == selectedValue
    //                 ? AppColors.black45515D
    //                 : AppColors.greyF2F3F3,
    //             width: 1,
    //           ),
    //         ),
    //         child: Center(
    //           child: Text(
    //             item,
    //             style: TextStyle(
    //               fontSize: 12,
    //               fontWeight: FontWeight.w600,
    //               color: availableTimes[index] == selectedValue
    //                   ? Colors.white
    //                   : AppColors.black45515D,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
