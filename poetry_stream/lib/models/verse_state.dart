import 'verse_style.dart';

enum VersePhase { fadeIn, display, fadeOut, hidden }

class VerseState {
  final String text;
  final VerseStyle style;
  final VersePhase phase;
  final bool isPlaying;
  final String poemTitle;
  final int stanzaIndex; // 0-based index within the poem

  const VerseState({
    required this.text,
    required this.style,
    required this.phase,
    required this.isPlaying,
    this.poemTitle = '',
    this.stanzaIndex = 0,
  });

  double get targetOpacity {
    switch (phase) {
      case VersePhase.fadeIn:
      case VersePhase.display:
        return 1.0;
      case VersePhase.fadeOut:
      case VersePhase.hidden:
        return 0.0;
    }
  }

  VerseState copyWith({
    String? text,
    VerseStyle? style,
    VersePhase? phase,
    bool? isPlaying,
    String? poemTitle,
    int? stanzaIndex,
  }) {
    return VerseState(
      text: text ?? this.text,
      style: style ?? this.style,
      phase: phase ?? this.phase,
      isPlaying: isPlaying ?? this.isPlaying,
      poemTitle: poemTitle ?? this.poemTitle,
      stanzaIndex: stanzaIndex ?? this.stanzaIndex,
    );
  }
}
