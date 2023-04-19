//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../extensions/stringExtension.dart';
import '../../global/colors.dart';
import '../../providers/auth.dart';

//EXTENSION

class RegistrationAccountTypeContainer extends StatelessWidget {
  const RegistrationAccountTypeContainer();

  @override
  Widget build(BuildContext context) {
    final user = context.read<Auth>().user;
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 0.0),
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.pinkFCE0DC,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 45,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: user?.avatar ?? "",
                    height: 30,
                    width: 30,
                    placeholder: (context, url) => Container(
                      color: AppColors.grey737C85,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.grey737C85,
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: user?.provider != null,
                  child: Positioned(
                    bottom: 0,
                    right: 7.5,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColors.pinkFCE0DC,
                          width: 1.5,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/iconsSocial${user?.provider?.firstLetterToUpper()}.svg',
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(
            '${user?.provider?.firstLetterToUpper().firstLetterToUpper()} Account',
            style: TextStyle(
              color: AppColors.black45515D,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
