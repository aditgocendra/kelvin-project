class Functions {
  // Generate Search Keyword
  static List<String> generateSearchKeyword({required String sentence}) {
    String clearSymbol = sentence.replaceAll(RegExp(r"[^\s\w]"), '');
    String clear2WhiteSpace = clearSymbol.replaceAll('  ', ' ');

    return clear2WhiteSpace.toLowerCase().split(" ");
  }
}
