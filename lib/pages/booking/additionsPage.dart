//PACKAGES
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
import '../../providers/appData.dart';
import '../../providers/bookings.dart';
//WIDGETS
import '../../widgets/appbars/appBarWithBack.dart';
import '../../widgets/general/cachedImageWidget.dart';
import '../../widgets/packageContainers/packageBottomSectionContainer.dart';
import '../../widgets/bookingSessonContainers/selectionRow.dart';
import '../../widgets/dialogs/showOkDialog.dart';
//PAGES
import './reviewAndPayPage.dart';

class AdditionsPage extends StatefulWidget {
  const AdditionsPage({Key? key}) : super(key: key);

  @override
  _AdditionsPageState createState() => _AdditionsPageState();
}

class _AdditionsPageState extends State<AdditionsPage> {
  List<int> _selectedItems = [];
  @override
  Widget build(BuildContext context) {
    final photographers = context.watch<AppData>().photographers;

    return Scaffold(
      appBar: AppBarWithBack(
        'Additions',
        weight: FontWeight.w800,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Select photo prints to add to your package',
              style: TextStyle(
                fontSize: 18,
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.w800,
                color: AppColors.black45515D,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' (optional)',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black45515D,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: photographers.length,
            itemBuilder: (BuildContext context, int index) {
              return SelectionRow(
                () {
                  setState(() {
                    if (_selectedItems.contains(index)) {
                      _selectedItems.removeWhere((element) => element == index);
                    } else {
                      _selectedItems.clear();
                      _selectedItems.add(index);
                    }
                  });
                },
                '',
                null,
                'Album',
                _selectedItems.contains(index),
                1,
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: PackageBottomSectionContainer(
        btnLabel: 'Next',
        onTap: () {
          context
              .read<Bookings>()
              .amendBookingBody({'additions': _selectedItems});
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewAndPayPage(),
            ),
          );
        },
      ),
    );
  }
}
