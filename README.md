# PoetryStream

A meditative Flutter app that streams Czech poetry with animated verse display. Features three display modes (Stream, Čtení, Listování), typographic variety across 12 fonts and 10 color palettes, and in-app purchases for poem packs.

## Platforms

| Platform | Status |
|----------|--------|
| iOS | Supported |
| Android | Supported |

## Features

- Stream mode: random stanza shuffle with timer-based cycling
- Čtení mode: sequential poem reading
- Listování mode: manual swipe browsing
- 12 Google Fonts, 10 color palettes, 6 sizes, 30% italic chance
- Animated backgrounds
- 8 bundled Czech poems (free)
- In-app purchases for additional poem packs
- All UI and content in Czech

## Tech Stack

- Flutter / Dart 3.10.7
- Riverpod 2.6.1 (StateNotifier)
- Hive (local persistence)
- go_router, google_fonts
- YAML poem format

## Build

```bash
flutter run -d ios
flutter run -d android
```

## Documentation

- [CHANGELOG.md](CHANGELOG.md) — development history
- [GALLERY.md](GALLERY.md) — screenshots and videos
