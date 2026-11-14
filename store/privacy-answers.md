# Odpovědi do App Privacy a Data safety

Pro build s anonymními statistikami (`docs/telemetry.md`, balíček
`ol1n_telemetry`). **Vyplnit až po zveřejnění nového
`docs/privacy-policy.html`** a před odesláním buildu s nastaveným
`TELEMETRY_KEY`. Pořadí: politika → formuláře → klíč → vydání. Builds bez
klíče nic neposílají a platí pro ně dosavadní odpovědi („nic nesbíráme“).

Odpovědi odpovídají `poetry_stream/ios/Runner/PrivacyInfo.xcprivacy` a
`poetry_stream/macos/Runner/PrivacyInfo.xcprivacy`. Co je v konzolích
vyplněné dnes, v repu není: nejdřív porovnej a nic jiného tam deklarovaného
neodškrtávej. Před vyplněním ověř aktuální znění formulářů.

URL politiky se nemění:
`https://lioilsources.github.io/PoetryStream/privacy-policy.html`.

## App Store Connect → App Privacy

**Do you or your third-party partners collect data from this app?** **Yes.**

| Kategorie → typ | Linked to the user? | Used for tracking? | Purpose |
|---|---|---|---|
| Usage Data → **Product Interaction** | **No** | **No** | **Analytics** |
| Diagnostics → **Performance Data** | **No** | **No** | **Analytics** |
| Location → **Coarse Location** | **No** | **No** | **Analytics** |

Proč:

- *Product Interaction*: spuštění a odchod do pozadí, režimy čtení a čas v
  nich, dočtené básně, použité funkce, průběh nákupu a obnovení (výsledek,
  sekundy), zobrazené chyby.
- *Performance Data*: doba načtení obchodu v milisekundách (`store_ready.ms`).
- *Coarse Location*: příjemce odvodí z IP adresy spojení zemi a uloží jen ji;
  IP se neukládá. Kdyby se země u appky vypnula (StoreMetrics, tabulka
  `telemetry.apps`), tento řádek odškrtni a odstraň
  `NSPrivacyCollectedDataTypeCoarseLocation` z obou manifestů.

Nesbírá se (nechat neodškrtnuté): Contact Info, Health & Fitness, Financial
Info, Precise Location, Sensitive Info, Contacts, User Content, Browsing
History, Search History, Identifiers (žádné User ID ani Device ID: ID relace
je náhodné, jen v paměti a nikdy se nepoužije znovu), Purchases (výsledek
nákupu je interakce, ne nákupní historie navázaná na uživatele), Other Usage
Data, Crash Data, Other Diagnostic Data, Other Data.

**Linked to the user: No** u všech typů: žádný účet, žádný identifikátor,
dvě relace nejde propojit.

**Tracking: No.** Nic se nekombinuje s daty jiných firem, nic se neposílá
datovým brokerům, žádná reklama. ATT dialog není potřeba
(`NSPrivacyTracking` je `false`).

Nákupy zpracovává Apple pod Apple ID uživatele, ne appka; nedeklaruje se.

## Google Play Console → Data safety

- **Does your app collect or share any of the required user data types?**
  **Yes.**
- **Is all of the user data collected by your app encrypted in transit?**
  **Yes** (příjemce jen přes `https`; klient jiný host nepřijme).
- **Do you provide a way for users to request that their data is deleted?**
  Statistiky nejsou navázané na uživatele, takže je nejde dohledat ani smazat
  na žádost. Odpověz podle aktuálního znění formuláře; obvykle **No** s tím,
  že data jsou anonymní a mažou se po 12 měsících, a vypnutí v appce smaže i
  frontu v zařízení.

| Data type | Collected | Shared | Ephemeral | Required / optional | Purpose |
|---|---|---|---|---|---|
| App activity → **App interactions** | **Yes** | **No** | No | **Optional** (uživatel to vypne v appce) | **Analytics** |
| App info and performance → **Diagnostics** | **Yes** | **No** | No | **Optional** | **Analytics** |
| Location → **Approximate location** | **Yes** | **No** | No | **Optional** | **Analytics** |

- *App interactions*: viz Product Interaction výše.
- *Diagnostics*: doba načtení obchodu. Pokud ji Play chápe jen jako pády a
  výkon zařízení a Olin chce formulář užší, lze `store_ready` vynechat ze
  slovníku a tento řádek nevyplnit (změna slovníku = nový PR).
- *Approximate location*: země z IP u příjemce, IP se neukládá.

Nesbírá se: Personal info, Financial info, Health and fitness, Messages,
Photos and videos, Audio, Files and docs, Calendar, Contacts, Web browsing,
Device or other IDs, Crash logs, Other app performance data, In-app search
history, Installed apps, Other user-generated content, Other actions.

**Shared: No.** Statistiky přijímá a ukládá vývojář na vlastním serveru v EU
(Česko); nikdo další je nedostane. Google Fonts a Play Billing jsou provoz
Googlu, ne sběr vývojáře (stejné jako dosud).

## Další místa mimo repo

- App Store Connect → App Privacy (výše) a případně odkaz na politiku.
- Play Console → Data safety (výše).
- Stránka appky na olin.now: přepsat sliby typu „nesbírá analytiku“ /
  „nic neposílá“ ve všech jazycích; „žádné reklamy, žádná analytika třetích
  stran“ zůstává.
- Popis v App Store Connect, pokud obsahuje „žádné sledování ani analytika“
  (texty App Store nejsou v `main`; v hlavním checkoutu je rozdělaný
  `store/appstore/` na jiné větvi).
