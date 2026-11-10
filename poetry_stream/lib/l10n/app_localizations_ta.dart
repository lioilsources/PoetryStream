// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get modeStream => 'ஓடை';

  @override
  String get modePoem => 'கவிதை';

  @override
  String get modeReading => 'வாசிப்பு';

  @override
  String get noPoems => 'கவிதைகள் இல்லை';

  @override
  String get playbackLive => 'நேரலை';

  @override
  String get playbackPaused => 'இடைநிறுத்தம்';

  @override
  String get addPoemButton => '+ கவிதை';

  @override
  String get pastePoemTitle => 'கவிதையை ஒட்டுங்கள்';

  @override
  String get save => 'சேமி';

  @override
  String get pastePoemHint => 'முதல் வரி = கவிதையின் தலைப்பு\n\nகவிதையின் உரை…';

  @override
  String get storeTitle => 'கவிதைத் தொகுப்புகள்';

  @override
  String get storeUnavailable => 'கடை கிடைக்கவில்லை. இணைப்பைச் சரிபார்க்கவும்.';

  @override
  String get restorePurchases => 'வாங்கியவற்றை மீட்டெடு';

  @override
  String get unlocked => 'திறக்கப்பட்டது';

  @override
  String get buy => 'வாங்கு';

  @override
  String get poemsButton => 'கவிதைகள்';

  @override
  String get collections => 'தொகுப்புகள்';

  @override
  String get myPoems => 'என் கவிதைகள்';

  @override
  String get purchaseFailed => 'வாங்குதல் தோல்வியடைந்தது.';

  @override
  String get purchaseError => 'வாங்குதலில் பிழை.';

  @override
  String buyWithPrice(String price) {
    return '$priceக்கு வாங்கு';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'கவிதை $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count கவிதைகள்',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பத்திகள்',
    );
    return '$_temp0';
  }
}
