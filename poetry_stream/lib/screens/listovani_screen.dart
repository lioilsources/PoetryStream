import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/visual.dart';
import '../engine/listovani_controller.dart';
import '../providers/poem_providers.dart';
import '../providers/settings_provider.dart';
import '../widgets/animated_background.dart';
import '../widgets/mode_toggle.dart';
import '../widgets/stanza_progress.dart';
import '../widgets/verse_display.dart';

class ListovaniScreen extends ConsumerStatefulWidget {
  const ListovaniScreen({super.key});

  @override
  ConsumerState<ListovaniScreen> createState() => _ListovaniScreenState();
}

class _ListovaniScreenState extends ConsumerState<ListovaniScreen> {
  final ListovaniController _controller = ListovaniController();
  bool _initialized = false;
  bool _showIndicators = true;
  Timer? _indicatorTimer;
  String? _currentPoemTitle;
  bool _showPoemTitle = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  void _init() {
    if (_initialized) return;
    _initialized = true;

    final poems = ref.read(poemListProvider);
    _controller.onPoemChanged = _onPoemChanged;
    _controller.initialize(poems);
    setState(() {});
  }

  void _onPoemChanged(String title) {
    setState(() {
      _currentPoemTitle = title;
      _showPoemTitle = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showPoemTitle = false);
    });
  }

  void _onPageChanged(int index) {
    _controller.onPageChanged(index);
    setState(() => _showIndicators = true);

    _indicatorTimer?.cancel();
    _indicatorTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showIndicators = false);
    });
  }

  @override
  void dispose() {
    _indicatorTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

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

          // PageView with stanzas
          PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _controller.pageController,
            onPageChanged: _onPageChanged,
            itemCount: _controller.buffer.length,
            physics: const PageScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= _controller.buffer.length) {
                return const SizedBox.shrink();
              }
              final item = _controller.buffer[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: VerseDisplay(
                    text: item.text,
                    style: item.style,
                    opacity: 1.0,
                    fadeDuration: const Duration(milliseconds: 300),
                  ),
                ),
              );
            },
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

          // Poem title card (top center)
          if (_showPoemTitle && _currentPoemTitle != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 0,
              right: 0,
              child: Center(
                child: PoemTitleCard(
                  title: _currentPoemTitle!,
                  onDismissed: () {
                    if (mounted) setState(() => _showPoemTitle = false);
                  },
                ),
              ),
            ),

          // Stanza progress (bottom center)
          if (_showIndicators && _controller.buffer.isNotEmpty)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 40,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _showIndicators ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Builder(builder: (context) {
                  final centerItem = _controller.buffer.length > ListovaniController.bufferCenter
                      ? _controller.buffer[ListovaniController.bufferCenter]
                      : _controller.buffer.first;
                  return StanzaProgress(
                    current: centerItem.stanzaIndexInPoem + 1,
                    total: centerItem.totalStanzasInPoem,
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
