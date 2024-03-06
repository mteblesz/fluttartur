extension CamelCaseExtension on String {
  String toLowerFirst() => substring(0, 1).toLowerCase() + substring(1);
}
