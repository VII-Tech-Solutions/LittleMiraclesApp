//PACKAGES
import 'package:intl/intl.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

extension StringExtension on String {
  String firstLetterToUpper() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String apiDob() {
    final removedTabs = this.replaceAll('Birthday\t\t\t\t', '');
    final formattedDate = removedTabs.replaceAll('/', '-');

    final day = formattedDate.substring(0, 2);
    final month = formattedDate.substring(3, 5);
    final year = formattedDate.substring(6, 10);
    return "$year-$month-$day";
  }

  int toInt() {
    if (this.isEmpty) {
      return 1;
    }
    return int.parse(this);
  }

  String toddMMMyyyy() {
    if (this.isNotEmpty) {
      var dateTimeString = this;
      final dateTime = DateTime.parse(dateTimeString);

      final format = DateFormat('dd, MMM yyyy');
      final formattedDate = format.format(dateTime);
      return formattedDate;
    } else {
      return "";
    }
  }

  String toSlashddMMMyyyy() {
    if (this.isNotEmpty) {
      var dateTimeString = this;
      final dateTime = DateTime.parse(dateTimeString);

      final format = DateFormat('dd/MM/yyyy');
      final formattedDate = format.format(dateTime);
      return formattedDate;
    } else {
      return "";
    }
  }

  int? dateToInt() {
    final formattedDate = this.replaceAll('-', '');

    return int.parse(formattedDate);
  }
}
