# Google Play Console — listing, questionnaires, release

App: **Poesie Simona Clinae** · package **`com.ab.PoetryStreamSC`** · A+B
organization developer account · straight to the **Production** track.

What Play asks for, with its own limits. Three things to know before starting:

- **No keywords field.** Play indexes the app name, short and full description,
  so "poezie", "básně", "verše" have to appear in the prose — they do.
- **A feature graphic is mandatory**: `graphics/feature-1024x500.png`.
- **Screenshots are capped at a 2:1 aspect.** The raw captures are 2.165:1, so
  the Play sets are framed onto the app's own dark background, not cropped.

Every text below is length-checked by `python3 store/play/tools/check_lengths.py`
(the `[N]` after each one is its counted length).

## Language: Czech default, English secondary

**Default language: Czech – cs-CZ.** Everything the user sees is Czech: all
four collections (48 poems) are Czech-language poetry, the whole UI is Czech
("Stream / Báseň / Čtení", "ŽIVĚ", "BÁSNĚ", "Sbírky básní", "Koupit"), the
support and privacy pages are Czech. A Czech listing is the honest one and is
the one that will be searched for.

**Add English – en-US as a translation**, mainly so the listing is
understandable outside Czechia. It states plainly that poems and UI are in
Czech, so nobody buys a collection expecting translations.

## Store listing

| Field | Limit | Value |
|---|---|---|
| App name | 30 | `Poesie Simona Clinae` [20] — same in both languages (proper name, matches the launcher label in `AndroidManifest.xml`) |
| Short description | 80 | see below |
| Full description | 4000 | see below |
| App or game | — | App |
| Free or paid | — | Free (with in-app products) |
| Category | — | **Books & Reference** |
| Tags | — | pick from Play's list whatever is closest to: Poetry, Literature, Books, Relaxation/Meditation (Play offers a fixed list; max 5) |
| Contact email | — | `oldrich.vorechovsky.jr@gmail.com` |
| Website | — | `https://lioilsources.github.io/PoetryStream/` |
| Privacy Policy | — | `https://lioilsources.github.io/PoetryStream/privacy-policy.html` |

All three URLs return HTTP 200 (checked 2026-10-15). The name is kept plain
rather than stuffed ("…: básně a verše") — the descriptions carry the search
terms, and Play's metadata policy penalises keyword-padded titles.

<!-- check: name 30 -->
```
Poesie Simona Clinae
```

### Short description (80)

Czech – cs-CZ [77]:

<!-- check: short_cs 80 -->
```
Meditativní stream české poezie. Verše plynou obrazovkou v jemných animacích.
```

English – en-US [74]:

<!-- check: short_en 80 -->
```
A meditative stream of Czech poetry. Verses drift by in gentle animations.
```

### Full description (4000)

Czech – cs-CZ [1361]:

<!-- check: full_cs 4000 -->
```
Poesie Simona Clinae je sbírka básní, která se nečte – plyne.

Verše současného českého básníka Simona Clinae se rozsvěcují na tmavém, pomalu dýchajícím pozadí, chvíli zůstanou a zase se rozplynou. Každá strofa dostane vlastní písmo, barvu a velikost, takže žádné dvě chvíle s aplikací nevypadají stejně. Stačí ji nechat běžet a dívat se.

TŘI ZPŮSOBY ČTENÍ
• Stream – strofy ze všech básní se náhodně prolínají a samy se střídají. Poezie jako tichý doprovod dne, jako meditace.
• Báseň – jedna báseň strofu po strofě, v klidném tempu.
• Čtení – celá báseň najednou; prstem listujete z básně do básně, nekonečně dokola.

Tlačítkem ŽIVĚ / PAUZA stream kdykoli zastavíte, přes BÁSNĚ si vyberete konkrétní báseň ze seznamu.

SBÍRKY BÁSNÍ
Zdarma: PRAVDU MÁ JEN JEDEN (13 básní) a JEŽÍŠ HRAJE NA SITÁR (5 básní).
Jednorázovým nákupem: KOŽNÍ AMBULANCE (18 básní) a SMRTELNĚ VÁŽNĚ (12 básní). Koupíte jednou a sbírka je vaše natrvalo – žádné předplatné. Nákupy lze obnovit na novém zařízení.

TYPOGRAFIE
Dvanáct písem, deset barevných palet s jemně zářícím textem, šest velikostí, občas kurzíva. Animované pozadí se zrnem připomíná papír ve tmě.

SOUKROMÍ
Žádné reklamy, žádné účty, žádné sledování ani analytika. Nastavení zůstává jen ve vašem zařízení.

PRO DOSPĚLÉ ČTENÁŘE
Básně otevřeně mluví o těle, sexualitě, nemoci, smrti a víře a místy používají hrubé výrazy.
```

