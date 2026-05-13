# Plán: Testování in-app purchases (IAP) na iOS a Androidu

## Context

IAP infrastruktura v PoetryStream je **kompletně implementovaná**. Existuje purchase service, provider, YAML discovery systém i UI (store bottom sheet). Úkol je nastavit interní testování na obou platformách — vyžaduje správnou konfiguraci v App Store Connect a Google Play Console, plus platný build.

---

## Jak funguje systém (shrnutí pro orientaci)

- **YAML soubory** v `assets/poems/` s klíčem `product_id` jsou automaticky detekovány jako placené sbírky (`collection_repository.dart`)
- **V debug módu** (`kDebugMode = true`) jsou placená díla viditelná bez nákupu — vhodné pro testování UI (`poem_providers.dart:47`)
- **V release/profile módu** je placený obsah skrytý, dokud neprojde skutečný nákup
- Product ID v YAML musí přesně odpovídat ID zaregistrovanému v obou storech

---

## Část 1: Přidání nové placené sbírky (YAML)

### Formát souboru

```yaml
product_id: poetrystream_moje_nova_sbirka   # musí odpovídat ID v App Store + Play Console
title: Název sbírky
poems:
  - title: "Název básně"
    text: |
      Řádek básně
      další řádek

      druhá sloka
```

### Postup

1. Vytvořit soubor `poetry_stream/assets/poems/Název sbírky.yaml` (jméno souboru = collection ID)
2. `product_id` musí být stejné na iOS i Androidu
3. **Žádné další změny kódu nejsou potřeba** — `initializeCollections()` YAML auto-objeví
4. Přidat produkt se stejným ID do App Store Connect i Google Play Console (viz níže)

---

## Část 2: Testování na iOS

### Požadavky

- Reálné zařízení (simulátor IAP nepodporuje)
- Apple Developer account
- App Store Connect přístup

### Krok 1 — Zaregistrovat produkt v App Store Connect

1. Přihlásit se na [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Vybrat aplikaci PoetryStream → **In-App Purchases**
3. Kliknout **+** → typ: **Non-Consumable** (jednorázový nákup)
4. **Product ID** = přesně `poetrystream_smrtelne_vazne` (nebo ID z nového YAML)
5. Přidat lokalizaci: Reference Name + česky název/popis
6. Nastavit cenu (Tier 1 = ~25 Kč)
7. Status musí být **Ready to Submit** nebo **Approved**

### Krok 2 — Vytvořit Sandbox testera

1. App Store Connect → **Users and Access** → **Sandbox** → **Testers**
2. Kliknout **+** → zadat email (nesmí být existující Apple ID — použít nový email)
3. Dokončit registraci přes potvrzovací email

### Krok 3 — Build a testování na zařízení

```bash
# Profile build (release chování, ale bez obfuskace)
cd poetry_stream
flutter run --profile

# nebo plný release build
flutter build ios --release
```

- Na zařízení: **Settings → App Store** → odhlásit vlastní Apple ID
- Spustit app → stisknout košík → koupit → iOS se zeptá na Sandbox účet → přihlásit se Sandbox testerem
- Sandbox nákupy jsou **zdarma**

---

## Část 3: Testování na Androidu

### Požadavky

- Google Play Console přístup
- App musí být nahrána alespoň do **Internal Testing** tracku (Google Play Billing nefunguje s APK sideloadem)

### Krok 1 — Nahrát app do Internal Testing

```bash
cd poetry_stream
flutter build appbundle --release
```

1. Play Console → aplikace → **Testing** → **Internal testing**
2. Vytvořit nový release → nahrát `.aab` soubor (`build/app/outputs/bundle/release/app-release.aab`)
3. Počkat na zpracování (minuty až hodina)
4. Zkopírovat opt-in URL pro testery a odeslat jim ji
5. Tester si musí nainstalovat app ze Store (ne sideload)

### Krok 2 — Zaregistrovat produkt v Play Console

1. Play Console → aplikace → **Monetize** → **In-app products**
2. Kliknout **Create product**
3. **Product ID** = přesně `poetrystream_smrtelne_vazne` (nebo ID z YAML)
4. Typ: **One-time product** (Non-consumable)
5. Název, popis, cena (např. 25 CZK)
6. Status: **Active** (důležité!)

### Krok 3 — Přidat License testery (nákupy zdarma)

1. Play Console → **Setup** → **License testing**
2. Přidat Gmail adresy testerů
3. Response type: **LICENSED**
4. Tester musí být přihlášen na zařízení pod tímto Gmail účtem

### Krok 4 — Testovat

- Nainstalovat z Internal Testing tracku (přes opt-in URL)
- Přihlášen jako License tester → nákup je zdarma a průchod je plný (včetně potvrzovacích dialogů)

---

## Přehled: Product ID párování

| Platforma | Kde zaregistrovat | Product ID |
|-----------|------------------|------------|
| YAML soubor | `assets/poems/*.yaml` → `product_id:` | `poetrystream_smrtelne_vazne` |
| iOS | App Store Connect → In-App Purchases | stejné ID |
| Android | Play Console → In-app products | stejné ID |

---

## Kritické soubory

- `poetry_stream/assets/poems/Smrtelně vážně.yaml` — příklad existující placené sbírky
- `poetry_stream/lib/data/repositories/collection_repository.dart` — YAML discovery + product ID mapping
- `poetry_stream/lib/providers/poem_providers.dart:47` — `kDebugMode` podmínka (debug = vše viditelné)
- `poetry_stream/lib/data/purchase/purchase_service.dart` — IAP logika
- `poetry_stream/lib/providers/purchase_provider.dart` — Riverpod provider pro purchase flow
- `poetry_stream/lib/widgets/store_button.dart` — Store UI (košík + bottom sheet)

---

## Ověření funkčnosti

1. **Debug mód** (bez store setup): `flutter run` → sbírka je viditelná bez nákupu → ověří se UI
2. **iOS sandbox**: profile build na reálném zařízení → přihlásit Sandbox testera → průchod nákupem
3. **Android internal**: release AAB na Internal Testing → License tester → průchod nákupem
4. Po nákupu: obsah se zobrazí v app → `purchaseProvider` uloží do Hive → `poemListProvider.refresh()` přenačte básně
