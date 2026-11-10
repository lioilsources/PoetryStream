// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get modeStream => 'સ્ટ્રીમ';

  @override
  String get modePoem => 'કવિતા';

  @override
  String get modeReading => 'વાંચન';

  @override
  String get noPoems => 'કોઈ કવિતા નથી';

  @override
  String get playbackLive => 'લાઇવ';

  @override
  String get playbackPaused => 'થોભો';

  @override
  String get addPoemButton => '+ કવિતા';

  @override
  String get pastePoemTitle => 'કવિતા પેસ્ટ કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get pastePoemHint => 'પહેલી લીટી = કવિતાનું શીર્ષક\n\nકવિતાનો લખાણ…';

  @override
  String get storeTitle => 'કાવ્ય સંગ્રહો';

  @override
  String get storeUnavailable => 'સ્ટોર ઉપલબ્ધ નથી. કનેક્શન તપાસો.';

  @override
  String get restorePurchases => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get unlocked => 'અનલૉક';

  @override
  String get buy => 'ખરીદો';

  @override
  String get poemsButton => 'કવિતાઓ';

  @override
  String get collections => 'સંગ્રહો';

  @override
  String get myPoems => 'મારી કવિતાઓ';

  @override
  String get purchaseFailed => 'ખરીદી નિષ્ફળ ગઈ.';

  @override
  String get purchaseError => 'ખરીદીમાં ભૂલ.';

  @override
  String buyWithPrice(String price) {
    return '$price માં ખરીદો';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'કવિતા $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count કવિતા',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count કડી',
    );
    return '$_temp0';
  }
}