English – en-US [1462]:

<!-- check: full_en 4000 -->
```
Poesie Simona Clinae is a book of poems you don't read so much as watch flow by.

Verses by contemporary Czech poet Simon Clinae light up on a dark, slowly breathing background, linger for a moment and dissolve. Every stanza gets its own typeface, colour and size, so no two moments with the app look the same. Just let it run.

Please note: the poems and the whole app are in Czech. There are no translations.

THREE WAYS TO READ
• Stream – stanzas from all poems drift by in random order, on their own. Poetry as a quiet companion to your day, or a meditation.
• Báseň (Poem) – one poem, stanza by stanza, at a calm pace.
• Čtení (Reading) – a whole poem at once; swipe from poem to poem in an endless loop.

Pause the stream any time with ŽIVĚ / PAUZA, or pick a specific poem from the BÁSNĚ list.

COLLECTIONS
Free: PRAVDU MÁ JEN JEDEN (13 poems) and JEŽÍŠ HRAJE NA SITÁR (5 poems).
One-time purchase: KOŽNÍ AMBULANCE (18 poems) and SMRTELNĚ VÁŽNĚ (12 poems). Buy once and the collection is yours for good – no subscription. Purchases can be restored on a new device.

TYPOGRAPHY
Twelve typefaces, ten colour palettes with softly glowing text, six sizes, the occasional italic. An animated, grainy background like paper in the dark.

PRIVACY
No ads, no accounts, no tracking, no analytics. Your settings never leave your device.

FOR ADULT READERS
The poems speak openly about the body, sexuality, illness, death and faith, and use coarse language in places.
```

Every factual claim above is from the code: the three modes and their Czech
labels (`mode_toggle.dart`), 12 fonts / 10 palettes / 6 sizes / italics
(`visual.dart`), collection sizes (`assets/poems/*.yaml`), restore button
("Obnovit nákupy"), no analytics/ads SDK in `pubspec.yaml`. "Funguje offline"
is deliberately **not** claimed: fonts are fetched from Google Fonts at runtime
(`GoogleFonts.config.allowRuntimeFetching = true`).

### Release notes (first production release) — cs [105], en [111], limit 500

<!-- check: notes_cs 500 -->
```
První vydání na Google Play. Čtyři sbírky, 48 básní Simona Clinae – dvě zdarma, dvě jednorázovým nákupem.
```

<!-- check: notes_en 500 -->
```
First release on Google Play. Four collections, 48 poems by Simon Clinae – two free, two as one-time purchases.
```

## In-app products

Play: **Monetize with Play → Products → In-app products** (one-time products).
This page stays locked until (a) the A+B account has a **payments profile**
linked and (b) an AAB containing the `com.android.vending.BILLING` permission
has been uploaded to any track (a saved, unsent production draft is enough).

The IDs must match the YAML `product_id` exactly — a mismatch fails silently
(the collection shows no price):

| Product ID | Name (cs-CZ, ≤55) | Description (cs-CZ, ≤200) | Price |
|---|---|---|---|
| `poetrystream_kozni_ambulance` | Kožní ambulance | Sbírka 18 básní Simona Clinae. | your choice |
| `poetrystream_smrtelne_vazne` | Smrtelně vážně | Sbírka 12 básní Simona Clinae. | your choice |

<!-- check: iap1_name 55 -->
```
Kožní ambulance
```
<!-- check: iap1_desc 200 -->
```
Sbírka 18 básní Simona Clinae.
```
<!-- check: iap2_name 55 -->
```
Smrtelně vážně
```
<!-- check: iap2_desc 200 -->
```
Sbírka 12 básní Simona Clinae.
```

English names can stay identical (they are titles); en-US descriptions:
"A collection of 18 poems by Simon Clinae." / "…12 poems…". After creating
each product, **Activate** it. Products are per app, so nothing carries over
from the old `com.ol1n.PoetryStreamSC` app — create them fresh here.

## Graphics

| Asset | Requirement | File |
|---|---|---|
| App icon | 512×512 PNG, no alpha | `graphics/icon-512.png` (RGB) |
| Feature graphic | 1024×500 PNG/JPEG | `graphics/feature-1024x500.png` |
| Phone screenshots | 2–8, max 2:1 | `screenshots/phone/01…06_*.png` (1080×1920) |
| 7" + 10" tablet screenshots | optional | `screenshots/tablet/01…06_*.png` (1920×1200) — upload the same set to both |

