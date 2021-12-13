//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/bookingSessonContainers/labeledCheckbox.dart';
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/texts/titleText.dart';
//PAGES

class JoiningPeopleContainer extends StatefulWidget {
  const JoiningPeopleContainer({Key? key}) : super(key: key);

  @override
  State<JoiningPeopleContainer> createState() => _JoiningPeopleContainerState();
}

class _JoiningPeopleContainerState extends State<JoiningPeopleContainer> {
  int peopleCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          title: 'How many people joining?',
          type: TitleTextType.subTitleBlack,
          weight: FontWeight.w800,
        ),
        Container(
          height: 212,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.greyD0D3D6,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.do_disturb_on_rounded),
                      color: AppColors.black45515D,
                      iconSize: 32,
                      onPressed: () {
                        peopleCount--;
                        setState(() {
                          if (peopleCount < 0) {
                            peopleCount = 0;
                          }
                        });
                      },
                    ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Icon(
                              Icons.perm_identity_rounded,
                              color: AppColors.greyA2A8AE,
                              size: 24.0,
                            ),
                          ),
                          Text(
                            '$peopleCount',
                            style: TextStyle(
                              color: AppColors.black45515D,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_rounded),
                      color: AppColors.black45515D,
                      iconSize: 32,
                      onPressed: () {
                        setState(() => peopleCount++);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: AppColors.greyD0D3D6,
                thickness: 1,
              ),
              LabeledCheckbox('Hadeel Alhaddad'),
              LabeledCheckbox('Ahmed Abdulla'),
            ],
          ),
        ),
      ],
    );
  }
}
