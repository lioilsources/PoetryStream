# PoetryStream — Flutter Mobile App Implementation Plan

## Kontext

Existující prototyp (HTML + React JSX v `/prototype/`) je funkční meditativní stream české poezie — zobrazuje náhodné strofy s fade animací, náhodným stylem (fonty, barvy, velikosti) a tmavým animovaným pozadím. Cílem je vytvořit nativní iOS + Android aplikaci ve Flutteru, která tento zážitek rozšíří o:

- Tři režimy zobrazení (náhodný stream, sekvenční auto-play, manuální listování)
- Nastavení pozadí, fontů a časování
- Nákup kolekcí básní (jednorázový IAP)
- Nahrávání vlastních básní

---

## Architektura

### Struktura projektu

```
lib/
  main.dart
  app.dart                              # MaterialApp + GoRouter

  core/
    constants/
      timing.dart                       # Fade/display/cycle Duration konstanty
      visual.dart                       # 12 fontů, 10 palet, 6 velikostí
      defaults.dart                     # 8 výchozích básní (texty)
    theme/
      app_theme.dart                    # ThemeData
      background_themes.dart            # Definice pozadí (tmavé, světlé, hvězdy...)
    utils/
      stanza_parser.dart                # split na \n\n+

  models/
    poem.dart                           # Poem (id, title, author, fullText, collectionId)
    poem_collection.dart                # PoemCollection (id, title, isFree, productId)
    verse_style.dart                    # VerseStyle (font, barva, velikost, italic)
    verse_state.dart                    # VerseState (text, style, phase, isPlaying)
    user_settings.dart                  # UserSettings (pozadí, font, timing, mód)
    display_mode.dart                   # enum: stream | cteni | listovani

  engine/
    verse_engine.dart                   # Jádro: Timer cyklus, shuffle/sekvenční, generování stylů
    listovani_controller.dart           # Controller pro manuální scrollování (buffer, poem boundaries)

  data/
    repositories/
      poem_repository.dart              # CRUD básní (Hive)
      settings_repository.dart          # Load/save nastavení (Hive)
    purchase/
      purchase_service.dart             # Wrapper nad in_app_purchase pluginem
      purchase_state.dart               # Set<String> odemčených kolekcí

  providers/
    verse_provider.dart                 # StateNotifier<VerseState?> wrappující engine
    poem_providers.dart                 # Providers pro seznam básní a strof
    settings_provider.dart              # Provider pro UserSettings
    purchase_provider.dart              # Provider pro stav nákupů

  screens/
    stream_screen.dart                  # Auto-play zobrazení veršů (Stream + Čtení módy)
    listovani_screen.dart               # Manuální scrollování veršů (Listování mód)
    library_screen.dart                 # Přehled básní/kolekcí + přidání vlastních
    store_screen.dart                   # Obchod s kolekcemi (IAP)
    settings_screen.dart                # Nastavení pozadí, fontů, časování

  widgets/
    verse_display.dart                  # AnimatedOpacity text s glow efektem
    animated_background.dart            # CustomPainter gradient + grain overlay
    play_pause_button.dart              # Tlačítko s pulzující tečkou
    mode_toggle.dart                    # Stream / Čtení / Listování přepínač
    stanza_progress.dart                # Indikátor pozice v básni (pro Listování mód)

assets/
  poems/
    default.json                        # 8 výchozích básní (zdarma)
    collection_macha.json               # Placená kolekce
    collection_erben.json               # Placená kolekce
    ...
```

### Klíčové technologie

| Co | Řešení |
|---|---|
| State management | Riverpod (`flutter_riverpod`) |
| Navigace | GoRouter (3 taby: Stream, Knihovna, Nastavení) |
| Lokální storage | Hive (básně, nastavení) |
| In-app purchases | `in_app_purchase` plugin (nativní, bez RevenueCat) |
| Fonty | `google_fonts` (12 fontů z prototypu) |
| Animace | `AnimatedOpacity` pro verše, `CustomPainter` pro pozadí |
| Jazyk UI | Pouze čeština |

---

## Hlavní komponenty

### 1. Verse Engine (`lib/engine/verse_engine.dart`)

Srdce aplikace. Timer-based cyklus:

```
fadeIn (2.8s) → display (8.0s) → fadeOut (0.7s) → další verš
```

**Dva módy:**
- **Stream**: Shuffle všech strof, reshuffle po vyčerpání
- **Čtení**: Sekvenčně přes básně, strofa za strofou

**Generování stylu**: Náhodný font/paleta/velikost/italic s logikou "nikdy stejný dvakrát po sobě" (metoda `_pickDifferent`).

