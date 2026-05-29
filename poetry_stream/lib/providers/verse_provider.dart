import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../engine/verse_engine.dart';
import '../models/verse_state.dart';

class VerseNotifier extends StateNotifier<VerseState?> {
  late final VerseEngine _engine;

  VerseNotifier() : super(null) {
    _engine = VerseEngine(onStateChanged: (s) => state = s);
  }

  void setPoems(List<String> poems, List<String> titles) =>
      _engine.setPoems(poems, titles);

  void updateConfig(VerseEngineConfig config) => _engine.updateConfig(config);

  void play() => _engine.play();
  void pause() => _engine.pause();
  void toggle() => _engine.toggle();
  void jumpToPoem(int poemIndex) => _engine.jumpToPoem(poemIndex);

  /// Suspends the verse cycle while the user holds to keep reading.
  void hold() => _engine.hold();

  /// Resumes the cycle suspended by [hold].
  void release() => _engine.release();

  bool get isPlaying => _engine.isPlaying;
  bool get isHeld => _engine.isHeld;
  int get stanzaCount => _engine.stanzaCount;
  int get poemCount => _engine.poemCount;

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }
}

final verseProvider =
    StateNotifierProvider<VerseNotifier, VerseState?>((ref) {
  return VerseNotifier();
});
