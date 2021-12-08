//PACKAGES
import 'package:flutter/material.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0, right: 6.0),
      height: 133,
      width: 287,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: AppColors.greyD0D3D6,
                width: 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: const Text('ZM'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            children: [
                              Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.black45515D,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: AppColors.yellowFFB400,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Amal Jassim',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.black45515D,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '10, JAN 2022',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.grey737C85,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 6.0),
                            child: Text(
                              'The most wonderful photography studio! My baby was happy' +
                                  'the entire time and the cake smash photo turned out amazing ♥️😍',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.black45515D),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
