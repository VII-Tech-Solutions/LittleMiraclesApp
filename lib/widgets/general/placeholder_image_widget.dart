// Flutter imports:
import 'package:flutter/material.dart';

class PlaceholderImageWidget extends StatelessWidget {
  static const List<String> list = ['blue', 'pink', 'grey'];

  final String orientationLetter;
  final String colorName;

  PlaceholderImageWidget({
    Key? key,
    int index = 0,
    Axis orientation = Axis.horizontal,
  })  : orientationLetter = orientation == Axis.horizontal ? "r" : "s",
        colorName = list[index % list.length],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/placeholder_${orientationLetter}_$colorName.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
