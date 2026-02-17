# 05 - FIX: Screens, Footer & Poem Picker

## Patička (footer) — layout

- Patička se zobrazovala na stejné úrovni jako tlačítka (BÁSNĚ, košík) a překrývala je
- Řešení: tlačítka a patička v jednom `Column` — tlačítka nahoře, patička pod nimi
- Platí pro StreamScreen (Stream + Čtení) i BrowsingScreen (Listování)

## Patička — dynamický obsah

### Stream mód
- Patička zobrazuje `[název básně:index strofy]` reaktivně z `verseState`
- Přidáno `poemTitle` a `stanzaIndex` do `VerseState`
- `VerseEngine` trackuje název básně a index strofy pro každou zobrazenou strofu
- Odstraněn statický fallback `[počet básní:počet strof]` — patička se zobrazí jen když hraje verse

### Čtení mód
- Stejný formát jako Stream: `[název básně:index strofy]`
- Změněn algoritmus: místo sekvenčního průchodu básněmi nyní **random výběr básně → sekvenční průchod strofami → nová random báseň**
- Po projití všech básní se pořadí reshuffluje
- `jumpToPoem` přestaví frontu tak, aby vybraná báseň byla první

### Listování mód
- Patička: `[pozice/celkem]·[strofy_před:strofy_za]`
- Dynamicky se aktualizuje při scrollování

## Tlačítko BÁSNĚ

- Odstraněno z módů Stream a Čtení (zůstává jen v Listování)
- V Stream/Čtení nemá smysl — básně se vybírají automaticky

## Scroll na báseň v Listování

- `Scrollable.ensureVisible` nescrollovalo na nadpis, ale na první strofu
- Přepsáno na `scrollController.animateTo` s přesným výpočtem offsetu
- `scrollToPoem` přijímá `topInset` (safe area + ListView padding) aby nadpis básně seděl na horním okraji viditelné oblasti

## Landscape mód

### Stream/Čtení — centrování textu
- Verse display obalen v `SafeArea` + `Positioned.fill` → text se centruje v rámci bezpečné oblasti (respektuje notch/dynamic island)

### Listování — centrování textu
- ListView obalen v `SafeArea`
- `_PoemSection` obalena `Center` + `ConstrainedBox(maxWidth: 600)`
- `crossAxisAlignment: .center` + `textAlign: TextAlign.center` na stanzách

## Text rendering — zachování řádkování

- Odstraněn `FittedBox(scaleDown)` z `VerseDisplay`
- FittedBox zmenšoval celou strofu (font i layout) aby se vešla do boxu, což deformovalo řádkování
- Text nyní zalamuje přirozeně na šířku `maxWidth` (85% obrazovky, max 720px)

## Fonty — česká diakritika

- Odstraněn font **Italiana** — jediný z 12 fontů bez `latin-ext` subsetu
- Nezobrazoval správně české znaky (ř, ě, š, č, ž, ů, ď, ť, ň)
- Zbývá 11 fontů, všechny podporují českou diakritiku

## Změněné soubory

- `lib/models/verse_state.dart` — nová pole `poemTitle`, `stanzaIndex`
- `lib/engine/verse_engine.dart` — `_StanzaRef`, random poem order pro Čtení, title tracking, `_poemTitle` helper
- `lib/providers/verse_provider.dart` — propagace `setPoems(poems, titles)`
- `lib/screens/stream_screen.dart` — layout patičky, SafeArea pro landscape, odstranění BÁSNĚ tlačítka
- `lib/screens/browsing_screen.dart` — layout patičky, SafeArea pro landscape, centrování _PoemSection
- `lib/engine/browsing_controller.dart` — `scrollToPoem` s `topInset` parametrem
- `lib/widgets/verse_display.dart` — odstranění FittedBox, odstranění Italiana
- `lib/core/constants/visual.dart` — odstranění Italiana fontu
