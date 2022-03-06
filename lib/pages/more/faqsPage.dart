//PACKAGES

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../global/colors.dart';
import '../../models/faq.dart';
import '../../providers/appData.dart';
import '../../widgets/appbars/appBarWithBack.dart';

//EXTENSIONS

class FAQsPage extends StatefulWidget {
  const FAQsPage();

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  List<int> _isExpandedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueF4F9FA,
      appBar: AppBarWithBack(
        title: 'FAQs',
        weight: FontWeight.w800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 40),
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    final list = context.watch<AppData>().faqsList;
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          if (_isExpandedList.contains(list[index].id)) {
            _isExpandedList.removeWhere((element) => element == list[index].id);
          } else {
            _isExpandedList.add(list[index].id ?? -1);
          }
        });
      },
      children: list.map<ExpansionPanel>((FAQ item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: AppColors.blueF4F9FA,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.question ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black45515D,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              item.answer ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.black45515D,
              ),
            ),
          ),
          isExpanded: _isExpandedList.contains(item.id),
        );
      }).toList(),
    );
  }
}
