// Czech single-letter prepositions/conjunctions: a i o u v z k s
final _singleCharPrep = RegExp(r'(?<!\S)([AaIiOoUuVvZzKkSs]) (?=\S)');

// Czech short prepositions: na do ze ve se ke za po od pro
final _multiCharPrep = RegExp(
  r'(?<!\S)(na|do|ze|ve|se|ke|za|po|od|pro) (?=\S)',
  caseSensitive: false,
);

/// Replaces spaces after short Czech prepositions/conjunctions with
/// non-breaking spaces (\u00A0) to prevent them from being orphaned
/// at the end of a wrapped line.
String applyNonBreakingSpaces(String text) {
  return text
      .replaceAllMapped(_singleCharPrep, (m) => '${m[1]}\u00A0')
      .replaceAllMapped(_multiCharPrep, (m) => '${m[1]}\u00A0');
}

List<String> splitIntoStanzas(String text) {
  return text
      .split(RegExp(r'\n\n+'))
      .map((s) => s.trim())
      .map(applyNonBreakingSpaces)
      .where((s) => s.isNotEmpty)
      .toList();
}
