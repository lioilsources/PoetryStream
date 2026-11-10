// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get modeStream => 'സ്ട്രീം';

  @override
  String get modePoem => 'കവിത';

  @override
  String get modeReading => 'വായന';

  @override
  String get noPoems => 'കവിതകളില്ല';

  @override
  String get playbackLive => 'തത്സമയം';

  @override
  String get playbackPaused => 'താൽക്കാലിക വിരാമം';

  @override
  String get addPoemButton => '+ കവിത';

  @override
  String get pastePoemTitle => 'കവിത ഒട്ടിക്കുക';

  @override
  String get save => 'സംരക്ഷിക്കുക';

  @override
  String get pastePoemHint =>
      'ആദ്യ വരി = കവിതയുടെ തലക്കെട്ട്\n\nകവിതയുടെ വാചകം…';

  @override
  String get storeTitle => 'കവിതാ സമാഹാരങ്ങൾ';

  @override
  String get storeUnavailable => 'സ്റ്റോർ ലഭ്യമല്ല. കണക്ഷൻ പരിശോധിക്കുക.';

  @override
  String get restorePurchases => 'വാങ്ങലുകൾ പുനഃസ്ഥാപിക്കുക';

  @override
  String get unlocked => 'തുറന്നത്';

  @override
  String get buy => 'വാങ്ങുക';

  @override
  String get poemsButton => 'കവിതകൾ';

  @override
  String get collections => 'സമാഹാരങ്ങൾ';

  @override
  String get myPoems => 'എന്റെ കവിതകൾ';

  @override
  String get purchaseFailed => 'വാങ്ങൽ പരാജയപ്പെട്ടു.';

  @override
  String get purchaseError => 'വാങ്ങലിൽ പിശക്.';

  @override
  String buyWithPrice(String price) {
    return '$price-ന് വാങ്ങുക';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'കവിത $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count കവിതകൾ',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ഖണ്ഡങ്ങൾ',
    );
    return '$_temp0';
  }
}
