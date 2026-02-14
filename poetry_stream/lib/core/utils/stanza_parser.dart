List<String> splitIntoStanzas(String text) {
  return text
      .split(RegExp(r'\n\n+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
}
