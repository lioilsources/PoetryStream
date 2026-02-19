# 06 - PLAN: Polish UX — text overflow, poem title, button layout

## Text overflow fix — Stream + Báseň mód

- Přidán vertikální padding (top: 60, bottom: 60) do verse display oblasti v `StreamScreen`
- `ClipRect` obaluje `VerseDisplay` pro tvrdý ořez přetékajícího textu
- `VerseDisplay` zbaven pevného `maxWidth` — text si zachovává řádkování z YAML
- `FittedBox(fit: BoxFit.scaleDown)` proporcionálně zmenší celý blok pokud se nevejde na obrazovku

## Text overflow fix — Čtení mód (Listování → Čtení)

- ListView omezen `Positioned` zónou (top: safeArea + 68, bottom: safeArea + 76)
- `ClipRect` zajišťuje tvrdý ořez — text se nevykresluje pod/nad tlačítky
- Odstraněn ShaderMask fade efekt — uživatelé chtějí tvrdý ořez bez vizuálního přetékání

## Název básně z prvního řádku

- `PastePoemButton.onSubmit` změněn na `(String title, String text)`
- `_submit()` extrahuje první řádek jako název, zbytek jako tělo básně
- Hint text aktualizován: „První řádek = název básně\n\nText básně…"
- `PoemListNotifier.addUserPoem` přijímá `title` parametr a předává ho do `Poem` konstruktoru

## Přejmenování módů

- Čtení → **Báseň**
- Listování → **Čtení**

## Build flag pro +BÁSEŇ tlačítko

- Nový soubor `core/constants/build_config.dart`
- Konstanta `SHOW_PASTE_POEM` (default: `false`)
- Zapnutí: `flutter run --dart-define=SHOW_PASTE_POEM=true`
- Tlačítko podmíněně zobrazeno v obou screenech

## Prohození spodních tlačítek

- Stream/Báseň mód: [+Báseň]* → Košík
- Čtení mód: [+Báseň]* → Košík → Básně (úplně vpravo)
- *zobrazí se jen s build flagem

## Patička

- Font zvětšen 12 → 14px
- Opacity zvýšena 0.15 → 0.22

## Dotčené soubory

1. `lib/screens/stream_screen.dart`
2. `lib/screens/browsing_screen.dart`
3. `lib/widgets/verse_display.dart`
4. `lib/widgets/paste_poem_button.dart`
5. `lib/widgets/mode_toggle.dart`
6. `lib/providers/poem_providers.dart`
7. `lib/core/constants/build_config.dart` (nový)
