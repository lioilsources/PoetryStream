# Plán: Persistance básní + bundled poems z YAML + PastePoemButton

## Kontext

Uživatelské básně přidané přes tlačítko se po restartu ztrácejí. Defaultní básně jsou hardcoded. Potřebujeme:
1. Persistenci user básní v Hive
2. Bundled básně v YAML souboru (snadné přidávání při buildu)
3. Předělat tlačítko na jednoduchý PastePoemButton

## Změny

### 1. `lib/widgets/add_poem_button.dart` → `lib/widgets/paste_poem_button.dart`

Přejmenovat a zjednodušit:
- Tlačítko `+ BÁSEŇ` (stejný styl) → po klepnutí vyjede zespodu textové pole
- Žádný modal, žádný title/author/date — jen TextField pro paste a editaci
- Jedno tlačítko co sheet zasune a uloží text do local storage
- Widget: `PastePoemButton(onSubmit: (String) → void)`

### 2. `assets/poems/default.yaml` — bundled básně

Nahradit `default.json`. YAML s `|` bloky pro zachování řádkování:

```yaml
- title: Máj
  text: |
    Byl pozdní večer, první máj,
    večerní máj, byl lásky čas.
```

Pro přidání básně při buildu = přidat blok do YAML.

### 3. `pubspec.yaml`

- Přidat dependency `yaml: ^3.1.3`
- Asset cesta `assets/poems/` už registrována

### 4. `lib/core/constants/defaults.dart` — smazat

Básně se načítají z YAML assetu.

### 5. `lib/providers/poem_providers.dart` — Hive persistance + asset loading

- `_load()`: načte bundled z `assets/poems/default.yaml` + user z Hive boxu `"poems"`
- `addUserPoem()` → uloží do Hive
- `removePoem()` → uloží do Hive
- Hive key: `"user_poems"` — JSON pole serializovaných Poem

### 6. Screeny — aktualizovat import

`stream_screen.dart` + `listovani_screen.dart`: import `paste_poem_button.dart` místo `add_poem_button.dart`.

## Soubory

- **Nový**: `assets/poems/default.yaml`, `lib/widgets/paste_poem_button.dart`
- **Smazat**: `assets/poems/default.json`, `lib/core/constants/defaults.dart`, `lib/widgets/add_poem_button.dart`
- **Upravit**: `pubspec.yaml`, `lib/providers/poem_providers.dart`, `lib/screens/stream_screen.dart`, `lib/screens/listovani_screen.dart`

## Ověření

1. `flutter analyze` — žádné chyby
2. Spustit → básně z YAML se zobrazí
3. Paste báseň → zobrazí se v streamu
4. Restart → user báseň přetrvá
5. Přidat blok do YAML, rebuild → nová báseň
