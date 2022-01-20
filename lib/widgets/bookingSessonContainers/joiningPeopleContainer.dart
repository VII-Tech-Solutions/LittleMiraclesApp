//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/bookingSessonContainers/labeledCheckbox.dart';
//PAGES

class JoiningPeopleContainer extends StatefulWidget {
  const JoiningPeopleContainer();

  @override
  State<JoiningPeopleContainer> createState() => _JoiningPeopleContainerState();
}

class _JoiningPeopleContainerState extends State<JoiningPeopleContainer> {
  int _userSelected = 0;
  List<int?> _selectedPeople = [];

  void _selectPerson(int? id) {
    setState(() {
      if (_selectedPeople.contains(id)) {
        _selectedPeople.removeWhere((element) => element == id);
      } else {
        _selectedPeople.add(id);
      }
    });
    context.read<Bookings>().amendBookingBody({'people': _selectedPeople});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<Auth>().user;
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
                          '${_selectedPeople.length + _userSelected}',
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
              LabeledCheckbox(
                id: 0,
                label: '${user?.firstName} ${user?.lastName}',
                isUser: true,
                isSelected: _userSelected == 1 ? true : false,
                onTapCallback: (val) {
                  setState(() {
                    if (_userSelected == 1) {
                      _userSelected = 0;
                      context
                          .read<Bookings>()
                          .amendBookingBody({'include_me': false});
                    } else {
                      _userSelected = 1;
                      context
                          .read<Bookings>()
                          .amendBookingBody({'include_me': true});
                    }
                    context
                        .read<Bookings>()
                        .amendBookingBody({'people': _selectedPeople});
                  });
                },
              ),
              Column(
                children: context
                    .watch<Auth>()
                    .familyMembers
                    .map(
                      (e) => LabeledCheckbox(
                        id: e.id,
                        label: '${e.firstName} ${e.lastName}',
                        isUser: false,
                        isSelected: _selectedPeople.contains(e.id),
                        onTapCallback: (val) {
                          _selectPerson(val);
                        },
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
