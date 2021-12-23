//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/auth.dart';
//WIDGETS
import '../../widgets/texts/titleText.dart';
import '../../widgets/bookingSessonContainers/labeledCheckbox.dart';
//PAGES

class JoiningPeopleContainer extends StatefulWidget {
  const JoiningPeopleContainer({Key? key}) : super(key: key);

  @override
  State<JoiningPeopleContainer> createState() => _JoiningPeopleContainerState();
}

class _JoiningPeopleContainerState extends State<JoiningPeopleContainer> {
  List<int?> _selectedPeople = [];

  void _selectPerson(int? id) {
    print(_selectedPeople.length);
    setState(() {
      if (_selectedPeople.contains(id)) {
        _selectedPeople.removeWhere((element) => element == id);
      } else {
        _selectedPeople.add(id);
      }
    });

    print(_selectedPeople.length);
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
                          '${_selectedPeople.length}',
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
                id: user?.id,
                label: '${user?.firstName} ${user?.lastName}',
                isUser: true,
                isSelected: _selectedPeople.contains(user?.id),
                onTapCallback: (val) {
                  _selectPerson(val);
                },
              ),
              // LabeledCheckbox(),
            ],
          ),
        ),
      ],
    );
  }
}
