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
}
