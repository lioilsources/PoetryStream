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
import '../core/constants/build_config.dart';
import '../widgets/paste_poem_button.dart';
import '../widgets/store_button.dart';
import '../widgets/verse_display.dart';
import '../widgets/verse_progress_bar.dart';

class StreamScreen extends ConsumerStatefulWidget {
  const StreamScreen({super.key});

  @override
  ConsumerState<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends ConsumerState<StreamScreen>
    with SingleTickerProviderStateMixin {
  bool _initialized = false;

  // Drives the thin progress line that shows how long until the current verse
  // fades out. Kept in lockstep with the engine via [_onVerseState] and the
  // long-press handlers below.
  late final AnimationController _progress;

  @override
  void initState() {
    super.initState();
    _progress = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initEngine();
    });
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
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

  /// Keeps the progress bar synchronised with the verse lifecycle. The bar
  /// fills from when a verse appears (fadeIn) until it begins to leave
  /// (fadeOut), i.e. across fadeIn + display.
  void _onVerseState(VerseState? prev, VerseState? next) {
    if (next == null) return;
    if (!next.isPlaying) {
      _progress.stop();
      return;
    }
    switch (next.phase) {
      case VersePhase.fadeIn:
        final s = ref.read(settingsProvider);
        _progress.duration = Duration(
          milliseconds:
              ((s.fadeDurationSec + s.displayDurationSec) * 1000).round(),
        );
        _progress.forward(from: 0);
        break;
      case VersePhase.display:
        // Resumed mid-cycle (e.g. after a config change) — ensure it moves.
        if (!_progress.isAnimating && _progress.value < 1.0) {
          _progress.forward();
        }
        break;
      case VersePhase.fadeOut:
        // The verse is on its way out; the bar is full and will reset on the
        // next fadeIn.
        break;
    }
  }

  void _handlePlayPause() {
    final notifier = ref.read(verseProvider.notifier);
    notifier.toggle();
    // On resume, play() emits a fresh fadeIn which restarts the bar via the
    // listener; on pause, freeze the bar where it is.
    if (!notifier.isPlaying) {
      _progress.stop();
    }
  }

  void _handleHoldStart() {
    ref.read(verseProvider.notifier).hold();
    _progress.stop();
  }

  void _handleHoldEnd() {
    final notifier = ref.read(verseProvider.notifier);
    notifier.release();
    // Only resume the bar if the stream wasn't separately paused.
    if (notifier.isPlaying) {
      _progress.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final verseState = ref.watch(verseProvider);
    final settings = ref.watch(settingsProvider);

    // Drive the progress bar from verse state changes.
    ref.listen(verseProvider, _onVerseState);

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
      // Long-press anywhere to pause the cycle and read the verse in peace;
      // releasing resumes it. Tap handling is left to the on-screen buttons.
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPressStart: (_) => _handleHoldStart(),
        onLongPressEnd: (_) => _handleHoldEnd(),
        onLongPressCancel: _handleHoldEnd,
        child: Stack(
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      bottom: 60,
                      left: 24,
                      right: 24,
                    ),
                    child: Center(
                      child: ClipRect(
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
              ),

            // Play/pause button (top left)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 24,
              child: PlayPauseButton(
                isPlaying: verseState?.isPlaying ?? false,
                onTap: _handlePlayPause,
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
                      if (BuildConfig.showPastePoem) ...[
                        PastePoemButton(
                          onSubmit: (title, text) {
                            ref.read(poemListProvider.notifier).addUserPoem(title, text);
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                      const StoreButton(),
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
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.22),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Verse progress line — sits at the very bottom edge so it stays in
            // the periphery and doesn't compete with the centered verse.
            Positioned(
              left: 24,
              right: 24,
              bottom: 0,
              child: SafeArea(
                top: false,
                minimum: const EdgeInsets.only(bottom: 4),
                child: VerseProgressBar(
                  progress: _progress,
                  color: verseState?.style.glowColor ?? Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
