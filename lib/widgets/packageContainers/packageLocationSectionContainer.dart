//PACKAGES
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/bookings.dart';
//WIDGETS
//PAGES

class PackageLocationSectionContainer extends StatelessWidget {
  const PackageLocationSectionContainer();

  @override
  Widget build(BuildContext context) {
    final package = context.watch<Bookings>().package;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Studio Location',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.black45515D,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.place_outlined,
                    color: AppColors.black45515D,
                    size: 16.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    package?.locationText ?? '',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (package?.locationLink != null) {
                String url = package?.locationLink ?? ' ';
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                    forceWebView: false,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              }
            },
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: AppColors.greyD0D3D6,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/map.jpg',
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.greyD0D3D6,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Get Directions',
                        style: TextStyle(
                          color: AppColors.black45515D,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
