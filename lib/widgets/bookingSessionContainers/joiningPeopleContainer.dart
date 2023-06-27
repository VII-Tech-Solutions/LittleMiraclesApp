//PACKAGES

// Flutter imports:
import 'package:LMP0001_LittleMiraclesApp/widgets/bookingSessionContainers/labeledRadiobox.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../global/const.dart';
import '../../providers/auth.dart';
import '../../providers/bookings.dart';
import '../../widgets/texts/titleText.dart';
import './labeledCheckbox.dart';

//EXTENSIONS

class JoiningPeopleContainer extends StatefulWidget {
  final int includeMe;
  final List<int?>? selectedPeople;
  final void Function(Map<String, dynamic>?)? onChangeCallback;
  const JoiningPeopleContainer({
    this.includeMe = 0,
    this.selectedPeople,
    this.onChangeCallback = null,
  });

  @override
  State<JoiningPeopleContainer> createState() => _JoiningPeopleContainerState();
}

class _JoiningPeopleContainerState extends State<JoiningPeopleContainer> {
  int _userSelected = 0;
  List<int?> _selectedPeople = [];
  int _extraPeopleJoining = 0;

  void _selectPerson(int id) {
    setState(() {
      if (_selectedPeople.contains(id)) {
        _selectedPeople.removeWhere((element) => element == id);
      } else {
        _selectedPeople.add(id);
      }
    });
    if (widget.onChangeCallback != null) {
      widget.onChangeCallback!(
          {'people': _selectedPeople, 'extra_people': _extraPeopleJoining});
    } else {
      context.read<Bookings>().amendBookingBody(
          {'people': _selectedPeople, 'extra_people': _extraPeopleJoining});
    }
  }

  void _selectPersonRadio(int id) {
    setState(() {
      if (_selectedPeople.contains(id)) {
        _selectedPeople.removeWhere((element) => element == id);
      } else {
        _selectedPeople.clear();
        if (_userSelected == 1) {
          _userSelected = 0;
        }
        _selectedPeople.add(id);
      }
    });

    context
        .read<Bookings>()
        .amendBookingBody({'people': _selectedPeople, 'include_me': false});
  }