Screenshot order: 01 Stream · 02 Báseň · 03 Čtení · 04 Sbírky (collection
list) · 05 Nákup (purchase sheet) · 06 Kožní ambulance. Each carries a short
Czech caption. The sources are real iOS captures
(`ol1n.now/apps/poetrystream/screenshots/raw/mobile/ios/`); the iOS status bar
and the TestFlight back-link are trimmed off, and the UI is identical on
Android (Flutter, same widgets). Tablet shots are optional — the app is a
phone layout; skip them if they look too sparse.

Regenerate:

```
python3 store/play/tools/play_graphics.py
python3 store/play/tools/play_shots.py        # --no-captions for clean frames
python3 store/play/tools/check_lengths.py
```

## App content (Policy → App content)

### Privacy policy
`https://lioilsources.github.io/PoetryStream/privacy-policy.html` — content
matches the code: no personal data, no accounts, no analytics/ads/crash SDKs,
Google Fonts fetched at runtime, Play Billing for purchases, no Advertising ID
(the `AD_ID` permission is explicitly removed in the manifest). This branch
adds the listed name "Poesie Simona Clinae" and the package
`com.ab.PoetryStreamSC` to it — Play wants the policy to name the app or
developer as listed. **It goes live only after this branch is merged to
`main`** (GitHub Pages); the developer name "A+B" is already in it, so the
current live version is acceptable too.

### App access
**All functionality is available without special access.** No login. Paid
collections are not needed for review.

### Ads
**No**, the app contains no ads.

### Content rating (IARC questionnaire)

Email: `oldrich.vorechovsky.jr@gmail.com`. Category: **"Reference, News, or
Educational"** if offered, otherwise **"Entertainment"** (a poetry reader —
static text, no game, no social features). Answer from the actual poems; they
are mature literary verse. Found in `assets/poems/*.yaml`:

| Question area | Answer | Evidence |
|---|---|---|
| Violence | **Text references only** — no depictions. Answer No to depicted/graphic violence; if asked about references to violence, Yes (mild) | "vražda", "zabil", war, suicide mentioned in verse |
| Fear / horror | No | |
| Sexuality / nudity | **Yes — sexual references in text, no imagery**; not explicit | "penisu", "vagíny", "sexu", "pornoworld", "nahý/nahá", "prsa" |
| Language | **Yes — crude language / mild profanity** | "prdel", "hovna", "čumáky", the slur "teplouši" (poem title) |
| Controlled substances | **Alcohol references: Yes** (text). Drugs / tobacco: No | "chlast", "pivo" |
| Discrimination | Answer honestly: one poem title uses a derogatory word for gay men in a literary context; not promoting hatred | "KOŽNÍ AMBULANCE: Teplouši" |
| Gambling / simulated gambling | No | |
| User-generated content / user interaction / sharing | **No** — the "paste a poem" feature is compiled out of release builds (`SHOW_PASTE_POEM` defaults to false), and nothing is ever sent anywhere | `build_config.dart` |
| Shares user location | No | |
| Digital purchases | **Yes** — in-app purchases | |
| Unrestricted internet / web browser | No | |

Expect roughly **PEGI 12–16 / ESRB Teen–Mature 17+ / USK 12–16**. Accept the
generated rating; do not answer "No" to sexual references or language to get a
lower one — misrating is a policy violation and the poems are public.

### Target audience and content
Select **18 and over** only. Reasons: the content is adult (above), the privacy
policy already says the app is not for children, and choosing any under-13 or
13–15 band pulls in the Families policy / teen requirements for no benefit.
"Appeals to children": **No**.

### Data safety
- Does your app collect or share any of the required user data types? **No.**
- That ends the questionnaire (encryption and deletion questions are not shown
  when nothing is collected).

Why this is true: no analytics, crash reporting, ads or account SDK
(`pubspec.yaml`: riverpod, go_router, hive, google_fonts, uuid, yaml,
in_app_purchase, path_provider). Settings and purchase state live in Hive on
the device. The only network traffic is (1) Google Fonts downloads — a plain
font fetch, no identifiers sent by the app, not tied to a user — and (2) Google
Play Billing, whose data is Google's, not the developer's. Neither counts as
developer collection under Play's Data safety rules. If you want zero
ambiguity later, bundle the fonts and set `allowRuntimeFetching = false`.

### Other declarations
- Government app: **No**
- Financial features: **None**
- Health apps: **No** (not a health app)
- News app: **No**
- COVID-19 contact tracing/status: **No**
- Advertising ID: **No** — app does not use it (`AD_ID` removed in manifest).
  Target SDK 33+ makes this question mandatory.

## Signing and versionCode

