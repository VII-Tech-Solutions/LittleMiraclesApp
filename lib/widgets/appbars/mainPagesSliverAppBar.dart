//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../pages/cart/cart.dart';
import '../../global/colors.dart';
import '../../pages/chat/rooms.dart';
import '../../providers/auth.dart';
import '../buttons/iconButtonWidget.dart';
import '../dialogs/showLoadingDialog.dart';
import '../dialogs/showOkDialog.dart';

class MainPagesSliverAppBar extends StatelessWidget {
  final String titleFirst;
  final String titleSecond;
  const MainPagesSliverAppBar(this.titleFirst, this.titleSecond);

  @override
  Widget build(BuildContext context) {
    final user = context.read<Auth>().user;
    final isAuth = context.read<Auth>().isAuth;
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      stretch: false,
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * (125 / 812),
      collapsedHeight: MediaQuery.of(context).size.height * (125 / 812),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: '$titleFirst ',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.black45515D,
                        fontFamily: GoogleFonts.manrope().fontFamily,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$titleSecond',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColors.black45515D,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButtonWidget(
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cart(),
                              ),
                            );
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(width: 16),
                      IconButtonWidget(
                          onPress: () {
                            if (isAuth == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomsPage(),
                                ),
                              );
                            } else {
                              ShowOkDialog(context, 'Please login!');
                            }
                          },
                          icon: Icons.forum),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
