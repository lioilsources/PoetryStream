# iOS Ad-Hoc Distribution — nastavení secrets pro GitHub Actions

## Co je potřeba

1. Apple Developer account (placený, $99/rok)
2. UDID zařízení, na která chceš distribuovat
3. 4 GitHub secrets

---

## Krok 1 — Přidej UDID zařízení do Apple Developer portálu

1. Zjisti UDID svého iPhonu:
   - Připoj iPhone k Macu
   - Otevři **Finder** → klikni na zařízení → klikni na "iPhone" pod jménem dokud neuvidíš UDID
   - Nebo: `! instruments -s devices`
2. Na [developer.apple.com](https://developer.apple.com) → **Certificates, IDs & Profiles** → **Devices** → `+`
3. Přidej název a UDID

---

## Krok 2 — Vytvoř Distribution Certificate

Pokud už máš `iOS Distribution` nebo `Apple Distribution` certifikát, přeskoč na Krok 3.

1. **developer.apple.com** → **Certificates** → `+`
2. Vyber **Apple Distribution** (nebo iOS Distribution)
3. Vytvoř CSR na Macu:
   ```bash
   open /Applications/Utilities/Keychain\ Access.app
   ```
   Keychain Access → Certificate Assistant → Request a Certificate from a Certificate Authority
   - Email: tvůj Apple ID email
   - Ulož na disk jako `CertificateSigningRequest.certSigningRequest`
4. Nahraj CSR na Apple Developer, stáhni `.cer` soubor
5. Poklikej na `.cer` — nainstaluje se do Keychain

---

## Krok 3 — Exportuj certifikát jako P12

1. Otevři **Keychain Access** → kategorie **My Certificates**
2. Najdi **Apple Distribution: ...** nebo **iPhone Distribution: ...**
3. Pravý klik → **Export** → formát `.p12`
4. Nastav silné heslo — zapamatuj si ho (= `IOS_CERTIFICATE_PASSWORD`)
5. Ulož jako `certificate.p12`

Zakóduj pro GitHub:
```bash
base64 -i certificate.p12 | pbcopy
```
Zkopírováno do schránky = hodnota pro secret `IOS_CERTIFICATE_P12_BASE64`

---

## Krok 4 — Vytvoř Ad-Hoc Provisioning Profile

1. **developer.apple.com** → **Profiles** → `+`
2. Vyber **Ad Hoc** (pod Distribution)
3. App ID: vyber `com.poetrystream.poetry_stream`
4. Certificate: vyber certifikát z Kroku 2
5. Devices: zaškrtni všechna zařízení, kam chceš distribuovat
6. Name: `PoetryStream AdHoc` (zapamatuj si tento název)
7. Stáhni `.mobileprovision` soubor

Zakóduj pro GitHub:
```bash
base64 -i PoetryStream_AdHoc.mobileprovision | pbcopy
```
Zkopírováno = hodnota pro secret `IOS_PROVISIONING_PROFILE_BASE64`

---

## Krok 5 — Zjisti Team ID

Na [developer.apple.com](https://developer.apple.com) → Account → přejdi dolů → **Team ID** (10 znaků, např. `ABC123DEF4`)

---

## Krok 6 — Uprav ExportOptions.plist

Otevři `poetry_stream/ios/ExportOptions.plist` a doplň:
```xml
<key>teamID</key>
<string>TVŮJ_TEAM_ID</string>         ← z Kroku 5
...
<key>provisioningProfiles</key>
<dict>
    <key>com.poetrystream.poetry_stream</key>
    <string>PoetryStream AdHoc</string> ← název profilu z Kroku 4
</dict>
```

Commitni a pushni tuto změnu.

---

## Krok 7 — Přidej GitHub Secrets

**github.com** → tvoje repo → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

| Secret name | Hodnota |
|-------------|---------|
| `IOS_CERTIFICATE_P12_BASE64` | výstup `base64 -i certificate.p12` |
| `IOS_CERTIFICATE_PASSWORD` | heslo z Kroku 3 |
| `IOS_KEYCHAIN_PASSWORD` | libovolný řetězec, např. `ci-build-keychain` |
| `IOS_PROVISIONING_PROFILE_BASE64` | výstup `base64 -i *.mobileprovision` |

---

## Krok 8 — Trigger release

```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions buildí IPA a nahraje ho do **GitHub Releases** (označeno jako prerelease).

---

## Instalace na iPhone

Stáhni IPA z GitHub Releases a nainstaluj přes:
- **Apple Configurator 2** (Mac App Store, zdarma) — přetáhni IPA na zařízení
- **Sideloadly** (sideloadly.io, zdarma) — jednodušší UI

> Ad-hoc distribuce funguje jen pro zařízení, jejichž UDID je v provisioning profilu.
> Maximálně 100 zařízení na rok na Apple Developer account.
