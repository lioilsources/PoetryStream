import 'package:ol1n_telemetry/ol1n_telemetry.dart';

import '../l10n/app_localizations.dart';

/// The app version this build reports; `test/telemetry_test.dart` keeps it
/// equal to `version:` in `pubspec.yaml`.
const kAppVersion = '2.2.2';

/// Screens. The app has no routes: the three display modes are the main
/// screens, the two bottom sheets are reported while they are open.
const kScreens = {'stream', 'reading', 'browsing', 'store', 'poem_list'};

/// Collection id (the file name in `assets/poems/`, or `user`) → the value
/// sent. A collection missing here is sent as `other`; the test keeps every
/// bundled collection listed.
const kCollectionIds = {
  'default': 'default',
  'Ježíš hraje na sitár': 'jezis_hraje_na_sitar',
  'Kožní ambulance': 'kozni_ambulance',
  'Smrtelně vážně': 'smrtelne_vazne',
  'user': 'user',
};

const _collection = EnumProp({
  'default',
  'jezis_hraje_na_sitar',
  'kozni_ambulance',
  'smrtelne_vazne',
  'user',
  'other',
});

/// Paid collections (those with a `product_id`).
const _paidCollection = EnumProp({
  'kozni_ambulance',
  'smrtelne_vazne',
  'other',
});

/// The one event dictionary of Poesie, mirrored in `docs/telemetry.md`.
final poesieDictionary = TelemetryDictionary(
  appVersion: kAppVersion,
  languages: {
    for (final l in AppLocalizations.supportedLocales) telemetryLocaleId(l),
  },
  screens: kScreens,
  features: {
    'pause',
    'hold',
    'mode_reading',
    'mode_browsing',
    'poem_list',
    'poem_pick',
    'store',
    'restore',
  },
  errorKinds: {'purchase', 'store_unavailable'},
  lockedTargets: {'buy_unavailable'},
  common: {'owns_collection': const BoolProp()},
  events: {
    'poem_finish': {
      'mode': const EnumProp({'reading', 'browsing'}),
      'collection': _collection,
    },
    'store_ready': {
      'available': const BoolProp(),
      'products': const IntProp(100),
      'ms': const IntProp(60000),
    },
    ...TelemetryDictionary.flow(
      'purchase',
      start: {'collection': _paidCollection},
      end: {'collection': _paidCollection},
    ),
    ...TelemetryDictionary.flow(
      'restore',
      end: {'collections': const IntProp(100)},
    ),
  },
);
