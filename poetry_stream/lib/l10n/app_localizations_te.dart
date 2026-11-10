// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get modeStream => 'స్ట్రీమ్';

  @override
  String get modePoem => 'కవిత';

  @override
  String get modeReading => 'పఠనం';

  @override
  String get noPoems => 'కవితలు లేవు';

  @override
  String get playbackLive => 'లైవ్';

  @override
  String get playbackPaused => 'విరామం';

  @override
  String get addPoemButton => '+ కవిత';

  @override
  String get pastePoemTitle => 'కవితను అతికించండి';

  @override
  String get save => 'సేవ్';

  @override
  String get pastePoemHint => 'మొదటి పంక్తి = కవిత శీర్షిక\n\nకవిత పాఠం…';

  @override
  String get storeTitle => 'కవితా సంకలనాలు';

  @override
  String get storeUnavailable =>
      'స్టోర్ అందుబాటులో లేదు. కనెక్షన్ తనిఖీ చేయండి.';

  @override
  String get restorePurchases => 'కొనుగోళ్లను పునరుద్ధరించండి';

  @override
  String get unlocked => 'అన్‌లాక్ అయింది';

  @override
  String get buy => 'కొనండి';

  @override
  String get poemsButton => 'కవితలు';

  @override
  String get collections => 'సంకలనాలు';

  @override
  String get myPoems => 'నా కవితలు';

  @override
  String get purchaseFailed => 'కొనుగోలు విఫలమైంది.';

  @override
  String get purchaseError => 'కొనుగోలు లోపం.';

  @override
  String buyWithPrice(String price) {
    return '$priceకి కొనండి';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'కవిత $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count కవితలు',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count చరణాలు',
    );
    return '$_temp0';
  }
}
