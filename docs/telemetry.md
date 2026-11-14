# Anonymous usage statistics

Poesie sends a small set of anonymous usage events through
[`ol1n_telemetry`](https://github.com/lioilsources/Ol1nTelemetry) so the
owner can see what new readers do after the first launch, which display mode
they stay in, whether they read a poem to its end, and where buying a
collection goes wrong. This file is the **event dictionary**: the constant
`poesieDictionary` (`poetry_stream/lib/telemetry/telemetry_dictionary.dart`)
and this document list exactly the same events and properties, and
`poetry_stream/test/telemetry_test.dart` fails when they drift apart.

Adding an event or a property is a change to the privacy policy
(`docs/privacy-policy.html`) and to the store privacy answers. Ask the owner
first. The dictionary changes at most once per release.

## Rules

The rules of `ol1n_telemetry` apply unchanged: no persistent identifier
(a random session id that lives in memory only), cohorts computed on the
device (only bands leave it), only enums, bands and numbers (no poem text,
no poem title, nothing the user typed), no key → no network, off wipes the
queue at once, the app never waits for measuring and never reads anything
back from it. See the package README.

- Receiver: the developer's own server in the EU (protocol v1, StoreMetrics).
  No third party gets the events. The IP address is not stored, only the
  country.
- Retention: raw events 12 months.
- Storage on the device: a Hive box `telemetry` (strings, keys
  `telemetry_*`).
- `days_band: pre` for a reader who had saved settings, unlocked
  collections or own poems before measuring began.

## Configuration

| `--dart-define` | Meaning |
|---|---|
| `TELEMETRY_KEY` | The app's key at the receiver. Empty → nothing is recorded or sent. |
| `TELEMETRY_HOST` | Receiver address, `https`. Empty → nothing is recorded or sent. |
| `TELEMETRY_DEBUG` | `true` prints events to the console instead of sending them. |
| `TELEMETRY_TESTER` | `true` marks a tester build (`tester: true`, left out of reports). |

The release workflows (`release-ios`, `release-android`, `release-macos`,
`release-windows`, `release-linux`) pass the key and the host from the
GitHub secrets of the same names. The key and the receiver address never go
into this public repository.

The switch "Anonymous statistics" is at the bottom of the store sheet (the
app has no settings screen). It is shown only in builds with a key.

## Screens

The app has no routes. The three display modes are the main screens; the
two bottom sheets are reported while they are open.

| Screen | What it is |
|---|---|
| `stream` | mode "Stream": random stanzas from all poems |
| `reading` | mode "Báseň": one poem stanza by stanza |
| `browsing` | mode "Čtení": continuous scroll through all poems |
| `store` | the store sheet (collections, restore, statistics switch) |
| `poem_list` | the poem list sheet (only in `browsing`) |

## Activation

The first poem read to its end (`poem_finish`): in `reading` the last stanza
of a poem was shown in full; in `browsing` the reader scrolled on to the next
poem after at least 5 seconds on this one. The random `stream` mode has no
"end of a poem" and never counts.

## Features

| Feature | Used when |
|---|---|
| `pause` | play/pause tapped in `stream` or `reading` |
| `hold` | long-press to hold a verse |
| `mode_reading` | switched to the "Báseň" mode |
| `mode_browsing` | switched to the "Čtení" mode |
| `poem_list` | the poem list opened |
| `poem_pick` | a poem picked from the list |
| `store` | the store sheet opened |
| `restore` | "Restore purchases" tapped |

## Common properties

Sent with every event.

| Property | Type | Values |
|---|---|---|
| `app_version` | enum | the app version (`kAppVersion`, checked against `pubspec.yaml`) |
| `platform` | enum | `ios`, `android`, `macos`, `windows`, `linux`, `other` |
| `lang` | enum | the app's language: `cs`, `en`, `sk` |
| `session_band` | band | session number: `1`, `2`, `3-5`, `6-10`, `11+` |
| `days_band` | band | days since measuring began: `0`, `1`, `2-6`, `7-29`, `30+`, `pre` |
| `first_session` | bool | the very first session of a new install |
| `tester` | bool | tester build |
| `owns_collection` | bool | this device has unlocked at least one paid collection |

`owns_collection` answers: do readers who paid use the app differently
(time, modes, return)?

## Events

### `app_open`

Cold start, or a new session after more than 30 minutes in the background.
Answers: the first-session funnel and the return milestones (2nd, 3rd, 6th,
11th session; day 1, 2, 7, 30).

| Property | Type | Values |
|---|---|---|
| `start` | enum | `cold`, `resume` |
| `session_band_first` | bool | the first session of this install in its `session_band` |
| `days_band_first` | bool | the first session of this install in its `days_band` |
| `campaign` | campaign | optional; QR campaign of a new install, `^[a-z0-9-]{1,24}$` |

### `screen_view`

A screen appeared. Answers: what a new reader does after the first launch,
which mode readers end up in, switching back and forth.

| Property | Type | Values |
|---|---|---|
| `screen` | enum | `stream`, `reading`, `browsing`, `store`, `poem_list`, `other` |
| `prev` | enum | the previous screen, or `none` |

### `screen_leave`

A screen was left. Answers: how long readers stay in each mode, by session
band.

| Property | Type | Values |
|---|---|---|
| `screen` | enum | as in `screen_view` |
| `secs` | int | foreground seconds on the screen |
| `actions` | int | app events, feature uses and locked taps during the stay |

### `session_pause`

The app went to the background or is closing. Sent at once. Answers: when
and where readers stop.

| Property | Type | Values |
|---|---|---|
| `active_secs` | int | foreground seconds in this session |
| `screen` | enum | the screen at the time, or `none` |
| `screen_secs` | int | foreground seconds on that screen |

### `activation`

The first poem read to its end on this install. Once per install. Answers:
how many new readers get to the first real use, and how fast.

| Property | Type | Values |
|---|---|---|
| `secs` | int | seconds since this session's `app_open` |

### `feature_use`

The first use of a feature in a session. Answers: which features are used.

| Property | Type | Values |
|---|---|---|
| `feature` | enum | `pause`, `hold`, `mode_reading`, `mode_browsing`, `poem_list`, `poem_pick`, `store`, `restore` |

### `feature_snapshot`

After `app_open` of the 3rd, 6th and 11th session: which features this
install has ever used. Answers: what advanced readers never use.

| Property | Type | Values |
|---|---|---|
| `f_pause` | bool | play/pause used |
| `f_hold` | bool | long-press hold used |
| `f_mode_reading` | bool | "Báseň" mode used |
| `f_mode_browsing` | bool | "Čtení" mode used |
| `f_poem_list` | bool | poem list opened |
| `f_poem_pick` | bool | a poem picked from the list |
| `f_store` | bool | store sheet opened |
| `f_restore` | bool | restore tapped |
| `features_used` | int | how many of them |

### `error_shown`

The reader saw an error. Answers: where readers struggle.

| Property | Type | Values |
|---|---|---|
| `kind` | enum | `purchase` (the purchase failed), `store_unavailable` (store sheet opened without a store) |
| `screen` | enum | the screen at the time, or `none` |

### `locked_tap`

A tap on something unavailable. Answers: where readers struggle.

| Property | Type | Values |
|---|---|---|
| `target` | enum | `buy_unavailable` (the buy button of a collection whose product the store did not return) |

### `poem_finish`

A poem was read to its end (see Activation). Answers: do readers read whole
poems, in which mode, and which collections.

| Property | Type | Values |
|---|---|---|
| `mode` | enum | `reading`, `browsing` |
| `collection` | enum | `default`, `jezis_hraje_na_sitar`, `kozni_ambulance`, `smrtelne_vazne`, `user`, `other` |

### `store_ready`

The store connection finished loading after a cold start. Answers: is the
store slow or unavailable (load time, performance data), which explains
failed purchases.

| Property | Type | Values |
|---|---|---|
| `available` | bool | the store is available |
| `products` | int | collections the store returned |
| `ms` | int | milliseconds from start to ready, capped at 60000 |

### `purchase_start`

"Buy" tapped on a collection. Answers: how many readers try to buy, and
which collection.

| Property | Type | Values |
|---|---|---|
| `collection` | enum | `kozni_ambulance`, `smrtelne_vazne`, `other` |

### `purchase_end`

The purchase ended. Answers: share of cancelled and failed purchases, and
how long buying takes.

| Property | Type | Values |
|---|---|---|
| `result` | enum | `ok`, `cancel`, `error`, `background` |
| `secs` | int | foreground seconds |
| `collection` | enum | as in `purchase_start` |

### `restore_start`

"Restore purchases" tapped (not the automatic restore of a fresh install).
Answers: how often readers need to restore.

| Property | Type | Values |
|---|---|---|

### `restore_end`

The restore ended. Answers: does restoring work.

| Property | Type | Values |
|---|---|---|
| `result` | enum | `ok`, `cancel`, `error`, `background` |
| `secs` | int | foreground seconds |
| `collections` | int | collections newly unlocked by this restore |
