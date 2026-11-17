# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PoetryStream is a Flutter app that presents Czech poetry as a meditative experience with animated verse streaming. Platform folders: iOS, Android, macOS, Windows, Linux, web. The Flutter project lives in `poetry_stream/`.

## Common Commands

All commands should be run from the `poetry_stream/` directory:

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Run on a specific device
flutter run -d <device_id>

# Static analysis (linting)
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Build for iOS
flutter build ios

# Build for Android
flutter build apk
```

## Architecture

### State Management: Riverpod

Three core providers drive the app:

- **`verseProvider`** (`providers/verse_provider.dart`) — StateNotifier wrapping `VerseEngine`. Controls verse playback (play/pause/toggle), tracks current verse display state.
- **`settingsProvider`** (`providers/settings_provider.dart`) — StateNotifier<UserSettings> backed by Hive local storage. Tracks display mode, timing, background theme. Auto-persists on change.
- **`poemListProvider`** (`providers/poem_providers.dart`) — StateNotifier<List<Poem>>. Maintains the full poem corpus.

### Three Display Modes (DisplayMode enum)

1. **stream** — Random shuffle of all stanzas across all poems, auto-playing with fade animations
2. **reading** — Sequential reading through poems stanza by stanza
3. **browsing** — Continuous scroll through poems with infinite wrap-around

`stream` and `reading` share `StreamScreen`; `browsing` uses `BrowsingScreen`. Mode routing happens in `app.dart` via `_ModeRouter` which watches `settingsProvider.displayMode`.

### Engine Layer (`lib/engine/`)

- **`VerseEngine`** — Timer-based verse cycling. Animation cycle: fadeIn → display → fadeOut → next verse (durations in `core/constants/timing.dart`). Randomly assigns style per stanza (font, color palette, size) from `VisualConstants`, ensuring no consecutive repeats.
- **`BrowsingController`** (`browsing_controller.dart`) — Infinite scroll via a 3× repeated corpus; jumps back to the middle copy near either edge.

### Visual System (`lib/core/constants/visual.dart`)

12 Google Fonts, 10 color palettes (text + glow), 6 font sizes, 30% italic chance. Background: dark charcoal base with animated radial gradients and grain overlay texture (40s loop via `AnimatedBackground` CustomPainter).

### Persistence

Hive (`hive_flutter`) stores user settings as JSON in a "settings" box. Initialized in `main.dart` before app launch.

### Key Patterns

- `ConsumerWidget`/`ConsumerStatefulWidget` for Riverpod provider access
- `WidgetsBinding.instance.addPostFrameCallback` for post-render initialization in screens
- Models use `toJson`/`fromJson` for Hive serialization
- Poem text is split into stanzas on double newlines (`StanzaParser`)
- Poems are YAML files in `assets/poems/` (`default.yaml` free, others are paid collections), loaded by `poem_providers.dart`

## Language

Poem content is in Czech; UI is localized (cs, en, sk) via `lib/l10n/`.
