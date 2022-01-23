//PACKAGES
import 'package:intl/intl.dart';
//EXTENSIONS
//GLOBAL
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

extension DateTimeExtension on DateTime {
  String toyyyyMMdd() {
    var dateFormat = new DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(this);

    return formattedDate;
  }

  String tohhmma() {
    var dateFormat = new DateFormat('hh:mm a');
    final formattedDate = dateFormat.format(this);

    return formattedDate;
  }
}
