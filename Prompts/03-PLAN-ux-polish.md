# Listování Redesign + Bug Fixes

## Kontext

Uživatel otestoval app a dal feedback:
1. Text někdy přetéká obrazovku v Stream/Čtení módech
2. Listování má být jako ve Wordu — plynulý scroll celými básněmi, ne snap po strofách
3. Vedle "Báseň+" chce tlačítko "Seznam básní" pro rychlou navigaci (slide-up panel)
4. V Listování fixní font (Spectral) — žádné náhodné fonty/barvy/velikosti

---

## 1. Text overflow fix — `lib/widgets/verse_display.dart`

Obalit text do `FittedBox(fit: BoxFit.scaleDown)` aby se dlouhé strofy automaticky zmenšily místo přetečení. Widget už má padding 24px z obou stran (v screen souborech).

## 2. Přepsat `lib/engine/browsing_controller.dart`

**Smazat** stávající stanza-buffer logiku. Nový controller:

- Drží `List<Poem> poems` a `ScrollController`
- Obsah: 3× opakovaný corpus (`[...poems, ...poems, ...poems]`) pro iluzi nekonečného scrollu
- Startuje uprostřed (na začátku 2. kopie)
- Scroll listener: když se uživatel přiblíží k okraji, tiše přeskočí `jumpTo` do středu
- `scrollToPoem(int poemIndex)` — pro navigaci ze seznamu básní
- `getCurrentPoemIndex()` — vrátí index aktuálně viditelné básně (pro highlight v seznamu)
- Používá GlobalKey per báseň-sekce pro výpočet pozic

## 3. Přepsat `lib/screens/browsing_screen.dart`

Nahradit `PageView.builder` za `CustomScrollView` / `ListView.builder`:

Každá báseň v scrollu:
```
[název básně — Spectral 14px, uppercase, alpha 0.3, letterSpacing 2]
[24px mezera]
[strofa 1 — Spectral 18px, alpha 0.7, height 1.6]
[16px mezera]
[strofa 2]
...
[poslední strofa]
[80px spacer + oddělovač „· · ·" alpha 0.1]
```

- Fixní font: `GoogleFonts.spectral` — žádné VerseStyle, žádný VerseDisplay widget
- Text přímo jako `Text()` widgety (ne přes VerseDisplay)
- Zachovat: AnimatedBackground, GrainOverlay, ModeToggle, PastePoemButton
- Přidat: PoemListButton (vedle PastePoemButton)
- Odebrat: StanzaProgress, PoemTitleCard (inline názvy je nahrazují)

## 4. Nový widget `lib/widgets/poem_list_button.dart`

Stejný pattern jako `paste_poem_button.dart`:

**Tlačítko:** `BÁSNĚ` — stejný styl (Cormorant Garamond 14px, alpha 0.4, letterSpacing 2)

**Slide-up panel (`_PoemListSheet`):**
- Handle bar + header "Seznam básní"
- `ListView` s básněmi:
  - Název básně (Spectral 18px, alpha 0.6; aktuální = alpha 0.9)
  - Pod tím: počet strof (Spectral 12px, alpha 0.25)
  - Tap → zavře sheet, zavolá `onPoemSelected(index)` → controller scrollne na báseň

```dart
class PoemListButton extends StatelessWidget {
  final List<Poem> poems;
  final int currentPoemIndex;
  final void Function(int poemIndex) onPoemSelected;
}
```

---

## 5. Rename Czech identifiers to English

- `DisplayMode.cteni` → `DisplayMode.reading`
- `DisplayMode.listovani` → `DisplayMode.browsing`
- `ListovaniController` → `BrowsingController`
- `ListovaniScreen` → `BrowsingScreen`
- `listovani_controller.dart` → `browsing_controller.dart`
- `listovani_screen.dart` → `browsing_screen.dart`

Czech UI labels (`'Čtení'`, `'Listování'`, `'Básně'` atd.) zůstávají beze změny.

---

## Soubory k úpravě

| Soubor | Akce |
|---|---|
| `lib/widgets/verse_display.dart` | Upravit — FittedBox pro overflow |
| `lib/engine/browsing_controller.dart` | Přepsat — poem-based scroll, ScrollController |
| `lib/screens/browsing_screen.dart` | Přepsat — ListView, fixní Spectral, inline poem headers |
| `lib/widgets/poem_list_button.dart` | **Nový** — tlačítko + slide-up panel |
| `lib/models/display_mode.dart` | Rename enum values |
| `lib/app.dart` | Update imports + enum refs |
| `lib/widgets/mode_toggle.dart` | Update enum refs |

## Ověření

1. `flutter analyze` — žádné warningy
2. `flutter test` — testy projdou
3. Build + run na simulátoru:
   - Stream/Čtení: dlouhé strofy se zmenší místo přetečení
   - Listování: plynulý scroll, básně celé s názvy, fixní Spectral font
   - Listování: nekonečný scroll oběma směry
   - Tlačítko BÁSNĚ otevře seznam, tap na báseň scrollne na ni
   - Přepínání módů funguje
