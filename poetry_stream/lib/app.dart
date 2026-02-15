import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/visual.dart';
import 'models/display_mode.dart';
import 'providers/settings_provider.dart';
import 'screens/stream_screen.dart';
import 'screens/browsing_screen.dart';

class PoetryStreamApp extends ConsumerWidget {
  const PoetryStreamApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'PoetryStream',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: VisualConstants.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8D5B7),
          brightness: Brightness.dark,
        ),
      ),
      home: const _ModeRouter(),
    );
  }
}

class _ModeRouter extends ConsumerWidget {
  const _ModeRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    switch (settings.displayMode) {
      case DisplayMode.stream:
      case DisplayMode.reading:
        return const StreamScreen();
      case DisplayMode.browsing:
        return const BrowsingScreen();
    }
  }
}
