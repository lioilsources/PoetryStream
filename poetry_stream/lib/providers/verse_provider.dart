import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../engine/verse_engine.dart';
import '../models/verse_state.dart';

class VerseNotifier extends StateNotifier<VerseState?> {
  late final VerseEngine _engine;

  VerseNotifier() : super(null) {
    _engine = VerseEngine(onStateChanged: (s) => state = s);
  }

  void setPoems(List<String> poems) => _engine.setPoems(poems);

  void updateConfig(VerseEngineConfig config) => _engine.updateConfig(config);

  void play() => _engine.play();
  void pause() => _engine.pause();
  void toggle() => _engine.toggle();

  bool get isPlaying => _engine.isPlaying;
  int get stanzaCount => _engine.stanzaCount;

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