  @override
  void initState() {
    setState(() {
      _userSelected = widget.includeMe;
      if (widget.selectedPeople != null)
        _selectedPeople = widget.selectedPeople!;
    });

    if (widget.onChangeCallback != null) {
      bool includeMeVal = _userSelected == 1 ? true : false;
      widget.onChangeCallback!(
          {'include_me': includeMeVal, 'extra_people': _extraPeopleJoining});
      if (_selectedPeople.isNotEmpty)
        widget.onChangeCallback!(
            {'people': _selectedPeople, 'extra_people': _extraPeopleJoining});
    } else {
      context.read<Bookings>().amendBookingBody(
          {'people': _selectedPeople, 'extra_people': _extraPeopleJoining});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<Auth>().user;
    final bookingBody = context.watch<Bookings>().bookingsBody;
    print(bookingBody['package_id']);
    final bookingsProvider = context.read<Bookings>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'How many people joining?',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
          customPadding: const EdgeInsets.only(top: 20),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(top: 20, bottom: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.greyD0D3D6,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: AppColors.greyE8E9EB,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          child: Icon(
                            Icons.perm_identity_rounded,
                            color: AppColors.greyA2A8AE,
                            size: 24.0,
                          ),
                        ),
                        Text(
                          '${_selectedPeople.length + _userSelected + _extraPeopleJoining}',
                          style: TextStyle(
                            color: AppColors.black45515D,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: AppColors.greyD0D3D6,
                margin: const EdgeInsets.only(top: 20, bottom: 9),
              ),

              bookingBody['package_id'] == PackageIds.twinkleId
                  ? Column(
                      children: [
                        LabeledRadioBox(
                          id: 0,
                          label: '${user?.firstName} ${user?.lastName}',
                          isUser: true,
                          isSelected: _userSelected == 1 ? true : false,
                          onTapCallback: (val) {
                            final bookingsProvider = context.read<Bookings>();
                            setState(() {
                              if (_userSelected == 1) {
                                _userSelected = 0;
                              } else {
                                _userSelected = 1;
                              }
                            });
                            _selectedPeople.clear();

                            bookingsProvider.amendBookingBody({
                              'include_me': _userSelected == 1 ? true : false,
                              'people': []
                            });
                          },
                        ),
                        Column(
                          children: context
                              .watch<Auth>()
                              .familyMembers
                              .map(
                                (e) => e.firstName != null
                                    ? LabeledRadioBox(
                                        id: e.id,
                                        label: '${e.firstName} ${e.lastName}',
                                        isUser: false,
                                        isSelected:
                                            _selectedPeople.contains(e.id),
                                        onTapCallback: (val) {
                                          print(e.familyId);
                                          if (val != null)
                                            _selectPersonRadio(val);
                                        },
                                      )
                                    : Container(),
                              )
                              .toList(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        LabeledCheckbox(
                          id: 0,
                          label: '${user?.firstName} ${user?.lastName}',
                          isUser: true,
                          isSelected: _userSelected == 1 ? true : false,
                          onTapCallback: (val) {
                            setState(() {
                              if (_userSelected == 1) {
                                _userSelected = 0;
                              } else {
                                _userSelected = 1;
                              }
                            });

                            if (widget.onChangeCallback != null) {
                              widget.onChangeCallback!({
                                'include_me': _userSelected == 1 ? true : false,
                                'extra_people': _extraPeopleJoining
                              });
                              widget.onChangeCallback!({
                                'people': _selectedPeople,
                                'extra_people': _extraPeopleJoining
                              });
                            } else {
                              bookingsProvider.amendBookingBody({
                                'include_me': _userSelected == 1 ? true : false,
                                'extra_people': _extraPeopleJoining
                              });
                              bookingsProvider.amendBookingBody({
                                'people': _selectedPeople,
                                'extra_people': _extraPeopleJoining
                              });
                            }
                          },
                        ),
                        Column(
                          children: context
                              .watch<Auth>()
                              .familyMembers
                              .map(
                                (e) => e.firstName != null
                                    ? LabeledCheckbox(
                                        id: e.id,
                                        label: '${e.firstName} ${e.lastName}',
                                        isUser: false,
                                        isSelected:
                                            _selectedPeople.contains(e.id),
                                        onTapCallback: (val) {
                                          // for sparkle pacakge .. we need to save child count ..

                                          if (bookingBody['package_id'] ==
                                              PackageIds.sparkleId) {
                                            if (e.relationship == 2 &&
                                                !_selectedPeople
                                                    .contains(e.id)) {
                                              bookingsProvider.addChildCount();
                                            } else if (e.relationship == 2 &&
                                                _selectedPeople
                                                    .contains(e.id)) {
                                              bookingsProvider
                                                  .subtractChildCount();
                                            }

                                            print("child count " +
                                                bookingsProvider.childCount
                                                    .toString());
                                          }
                                          if (val != null) _selectPerson(val);
                                        },
                                      )
                                    : Container(),
                              )
                              .toList(),
                        ),
                      ],
                    ),
              // donot show additional guests for twinkle i.e booking id == 1
              bookingBody['package_id'] == PackageIds.twinkleId
                  ? SizedBox()
                  : Container(
                      height: 22,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(20, 25, 20, 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Additional guest',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (_extraPeopleJoining > 0) {
                                    setState(() {
                                      _extraPeopleJoining -= 1;
                                      if (widget.onChangeCallback != null) {
                                        widget.onChangeCallback!({
                                          'people': _selectedPeople,
                                          'extra_people': _extraPeopleJoining
                                        });
                                      } else {
                                        context
                                            .read<Bookings>()
                                            .amendBookingBody({
                                          'people': _selectedPeople,
                                          'extra_people': _extraPeopleJoining,
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: AppColors.greyA2A8AE,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  '$_extraPeopleJoining',
                                  style: TextStyle(
                                    color: AppColors.black45515D,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _extraPeopleJoining += 1;
                                    if (widget.onChangeCallback != null) {
                                      widget.onChangeCallback!({
                                        'people': _selectedPeople,
                                        'extra_people': _extraPeopleJoining,
                                      });
                                    } else {
                                      context
                                          .read<Bookings>()
                                          .amendBookingBody({
                                        'people': _selectedPeople,
                                        'extra_people': _extraPeopleJoining,
                                      });
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.greyA2A8AE,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ],
    );
  }
}
