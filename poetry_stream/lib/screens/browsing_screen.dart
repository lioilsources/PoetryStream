import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
import '../engine/browsing_controller.dart';
import '../providers/poem_providers.dart';
import '../providers/settings_provider.dart';
import '../widgets/animated_background.dart';
import '../widgets/mode_toggle.dart';
import '../core/constants/build_config.dart';
import '../widgets/paste_poem_button.dart';
import '../widgets/poem_list_button.dart';
import '../widgets/store_button.dart';

class BrowsingScreen extends ConsumerStatefulWidget {
  const BrowsingScreen({super.key});

  @override
  ConsumerState<BrowsingScreen> createState() => _BrowsingScreenState();
}

class _BrowsingScreenState extends ConsumerState<BrowsingScreen> {
  final BrowsingController _controller = BrowsingController();
  bool _initialized = false;
  int _currentPoemIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  void _init() {
    if (_initialized) return;
    _initialized = true;

    final poems = ref.read(poemListProvider);
    _controller.initialize(poems);

    // Start scroll at the middle copy (beginning of 2nd repetition)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToMiddleCopy();
    });

    // Track current poem for the list button highlight
    _controller.scrollController.addListener(_updateCurrentPoem);

    setState(() {});
  }

  void _scrollToMiddleCopy() {
    if (!_controller.hasContent) return;
    final poemCount = _controller.poemCount;
    // Scroll to the first poem of the middle copy
    final key = _controller.sectionKeys[poemCount];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: Duration.zero,
      );
    }
  }

  void _updateCurrentPoem() {
    if (!_controller.hasContent) return;
    final idx = _controller.getCurrentPoemIndex();
    if (idx != _currentPoemIndex) {
      setState(() => _currentPoemIndex = idx);
    }
  }

  void _onPoemSelected(int poemIndex) {
    final topInset = MediaQuery.of(context).padding.top + 68 + 20;
    _controller.scrollToPoem(poemIndex, topInset: topInset);
    setState(() => _currentPoemIndex = poemIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final poems = ref.watch(poemListProvider);

    // Sync poems when they change
    ref.listen(poemListProvider, (prev, next) {
      _controller.updatePoems(next);
      setState(() {});
    });

    if (!_initialized || !_controller.hasContent) {
      return Scaffold(
        backgroundColor: VisualConstants.backgroundColor,
        body: Center(
          child: Text(
            'Žádné básně',
            style: GoogleFonts.spectral(
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: VisualConstants.backgroundColor,
      body: Stack(
        children: [
          // Background
          const Positioned.fill(
            child: AnimatedBackground(child: SizedBox.expand()),
          ),
          const Positioned.fill(child: GrainOverlay()),

          // Continuous scroll content — clipped between top and bottom button zones
          Positioned(
            top: MediaQuery.of(context).padding.top + 68,
            bottom: MediaQuery.of(context).padding.bottom + 76,
            left: 0,
            right: 0,
            child: ClipRect(
              child: ListView.builder(
                cacheExtent: 99999,
                controller: _controller.scrollController,
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 32,
                  right: 32,
                ),
                itemCount: _controller.totalDisplayPoems,
                itemBuilder: (context, index) {
                  final poem = _controller.displayPoems[index];
                  final key = _controller.sectionKeys[index];
                  return _PoemSection(key: key, poem: poem);
                },
              ),
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
                    const SizedBox(width: 10),
                    PoemListButton(
                      poems: poems,
                      currentPoemIndex: _currentPoemIndex,
                      onPoemSelected: _onPoemSelected,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Footer info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Builder(builder: (context) {
                    final totalPoems = _controller.poemCount;
                    final currentIdx = _currentPoemIndex;
                    // Calculate total stanzas across all poems
                    int totalStanzas = 0;
                    int stanzasBefore = 0;
                    for (int i = 0; i < poems.length; i++) {
                      final count = poems[i].stanzas.length;
                      if (i < currentIdx) stanzasBefore += count;
                      totalStanzas += count;
                    }
                    final stanzasAfter = totalStanzas - stanzasBefore - (poems.isNotEmpty ? poems[currentIdx].stanzas.length : 0);
                    return Text(
                      '[${currentIdx + 1}/$totalPoems]·[$stanzasBefore:$stanzasAfter]',
                      style: GoogleFonts.spectral(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.22),
                        letterSpacing: 0.5,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A single poem section in the continuous scroll.
class _PoemSection extends StatelessWidget {
  final PoemViewModel poem;

  const _PoemSection({super.key, required this.poem});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Poem title
            Text(
              poem.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.spectral(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.3),
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),

            // Stanzas
            for (int i = 0; i < poem.stanzas.length; i++) ...[
              Text(
                poem.stanzas[i],
                textAlign: TextAlign.center,
                style: GoogleFonts.spectral(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (i < poem.stanzas.length - 1) const SizedBox(height: 18),
            ],

            // Divider between poems
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Text(
                '·  ·  ·',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.1),
                  letterSpacing: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
