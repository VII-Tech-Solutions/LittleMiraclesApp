//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
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

  String selectedTime = "";

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
          customPadding: const EdgeInsets.only(top: 20),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.greyD0D3D6,
              width: 1,
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 28,
              crossAxisCount: 3,
            ),
            itemCount: availableTimes.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedTime = availableTimes[index];
                    context
                        .read<Bookings>()
                        .amendBookingBody({'time': selectedTime});
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedTime == availableTimes[index]
                        ? AppColors.black45515D
                        : AppColors.greyF2F3F3,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    availableTimes[index],
                    style: TextStyle(
                      color: selectedTime == availableTimes[index]
                          ? Colors.white
                          : AppColors.black45515D,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
