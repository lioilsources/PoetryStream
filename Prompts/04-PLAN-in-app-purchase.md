# In-App Purchases — Placené sbírky básní

## Kontext

Přidání možnosti dokupování placených sbírek básní. Tlačítko s ikonou košíku otevře slide-up panel se seznamem sbírek. Po nákupu se sbírka odemkne v lokální storage. Podpora restore purchases při reinstalaci. Nativní IAP mechanismy (StoreKit / Google Play Billing) přes `in_app_purchase` plugin.

**Přístup:** Lokální validace bez backendu. Store validuje, Hive ukládá stav odemčení, `restorePurchases()` při startu obnovuje.

---

## Architektura

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   StoreButton    │────→│ PurchaseNotifier  │────→│ PurchaseService │
│ (UI: košík +     │     │ (Riverpod +       │     │ (in_app_purchase│
│  slide-up sheet) │     │  Hive persist)    │     │  singleton)     │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                               │                         │
                               ▼                         ▼
                        ┌──────────────┐         ┌──────────────┐
                        │ PoemListNoti │         │ StoreKit /   │
                        │ fier._load() │         │ Google Play  │
                        └──────────────┘         └──────────────┘
```

## Nové soubory (8)

### 1. `lib/models/purchase_state.dart`

```dart
class PurchaseState {
  final Set<String> unlockedCollectionIds;  // {'neruda', 'erben'}
  final Map<String, ProductDetails> products;
  final bool isAvailable;
  final bool isLoading;
  final bool isRestoring;
  final String? errorMessage;

  bool isUnlocked(String collectionId) => unlockedCollectionIds.contains(collectionId);

  // Persist only unlockedCollectionIds to Hive
}
```

### 2. `lib/data/purchase/purchase_service.dart`

Singleton wrapper nad `InAppPurchase.instance`:
- `initialize(callback)` — subscribe to `purchaseStream`, zavolat v `main.dart`
- `isAvailable()` — check store
- `queryProducts()` — query product details pro všechny kolekce
- `buyCollection(ProductDetails)` — `buyNonConsumable()`
- `restorePurchases()` — obnoví předchozí nákupy
- `completePurchase(PurchaseDetails)` — finalizace transakce (povinné!)

Product IDs: `poetrystream_collection_neruda`, `poetrystream_collection_erben`, `poetrystream_collection_halas`

### 3. `lib/data/repositories/collection_repository.dart`

Statická definice dostupných sbírek + YAML loading:
- `availableCollections` — `List<PoemCollection>` (3 placené sbírky)
- `productIdToCollectionId` — mapování store product ID → interní ID
- `allProductIds` — set všech product IDs pro query
- `loadCollectionPoems(String collectionId)` — načte z `assets/poems/{id}.yaml`

Reuse: Existující `PoemCollection` model (`lib/models/poem_collection.dart`) + YAML parsing pattern z `poem_providers.dart`.

### 4. `lib/providers/purchase_provider.dart`

`PurchaseNotifier extends StateNotifier<PurchaseState>`:
- `_initialize()` — load Hive → check store → query products → restore
- `_handlePurchaseUpdate(List<PurchaseDetails>)` — callback z purchase stream
- `purchaseCollection(ProductDetails)` → `buyNonConsumable()`
- `restorePurchases()` — manuální restore (tlačítko OBNOVIT)
- `_unlockCollection()` → YAML load → Hive save → `poemListProvider.refresh()`
- Hive boxy: `'purchases'` (unlocked IDs), `'purchased_poems'` (poem data)

### 5. `lib/widgets/store_button.dart`

**Tlačítko:** Ikona `Icons.shopping_cart_outlined` (18px, alpha 0.4), padding 10, stejný container styl jako ostatní tlačítka.

**`_StoreSheet`** (ConsumerWidget, slide-up bottom sheet):
- Handle bar + header "Sbírky básní" + tlačítko OBNOVIT
- Error message (pokud je)
- ListView placených sbírek, každá jako `_CollectionTile`:
  - Název (Spectral 18px bold, alpha 0.8)
  - Popis (Spectral 13px, alpha 0.4)
  - Počet básní (Spectral 11px, alpha 0.25)
  - Badge "ODEMČENO" (pokud odemčeno, modrý accent `#A8C4D4`)
  - Tlačítko "KOUPIT ZA {cena}" (pokud neodemčeno, cena z `ProductDetails.price`)
  - Loading spinner při zpracování

