//PACKAGES
import 'package:flutter/material.dart';
//EXTENSIONS
//GLOBAL
import '../../global/colors.dart';
//MODELS
//PROVIDERS
//WIDGETS
import '../../widgets/general/cachedImageWidget.dart';
//PAGES

class SelectionRow extends StatefulWidget {
  final List? list;
  const SelectionRow(this.list);

  @override
  _SelectionRowState createState() => _SelectionRowState();
}

class _SelectionRowState extends State<SelectionRow> {
  int? val;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.list!.length; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
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
                        Container(
                          height: 68,
                          width: 68,
                          margin: const EdgeInsets.all(16.0),
                          child: CachedImageWidget(
                            widget.list?[i].image ?? '',
                            ImageShape.square,
                          ),
                        ),
                        Text(
                          widget.list?[i].title ?? '',
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
                      value: widget.list?[i].id as int,
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
    );
  }
}
