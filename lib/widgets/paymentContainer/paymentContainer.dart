//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/providers/appData.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class PaymentContainer extends StatefulWidget {
  const PaymentContainer({Key? key}) : super(key: key);

  @override
  _PaymentContainerState createState() => _PaymentContainerState();
}

class _PaymentContainerState extends State<PaymentContainer> {
  int? val;
  @override
  Widget build(BuildContext context) {
    final list = context.watch<AppData>().paymentMethods;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Text(
            'Payment Method',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: AppColors.black45515D,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            for (int i = 0; i < list.length; i++)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.greyD0D3D6,
                  ),
                  color: AppColors.whiteFFFFFF,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   height: 68,
                            //   width: 68,
                            //   margin: const EdgeInsets.all(16.0),
                            //   child: CachedImageWidget(
                            //     list[i].image ?? '',
                            //     ImageShape.square,
                            //   ),
                            // ),
                            Text(
                              list[i].title ?? '',
                              style: TextStyle(
                                color: AppColors.black45515D,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Radio(
                          value: list[i].id as int,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value as int?;
                            });
                          },
                          activeColor: AppColors.blue8DC4CB,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
