//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/filledButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class PromotionDetails extends StatefulWidget {
  const PromotionDetails({Key? key}) : super(key: key);

  @override
  _PromotionDetailsState createState() => _PromotionDetailsState();
}

class _PromotionDetailsState extends State<PromotionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Promotions',
          style: TextStyle(
            color: AppColors.black45515D,
            fontSize: 18,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
          ),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {
              Navigator.pop(context);
            },
            color: AppColors.greyF2F3F3,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.black45515D,
              size: 24,
            ),
            padding: EdgeInsets.all(8.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.0,
            22.0,
            16.0,
            10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: 177,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.blue8DC4CB,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://i.picsum.photos/id/403/343/177.jpg?hmac=hQDFIyGExoNtQOqkJMORkSfy7n0AVk3wEhmxQ_G1cXU',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColors.blue8DC4CB,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    //todo fix placeholder
                    placeholder: (context, url) => Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Text(
                '01/08/2021',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 16.0,
                ),
                child: Text(
                  'Your First Photoshoot',
                  style: TextStyle(
                    color: AppColors.black45515D,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ' +
                    'eiusmod tempor incididunt ut labore et dolore magna aliqua. Venenatis' +
                    'urna cursus eget nunc scelerisque viverra mauris in. Viverra suspendisse' +
                    'potenti nullam ac tortor vitae. Nibh tellus molestie nunc non. Urna' +
                    'et pharetra pharetra massa massa ultricies mi. Id interdum velit laoreet id donec.',
                style: TextStyle(
                  color: AppColors.black45515D,
                  fontSize: 14,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                height: 80,
                child: Container(
                  width: double.infinity,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.greyF2F3F3,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppColors.greyD0D3D6),
                  ),
                  child: Text(
                    'MINIME123',
                    style: TextStyle(
                      color: AppColors.black45515D,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
              Text(
                '*This gift is valid until 21/12/2021',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                ),
              ),
              FilledButtonWidget(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 49.0,
                ),
                onPress: () {
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    elevation: 2,
                    duration: Duration(seconds: 2),
                    content: Padding(
                      padding: EdgeInsets.fromLTRB(
                        30.0,
                        20.0,
                        30.0,
                        20.0,
                      ),
                      child: Text(
                        'Promo Code Copied',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    backgroundColor: AppColors.black2D3B48,
                    width: 343,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                  Clipboard.setData(
                    ClipboardData(text: 'MINIME123'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                type: ButtonType.generalBlue,
                title: 'Copy Promo Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