**Reaguje na**: změny nastavení (timing, mód), přidání nových básní, play/pause.

### 2. Listování Controller (`lib/engine/listovani_controller.dart`)

Třetí mód — manuální scrollování veršů. Zásadně odlišný od Stream/Čtení:

- **Žádný timer, žádný auto-play** — uživatel swipuje nahoru/dolů
- **Vertikální PageView** se snap chováním — každá strofa zabírá celou obrazovku
- **Nekonečný loop oběma směry**:
  - Swipe nahoru → další strofa; na konci básně → první strofa další básně
  - Swipe dolů → předchozí strofa; na začátku básně → **poslední** strofa předchozí básně
  - Corpus se cyklí dokola (konec → začátek, začátek → konec)

**Technické řešení — Sliding buffer:**

```
Buffer (15 strof v paměti): [ ..7 před.. | AKTUÁLNÍ | ..7 za.. ]
```

- `PageView` má fixní počet stránek (15), ne nekonečný
- Když uživatel doswipuje k okraji bufferu (±2 od kraje), buffer se přecentruje kolem nové pozice a `jumpToPage(center)` neviditelně přeskočí PageController
- Tím vzniká iluze nekonečného scrollu bez memory leaků

**Navigace přes hranice básní:**
```dart
// Vpřed: konec básně → další báseň od začátku
while (stanzaIndex >= poem.stanzaCount) {
  stanzaIndex -= poem.stanzaCount;
  poemIndex = (poemIndex + 1) % poemCount;  // wrap around
}

// Vzad: začátek básně → předchozí báseň od KONCE
while (stanzaIndex < 0) {
  poemIndex = (poemIndex - 1 + poemCount) % poemCount;
  stanzaIndex += poems[poemIndex].stanzaCount;
}
```

**UX detaily:**
- Při přechodu na novou báseň: krátký title card s názvem básně (3s, pak fade out)
- Indikátor pozice v básni: "3 / 7" — zobrazí se na 2s po swipu, pak zmizí
- Stejný vizuální styl (náhodný font/barva/velikost per strofa) jako v ostatních módech
- Styl se generuje při naplnění bufferu (ne při buildu widgetu)

**Integrace s ostatními módy:**
- Sdílí `verse_display.dart` widget a `VerseStyle` generátor
- Sdílí seznam básní z `poem_providers.dart`
- Má vlastní screen (`listovani_screen.dart`) — nepotřebuje play/pause

### 3. In-App Purchases (`lib/data/purchase/`)

