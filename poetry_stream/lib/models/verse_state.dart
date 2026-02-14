import 'verse_style.dart';

enum VersePhase { fadeIn, display, fadeOut, hidden }

class VerseState {
  final String text;
  final VerseStyle style;
  final VersePhase phase;
  final bool isPlaying;

  const VerseState({
    required this.text,
    required this.style,
    required this.phase,
    required this.isPlaying,
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
  }) {
    return VerseState(
      text: text ?? this.text,
      style: style ?? this.style,
      phase: phase ?? this.phase,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
