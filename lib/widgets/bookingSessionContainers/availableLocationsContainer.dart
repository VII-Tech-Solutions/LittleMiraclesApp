//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../providers/bookings.dart';
import '../../widgets/texts/titleText.dart';

//EXTENSIONS

class AvailableLocationContainer extends StatefulWidget {
  const AvailableLocationContainer();

  @override
  State<AvailableLocationContainer> createState() =>
      _AvailableLocationContainerState();
}

class _AvailableLocationContainerState
    extends State<AvailableLocationContainer> {
  int _selectedLocation = 1;

  late final _textFieldController;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    final bookingsBody = context.read<Bookings>().bookingsBody;
    if (_selectedLocation == 1) {
      context
          .read<Bookings>()
          .amendBookingBody({'backdrops': bookingsBody['backdrops'] ?? []});
    } else {
      context.read<Bookings>().removeKeyFromBookinBody('backdrops');
    }
    return Visibility(
      visible: package?.outdoorAllowed == true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            title: 'Available Locations',
            type: TitleTextType.subTitleBlack,
            weight: FontWeight.w800,
            customPadding: const EdgeInsets.only(bottom: 10),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.greyD0D3D6,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GridView(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 11,
                    mainAxisExtent: 28,
                    crossAxisCount: 2,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLocation = 1;
                        });
                        context
                            .read<Bookings>()
                            .removeKeyFromBookinBody('location_link');
                        context.read<Bookings>().amendBookingBody(
                            {'backdrops': bookingsBody['backdrops'] ?? []});
                      },
                      child: Container(
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedLocation == 1
                              ? AppColors.black45515D
                              : AppColors.greyF2F3F3,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Studio',
                          style: TextStyle(
                            color: _selectedLocation == 1
                                ? Colors.white
                                : AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLocation = 2;
                        });
                        context.read<Bookings>().amendBookingBody({
                          'location_link':
                              '${_textFieldController.text.toString()}'
                        });
                      },
                      child: Container(
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedLocation == 2
                              ? AppColors.black45515D
                              : AppColors.greyF2F3F3,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Outdoors',
                          style: TextStyle(
                            color: _selectedLocation == 2
                                ? Colors.white
                                : AppColors.black45515D,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _selectedLocation == 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFormField(
                      controller: _textFieldController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<Bookings>()
                              .amendBookingBody({'location_link': '$value'});
                          context
                              .read<Bookings>()
                              .removeKeyFromBookinBody('backdrops');
                        } else {
                          context
                              .read<Bookings>()
                              .removeKeyFromBookinBody('location_link');
                          context.read<Bookings>().amendBookingBody(
                              {'backdrops': bookingsBody['backdrops'] ?? []});
                        }
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 11.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greyD0D3D6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greyD0D3D6),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greyD0D3D6),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: 'Outdoor Location link',
                        hintStyle: TextStyle(
                          color: AppColors.greyD0D3D6,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
