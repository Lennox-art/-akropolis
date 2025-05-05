extension NameExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${length > 1 ? substring(1): ''}';
}