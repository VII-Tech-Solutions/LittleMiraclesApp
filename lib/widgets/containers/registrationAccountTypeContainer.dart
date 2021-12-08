//PACKAGES
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//EXTENSION
import '../../extensions/stringExtension.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class RegistrationAccountTypeContainer extends StatelessWidget {
  final String profileUrl;
  final String accountType;
  const RegistrationAccountTypeContainer(this.profileUrl, this.accountType);

  @override
  Widget build(BuildContext context) {
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
                  child: Image.network(
                    'https://lh3.googleusercontent.com/a/AATXAJy-lBvx_gA-szazGoaaJa-ntKdV979P10N0loni=s96-c',
                    height: 30,
                    width: 30,
                  ),
                ),
                Positioned(
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
                      'assets/images/iconsSocial${accountType.firstLetterToUpper()}.svg',
                      width: 15,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(
            '${accountType.firstLetterToUpper()} Account',
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
