import 'package:LMP0001_LittleMiraclesApp/global/colors.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/admin/bookingDetailsContainer.dart';
import 'package:LMP0001_LittleMiraclesApp/widgets/appbars/appBarWithBack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminBookingDetailPage extends StatefulWidget {
  final sessionDetails;
  AdminBookingDetailPage({this.sessionDetails});

  @override
  State<AdminBookingDetailPage> createState() => _AdminBookingDetailPageState();
}

class _AdminBookingDetailPageState extends State<AdminBookingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        title: 'Booking Details',
        weight: FontWeight.w800,
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          BookingDetailsContainer(widget.sessionDetails),
          SizedBox(height: 22),
          // Container(
          //   height: 110,
          //   width: double.infinity,
          //   margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
          //   padding: EdgeInsets.all(15),
          //   decoration: BoxDecoration(
          //     color: AppColors.blueE8F3F5,
          //     borderRadius: BorderRadius.circular(8),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       RichText(
          //         textAlign: TextAlign.left,
          //         text: TextSpan(
          //             text: 'Parent Name: ',
          //             style: TextStyle(
          //               fontFamily: GoogleFonts.manrope().fontFamily,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 14,
          //               color: AppColors.black45515D,
          //             ),
          //             children: [
          //               TextSpan(
          //                 text: 'Brenda Arnold',
          //                 style: TextStyle(
          //                   fontFamily: GoogleFonts.manrope().fontFamily,
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 14,
          //                   color: AppColors.black45515D,
          //                 ),
          //               )
          //             ]),
          //       ),
          //       RichText(
          //         textAlign: TextAlign.left,
          //         text: TextSpan(
          //             text: 'Child Name: ',
          //             style: TextStyle(
          //               fontFamily: GoogleFonts.manrope().fontFamily,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 14,
          //               color: AppColors.black45515D,
          //             ),
          //             children: [
          //               TextSpan(
          //                 text: 'Adam Bing',
          //                 style: TextStyle(
          //                   fontFamily: GoogleFonts.manrope().fontFamily,
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 14,
          //                   color: AppColors.black45515D,
          //                 ),
          //               )
          //             ]),
          //       ),
          //       RichText(
          //         textAlign: TextAlign.left,
          //         text: TextSpan(
          //             text: 'Child Name: ',
          //             style: TextStyle(
          //               fontFamily: GoogleFonts.manrope().fontFamily,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 14,
          //               color: AppColors.black45515D,
          //             ),
          //             children: [
          //               TextSpan(
          //                 text: 'James Bing',
          //                 style: TextStyle(
          //                   fontFamily: GoogleFonts.manrope().fontFamily,
          //                   fontWeight: FontWeight.w700,
          //                   fontSize: 14,
          //                   color: AppColors.black45515D,
          //                 ),
          //               )
          //             ]),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
