//PACKAGES
import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBack.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/buttons/iconButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: IconButtonWidget(
        onPress: () {
          Navigator.maybePop(context);
        },
        icon: Icons.arrow_back,
      ),
      stretch: true,
      backgroundColor: Colors.white,
      expandedHeight: 242,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 37),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.blueE8F3F5,
                AppColors.blue8DC4CB,
              ],
            ),
          ),
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Let\'s ',
              style: TextStyle(
                fontSize: 36,
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.w300,
                color: AppColors.black45515D,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'chat 🤗',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black45515D,
                  ),
                ),
              ],
            ),
          ),
        ),
        stretchModes: [
          StretchMode.zoomBackground,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(context),
        ],
      ),
    );
  }
}
