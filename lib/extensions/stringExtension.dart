extension StringExtension on String {
  String firstLetterToUpper() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String apiDob() {
    final removedTabs = this.replaceAll('Birthday\t\t\t\t', '');
    final formattedDate = removedTabs.replaceAll('/', '-');
    return "$formattedDate";
  }
}