- Plugin `in_app_purchase` (nativní StoreKit 2 + Google Play Billing)
- Non-consumable produkty = kolekce básní
- Všechen obsah je v app bundle (assets/poems/*.json), nákup jen "odemkne"
- Restore purchases přes platformové API
- Bez backendu — store validuje účtenky sám
- Stav odemčení uložen lokálně v SharedPreferences (+ restore při reinstalaci)
- Product IDs: `poetrystream_collection_macha`, `poetrystream_collection_erben`, ...

### 3. Nastavení (`lib/screens/settings_screen.dart`)

- **Pozadí**: Tmavé (default), Světlé, Hvězdy, Les, Vlastní barva
- **Font**: Náhodné (default) nebo výběr jednoho z 12 fontů
- **Časování**: Slidery pro délku zobrazení (4–20s), fade (1–5s), cyklus (auto-kalkulace)
- Persistence v Hive

### 4. Knihovna (`lib/screens/library_screen.dart`)

- Seznam kolekcí (zdarma + placené + vlastní)
- Náhled básní v kolekci
- Tlačítko "+ Přidat vlastní" → textové pole / nahrání .txt souboru
- Link na Obchod pro zamčené kolekce

---

## Implementační pořadí

### Fáze 1: Jádro přehrávání (dny 1–3)
1. `flutter create poetry_stream`, pubspec.yaml, závislosti
2. Portovat konstanty z prototypu (fonty, palety, velikosti, výchozí básně)
3. Implementovat `stanza_parser.dart`
4. Implementovat data modely (Poem, VerseStyle, VerseState, UserSettings)
5. Implementovat `verse_engine.dart` (oba módy, timer cyklus, generování stylů)
6. Implementovat `verse_display.dart` (AnimatedOpacity + TextStyle z VerseStyle)
7. Implementovat `animated_background.dart` (CustomPainter gradient + grain)
8. Implementovat `stream_screen.dart` — propojit vše dohromady
9. **Výsledek**: Funkční port prototypu běžící na zařízení

### Fáze 2: State management a persistence (dny 4–5)
10. Riverpod providers pro engine, nastavení, básně
11. Hive integrace — type adaptery, boxy, repozitáře
12. Settings screen s pozadím, fontem, timing slidery
13. Persist a reload nastavení

### Fáze 3: Listování mód (dny 5–7)
14. Implementovat `listovani_controller.dart` (buffer logika, poem boundary navigace)
15. Implementovat `listovani_screen.dart` (vertikální PageView se snap)
16. Indikátor pozice v básni + title card při přechodu na novou báseň
17. Testovat nekonečný scroll oběma směry, přechody mezi básněmi

### Fáze 4: Navigace a knihovna (dny 7–8)
18. GoRouter s bottom navigation shell (3 taby)
19. Library screen — seznam básní, počty strof
20. Přidání vlastních básní (text input / file upload)
21. Mode toggle (Stream / Čtení / Listování) na hlavní obrazovce

### Fáze 5: In-app purchases (dny 9–11)
22. Nastavit produkty v App Store Connect + Google Play Console
23. Implementovat `purchase_service.dart` s `in_app_purchase` pluginem
24. Vytvořit JSON soubory pro placené kolekce
25. Store screen — zobrazení nabídky, purchase flow
26. Unlock logika — po nákupu načíst kolekci z assets do Hive
27. Restore purchases tlačítko
28. Testování purchase flow (sandbox)

### Fáze 6: Polish (dny 12–14)
29. Vyladit animace, performance (60fps i na starších zařízeních)
30. Varianty pozadí (light, nature, starfield, custom)
31. Accessibility (VoiceOver/TalkBack)
32. App icon, splash screen
33. Testování na fyzických zařízeních (iOS + Android)
34. Odeslání do App Store + Google Play

---

## Klíčové soubory k modifikaci/vytvoření

| Soubor | Účel |
|---|---|
| `lib/engine/verse_engine.dart` | Jádro — timer cyklus, shuffle, sekvenční mód, style generátor |
| `lib/engine/listovani_controller.dart` | Buffer logika pro nekonečný scroll, poem boundary navigace |
| `lib/core/constants/visual.dart` | 12 fontů, 10 palet, 6 velikostí portovaných z prototypu |
| `lib/widgets/verse_display.dart` | AnimatedOpacity + TextStyle + glow shadows |
| `lib/widgets/animated_background.dart` | CustomPainter gradient + grain overlay |
| `lib/data/purchase/purchase_service.dart` | Nativní IAP integrace pro obě platformy |
| `lib/providers/verse_provider.dart` | Riverpod StateNotifier wrappující VerseEngine |
| `lib/screens/stream_screen.dart` | Auto-play obrazovka (Stream + Čtení), play/pause, mode toggle |
| `lib/screens/listovani_screen.dart` | Manuální scroll obrazovka, vertikální PageView |
| `lib/screens/settings_screen.dart` | Nastavení pozadí, fontů, časování |

---

## Existující kód k znovupoužití

Z prototypu (`prototype/stream-poezie.html` a `prototype/poetry-stream.jsx`):

- **8 výchozích básní** — přenést do `assets/poems/default.json`
- **12 font definic** — přenést do `visual.dart`
- **10 barevných palet** — přenést do `visual.dart`
- **Stanza parser logika** — `text.split(/\n\n+/).map(trim).filter(notEmpty)`
- **Shuffle + pickNew algoritmus** — přenést do `verse_engine.dart`
- **Timing konstanty** — fadeIn: 2.8s, display: 8s, fadeOut: 0.7s, cycle: 11.5s
- **CSS gradient animace** — reinterpretovat jako CustomPainter

---

## Ověření

1. **Funkční test**: Spustit app na iOS simulátoru a Android emulátoru, ověřit:
   - Stream mód zobrazuje náhodné verše s fade animací
   - Čtení mód zobrazuje verše sekvenčně po básních
   - Listování mód: swipe nahoru/dolů prochází strofy, na konci básně plynule přechod na další, na začátku básně přechod na předchozí (od konce)
   - Listování mód: nekonečný loop — scroll přes celý corpus se zacyklí
   - Play/pause funguje (Stream + Čtení)
   - Přepínání mezi 3 módy funguje bez ztráty stavu
   - Nastavení se persistují po restartu app
   - Přidání vlastní básně se projeví ve všech módech
2. **IAP test**: Sandbox nákup na obou platformách, restore purchases po reinstalaci
3. **Performance**: Plynulé animace (60fps) na starším zařízení, plynulý scroll v Listování
4. **Accessibility**: VoiceOver/TalkBack přečte aktuální verš
