import 'package:flutter_test/flutter_test.dart';
import 'package:poetry_stream/core/utils/stanza_parser.dart';

void main() {
  test('splitIntoStanzas splits on double newlines', () {
    final result = splitIntoStanzas('first\n\nsecond\n\nthird');
    expect(result.length, 3);
    expect(result[0], 'first');
    expect(result[1], 'second');
    expect(result[2], 'third');
  });

  test('splitIntoStanzas handles empty input', () {
    expect(splitIntoStanzas(''), isEmpty);
    expect(splitIntoStanzas('  \n\n  '), isEmpty);
  });

  group('applyNonBreakingSpaces', () {
    test('single-char preposition at start of line', () {
      expect(
        applyNonBreakingSpaces('v klíně kvetla'),
        equals('v\u00A0klíně kvetla'),
      );
    });

    test('single-char conjunction mid-line', () {
      expect(
        applyNonBreakingSpaces('macešky a tulipány'),
        equals('macešky a\u00A0tulipány'),
      );
    });

    test('two-char preposition', () {
      expect(
        applyNonBreakingSpaces('pusu na ucho'),
        equals('pusu na\u00A0ucho'),
      );
    });

    test('three-char preposition', () {
      expect(
        applyNonBreakingSpaces('metrem pro metrosexuály'),
        equals('metrem pro\u00A0metrosexuály'),
      );
    });

    test('multiple prepositions in one line', () {
      expect(
        applyNonBreakingSpaces('šel s ním do lesa'),
        equals('šel s\u00A0ním do\u00A0lesa'),
      );
    });

    test('does not replace at end of line (no following word)', () {
      expect(applyNonBreakingSpaces('a'), equals('a'));
      expect(applyNonBreakingSpaces('slovo a'), equals('slovo a'));
    });

    test('does not match inside longer words', () {
      expect(applyNonBreakingSpaces('nano svět'), equals('nano svět'));
      expect(applyNonBreakingSpaces('sedan auto'), equals('sedan auto'));
      expect(applyNonBreakingSpaces('profesor učí'), equals('profesor učí'));
    });

    test('handles uppercase', () {
      expect(applyNonBreakingSpaces('Na kopci'), equals('Na\u00A0kopci'));
      expect(applyNonBreakingSpaces('A přece'), equals('A\u00A0přece'));
      expect(applyNonBreakingSpaces('Pro dobro'), equals('Pro\u00A0dobro'));
    });

    test('handles multi-line stanza text', () {
      const input = 'v klíně kvetla\na tulipány';
      const expected = 'v\u00A0klíně kvetla\na\u00A0tulipány';
      expect(applyNonBreakingSpaces(input), expected);
    });
  });

  test('splitIntoStanzas applies non-breaking spaces', () {
    final result = splitIntoStanzas('v lese\n\na zahradě');
    expect(result[0], equals('v\u00A0lese'));
    expect(result[1], equals('a\u00A0zahradě'));
  });
}
