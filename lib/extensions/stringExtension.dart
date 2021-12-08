extension StringExtension on String {
  String firstLetterToUpper() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
