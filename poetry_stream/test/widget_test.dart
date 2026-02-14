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
}
