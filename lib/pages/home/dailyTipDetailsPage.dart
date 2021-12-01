//PACKAGES
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

class DailyTipDetails extends StatefulWidget {
  const DailyTipDetails({Key? key}) : super(key: key);

  @override
  _DailyTipDetailsState createState() => _DailyTipDetailsState();
}

class _DailyTipDetailsState extends State<DailyTipDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Your daily tip',
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
                  'Welcome to Little Miracles by Sherin',
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
            ],
          ),
        ),
      ),
    );
  }
}