### 6–8. Placeholder kolekce

`assets/poems/neruda.yaml`, `assets/poems/erben.yaml`, `assets/poems/halas.yaml` — 2-3 básně v každé pro testování. Formát stejný jako `default.yaml` (YAML list s `title`, `author`, `text`).

---

## Modifikované soubory (5)

### `lib/main.dart`
- Použít `ProviderContainer` + `UncontrolledProviderScope` pro přístup k purchase provider
- `container.read(purchaseProvider)` — early init pro zachycení purchase stream eventů

### `lib/providers/poem_providers.dart`
- Přidat `_loadPurchasedPoems()` — čte Hive `'purchased_poems'` box
- V `_load()`: `state = [...bundled, ...purchased, ...user]`
- Přidat `refresh()` metodu: `void refresh() => _load()`

### `lib/screens/stream_screen.dart`
- Nahradit single PastePoemButton za Row se 3 tlačítky: `[PoemListButton, StoreButton, PastePoemButton]`
- Importy: `poem_list_button.dart`, `store_button.dart`

### `lib/screens/browsing_screen.dart`
- Vložit `StoreButton()` do existujícího Row mezi PoemListButton a PastePoemButton

### `android/app/src/main/AndroidManifest.xml`
- Přidat `<uses-permission android:name="com.android.vending.BILLING" />`

---

## Data flow

```
App start → ProviderContainer created
          → purchaseProvider initialized:
              1. Load Hive (odemčené sbírky)
              2. isAvailable()
              3. queryProducts() (ceny ze store)
              4. restorePurchases() (obnova po reinstalaci)
          → PoemListNotifier._load():
              bundled + purchased(unlocked) + user

User klikne KOUPIT:
  → buyNonConsumable() → Platform payment UI
  → purchaseStream emits → _handlePurchaseUpdate()
  → _unlockCollection():
      1. loadCollectionPoems() z YAML
      2. Save poems to Hive (purchased_poems box)
      3. Add to unlockedCollectionIds
      4. Save IDs to Hive (purchases box)
      5. poemListProvider.refresh()
  → Básně se objeví ve všech módech
```

## Edge cases

- **Store nedostupný**: Sheet zobrazí "Obchod není dostupný", free básně fungují
- **Purchase pending**: Loading spinner, dokončí se při dalším spuštění
- **App killed při nákupu**: `restorePurchases()` při startu obnoví
- **Cleared app data**: `restorePurchases()` při startu obnoví z platform store
- **Duplicate purchase**: IAP SDK zabrání opakovanému nákupu non-consumable
- **Missing YAML**: `loadCollectionPoems()` catch → prázdný list, log warning

## Pořadí implementace

1. `purchase_state.dart` model
2. `purchase_service.dart` singleton
3. `collection_repository.dart` + placeholder YAML kolekce
4. `purchase_provider.dart` + init v `main.dart`
5. Rozšířit `poem_providers.dart` o purchased collections
6. `store_button.dart` widget + integrace do obou screens
7. Android BILLING permission
8. `flutter analyze` + `flutter test` + build

## Ověření

1. `flutter analyze` — 0 issues ✅
2. `flutter test` — testy projdou ✅
3. `flutter build ios` — build OK ✅
4. Všechny 3 obrazovky mají trojici tlačítek: BÁSNĚ, košík, + BÁSEŇ ✅