- Play App Signing: on the new app, **accept the Google-generated app signing
  key** (default). The upload key is the existing one —
  `/Users/ol1n/upload-keystore.jks`, alias `upload`, SHA-256
  `C7:8F:50:4E:31:A7:25:8B:B5:5E:F1:72:C7:8E:EE:D5:C1:16:E9:F1:35:40:AC:53:8C:E0:7D:6A:50:FC:E0:B8`.
  Verified: the local `poetry_stream/android/key.properties` keystore and the
  CI-built v2.2.1 AAB (from the `ANDROID_KEYSTORE_BASE64` secret) carry the same
  certificate, so local and CI builds are interchangeable.
- `pubspec.yaml`: `version: 2.2.1` (no `+build`). CI sets
  `versionCode = github.run_number`; the last Android release run was **#42**
  (v2.2.1, still `com.ol1n.*` — **do not upload that AAB**, it is the old
  package and Play will reject it).
- For the new app, build locally with `--build-number=42`; the next CI run is
  #43, so CI builds stay strictly higher automatically:

  ```
  cd poetry_stream
  flutter build appbundle --release --build-number=42
  # → build/app/outputs/bundle/release/app-release.aab  (com.ab.PoetryStreamSC, 2.2.1 / 42)
  ```

  Already built on 2026-10-15 from this branch's base (48.4 MB, package
  `com.ab.PoetryStreamSC`, signed with the upload key above, sha256
  `27afa454…fdc9b8db`). The build makes Flutter's migrator append
  `android.builtInKotlin=false` / `android.newDsl=false` to
  `android/gradle.properties`; that was reverted, not committed.

## Release to Production — new app `com.ab.PoetryStreamSC`

Package names are permanent and global, so the old personal-account app
`com.ol1n.PoetryStreamSC` cannot be renamed or moved onto this package; this is
a brand-new app in the A+B organization account. Organization accounts have no
"12 testers / 14 days" closed-test gate — go straight to Production.

1. **Create app** (A+B account → All apps → Create app): name `Poesie Simona
   Clinae`, default language **Czech – cs-CZ**, App, **Free**, accept
   declarations. (Free cannot later become paid; IAPs are fine.)
2. **Store settings** (Grow users → Store presence → Store settings): category
   Books & Reference, tags, contact email, website.
3. **Main store listing**: cs-CZ texts, icon, feature graphic, phone (and
   optionally tablet) screenshots. Then **Manage translations → Add
   translation → English – en-US** and paste the English texts; reuse the same
   graphics.
4. **App content**: privacy policy, app access, ads, content rating, target
   audience, data safety, government / financial / health / news,
   advertising ID — answers above.
5. **Production → Countries/regions**: add Czechia and Slovakia at minimum
   (or all countries — the app works anywhere).
6. **Production → Create new release**: confirm Play App Signing, upload the
   `com.ab.PoetryStreamSC` AAB (versionCode 42), release notes cs-CZ + en-US,
   **Next → Save** (do not send yet).
7. **In-app products**: now unlocked by the uploaded AAB — create and activate
   `poetrystream_kozni_ambulance` and `poetrystream_smrtelne_vazne` (needs a
   payments profile on the A+B account).
8. **Publishing overview → Send changes for review.** First reviews of a new
   app typically take from a few days up to a week or more; turn on
   **Managed publishing** first if you want to choose the go-live moment.

### CI follow-ups (not blockers for today's manual release)

- `release-android.yml` already targets `packageName: com.ab.PoetryStreamSC`,
  but the "Upload to Google Play" step will fail until (a) the first AAB has
  been uploaded by hand (step 6 — the Play API cannot create an app's first
  release) and (b) the service account in `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` is
  invited to the **A+B** developer account with release permission for this
  app. It also uploads to `track: internal`; change to `production` (or
  promote by hand) for production releases.
- "Upload to Firebase App Distribution" has been failing on every run since
  v2.0.3 (`404 Requested entity was not found`); with the new applicationId the
  Firebase Android app registered under `FIREBASE_ANDROID_APP_ID` would need to
  be `com.ab.PoetryStreamSC` too. Fix or remove the step; it runs after the
  GitHub Release upload, so the AAB/APK still get attached.
- Other `com.ol1n.PoetryStreamSC` occurrences are intentional and need no
  change: the Kotlin `namespace` and `MainActivity` package (independent of
  applicationId), the iOS bundle ID (`project.pbxproj`, `ExportOptions.plist`,
  `release-ios.yml`) and the Linux `APPLICATION_ID`. There is no
  `google-services.json` and no deep link / intent-filter with a host, so
  nothing else depends on the Android package.
- Old app `com.ol1n.PoetryStreamSC` (personal account, closed testing): never
  send it for review; leave it or unpublish it so two listings don't compete.
