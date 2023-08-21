//PACKAGES
import 'package:flutter/material.dart';
import '../../global/colors.dart';
import '../../widgets/appbars/appBarWithBack.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage();

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithBack(
        title: 'Contract',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 12, bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              Text(
                '1. The client will reimburse the photographer for any additional costs such as parking, travel, meals and any other reasonable costs incurred.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '2. The deposit is non-refundable and is required to book your session. If the client cancels for any reason the deposit will not be refunded.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '3. Proof images will be delivered via online gallery. The client will provide the Photographer with a written list of images to be prepared for final printing or digital download. Please refer to the investment guide for current pricing.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '4. The client shall assist and cooperate with the photographer in obtaining the desired photographs; taking time to pose, following photographers directions etc. Photographer is not responsible for failure of clients cooperation.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '5. The photographer retains the copyright to all photographs and hereby grants the client non-exclusive rights to display the images on social media. You may not enter the images into any contest, printed or online, without written consent from the photographer.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '6. The session package does not include any print images; these must be purchased separately. All of our products are printed on the highest quality of professional paper and canvas and are on display in Little Miracles studio.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '7. Un-edited or raw photos are not shared nor will be sent to the client except the selected edited digital images included in the packages.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '8. The selection of the photos in the packages will be done by the team at Little Miracles (Photographer and Editors).',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '9. Please be on time. After the first 14 mins, BD 12 late fees will be charged for every 14 mins of delay.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
