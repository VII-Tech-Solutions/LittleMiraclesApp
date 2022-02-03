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
  final String? preSelectedTime;
  final void Function(Map<String, dynamic>?)? onChangeCallback;
  const AvailableTimeContainer({
    this.preSelectedTime,
    this.onChangeCallback = null,
  });

  @override
  State<AvailableTimeContainer> createState() => _AvailableTimeContainerState();
}

class _AvailableTimeContainerState extends State<AvailableTimeContainer> {
  String _selectedTime = "";

  @override
  void initState() {
    if (widget.preSelectedTime != null) {
      _selectedTime = widget.preSelectedTime!;
    }

    if (widget.onChangeCallback != null) {
      if (_selectedTime.isNotEmpty)
        widget.onChangeCallback!({'time': _selectedTime});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableTimes = context.watch<Bookings>().availableTimings;
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
                    _selectedTime = availableTimes[index];
                    if (widget.onChangeCallback != null) {
                      widget.onChangeCallback!({'time': _selectedTime});
                    } else {
                      context
                          .read<Bookings>()
                          .amendBookingBody({'time': _selectedTime});
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedTime == availableTimes[index]
                        ? AppColors.black45515D
                        : AppColors.greyF2F3F3,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    availableTimes[index],
                    style: TextStyle(
                      color: _selectedTime == availableTimes[index]
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
