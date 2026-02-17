import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
import '../engine/verse_engine.dart';
import '../models/verse_state.dart';
import '../providers/poem_providers.dart';
import '../providers/settings_provider.dart';
import '../providers/verse_provider.dart';
import '../widgets/animated_background.dart';
import '../widgets/mode_toggle.dart';
import '../widgets/play_pause_button.dart';
import '../widgets/paste_poem_button.dart';
import '../widgets/store_button.dart';
import '../widgets/verse_display.dart';

class StreamScreen extends ConsumerStatefulWidget {
  const StreamScreen({super.key});

  @override
  ConsumerState<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends ConsumerState<StreamScreen> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initEngine();
    });
  }

  void _initEngine() {
    if (_initialized) return;
    _initialized = true;

    final poems = ref.read(poemListProvider);
    final settings = ref.read(settingsProvider);
    final notifier = ref.read(verseProvider.notifier);

    notifier.setPoems(
      poems.map((p) => p.fullText).toList(),
      poems.map((p) => p.title).toList(),
    );
    notifier.updateConfig(VerseEngineConfig(
      fadeInDuration:
          Duration(milliseconds: (settings.fadeDurationSec * 1000).round()),
      displayDuration:
          Duration(milliseconds: (settings.displayDurationSec * 1000).round()),
      mode: settings.displayMode,
    ));
    notifier.play();
  }

  @override
  Widget build(BuildContext context) {
    final verseState = ref.watch(verseProvider);
    final settings = ref.watch(settingsProvider);

    // Sync engine config when settings change
    ref.listen(settingsProvider, (prev, next) {
      if (prev == null) return;
      final notifier = ref.read(verseProvider.notifier);
      if (prev.fadeDurationSec != next.fadeDurationSec ||
          prev.displayDurationSec != next.displayDurationSec ||
          prev.displayMode != next.displayMode) {
        notifier.updateConfig(VerseEngineConfig(
          fadeInDuration:
              Duration(milliseconds: (next.fadeDurationSec * 1000).round()),
          displayDuration:
              Duration(milliseconds: (next.displayDurationSec * 1000).round()),
          mode: next.displayMode,
        ));
      }
    });

    // Sync poems
    ref.listen(poemListProvider, (prev, next) {
      ref.read(verseProvider.notifier).setPoems(
            next.map((p) => p.fullText).toList(),
            next.map((p) => p.title).toList(),
          );
    });

    return Scaffold(
      backgroundColor: VisualConstants.backgroundColor,
      body: Stack(
        children: [
          // Animated background
          const Positioned.fill(
            child: AnimatedBackground(child: SizedBox.expand()),
          ),

          // Grain overlay
          const Positioned.fill(child: GrainOverlay()),

          // Verse display (centered, respects safe area in landscape)
          if (verseState != null)
            Positioned.fill(
              child: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: VerseDisplay(
                      text: verseState.text,
                      style: verseState.style,
                      opacity: verseState.targetOpacity,
                      fadeDuration: Duration(
                        milliseconds: verseState.phase == VersePhase.fadeOut
                            ? 700
                            : (settings.fadeDurationSec * 1000).round(),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // Play/pause button (top left)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 24,
            child: PlayPauseButton(
              isPlaying: verseState?.isPlaying ?? false,
              onTap: () => ref.read(verseProvider.notifier).toggle(),
            ),
          ),

          // Mode toggle (top right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child: ModeToggle(
              currentMode: settings.displayMode,
              onModeChanged: (mode) {
                ref.read(settingsProvider.notifier).setDisplayMode(mode);
              },
            ),
          ),

          // Bottom buttons + footer
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 8,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const StoreButton(),
                    const SizedBox(width: 10),
                    PastePoemButton(
                      onSubmit: (text) {
                        ref.read(poemListProvider.notifier).addUserPoem(text);
                      },
                    ),
                  ],
                ),
                if (verseState != null && verseState.poemTitle.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  // Footer info — reactive to current verse
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '[${verseState.poemTitle}:${verseState.stanzaIndex + 1}]',
                      style: GoogleFonts.spectral(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.15),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
