# Plán: Automatická registrace placených sbírek z YAML + debug preview

## Context

Uživatel chce: přidat YAML soubor do `assets/poems/` → automaticky se stane placenou sbírkou, žádné změny v kódu. V debug módu jsou všechny sbírky viditelné bez nákupu.

IAP mechanismus v `purchase_provider.dart` je kompletní (purchase stream, unlock, Hive persistence, refresh poem listu). Chybí pouze:
- dynamická registrace sbírek z YAML souborů
- soubory YAML pro placené sbírky (f01.yaml neexistuje)

---

## Nový formát YAML pro placené sbírky

Stávající `default.yaml` = plain list → zůstává beze změny (free, bundled).

Nové placené sbírky používají map formát s metadaty:

```yaml
product_id: poetrystream_jezis
title: Ježíš hraje na sitár
poems:
  - title: "Název básně"
    text: |
      První verš
      druhý verš
```

Přítomnost klíče `product_id` = placená sbírka.

---

## Změny v `lib/data/repositories/collection_repository.dart`

- `availableCollections` změněn z `const` na `var` naplněný při startu
- `initializeCollections()` čte `AssetManifest.json`, registruje všechny YAML soubory s `product_id` jako placené sbírky
- `productIdToCollectionId` a `allProductIds` přepnuty na gettery
- `loadCollectionPoems()` podporuje obě YAML varianty (plain list i map s `poems` klíčem)

## Změny v `lib/providers/poem_providers.dart`

- `_loadBundledPoems()` vždy načte `default.yaml`
- V `kDebugMode`: auto-discovery přes `AssetManifest.json` — načte všechny ostatní YAMLy bez nákupu
- Extrahována helper metoda `_loadCollectionYaml(collectionId)`

## Změny v `lib/main.dart`

- `await initializeCollections()` voláno před `runApp()`

## Beze změny

- `store_button.dart` — `availableCollections` getter funguje
- `purchase_provider.dart` — `allProductIds` / `productIdToCollectionId` gettery fungují

---

## Workflow pro přidání nové sbírky (bez změn v kódu)

1. Vytvořit `assets/poems/<nazev>.yaml` (map formát s `product_id`, `title`, `poems`)
2. Zaregistrovat `product_id` v App Store Connect (Non-Consumable IAP) a Google Play Console
3. Push + tag `vX.Y.Z` → GitHub Actions přebuildí a publikuje
4. Sbírka se automaticky objeví v obchodě (store button) a je zakoupitelná

---

## Sbírky v `assets/poems/`

- `default.yaml` — plain list, vždy bundled (zdarma)
- `*.yaml` s klíčem `product_id` — placená sbírka, v debug viditelná bez nákupu
- `*.yaml` bez `product_id` — ignorováno (ani bundled, ani placená)
