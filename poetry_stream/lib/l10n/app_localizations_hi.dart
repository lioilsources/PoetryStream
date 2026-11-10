// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get modeStream => 'स्ट्रीम';

  @override
  String get modePoem => 'कविता';

  @override
  String get modeReading => 'पठन';

  @override
  String get noPoems => 'कोई कविता नहीं';

  @override
  String get playbackLive => 'लाइव';

  @override
  String get playbackPaused => 'विराम';

  @override
  String get addPoemButton => '+ कविता';

  @override
  String get pastePoemTitle => 'कविता चिपकाएँ';

  @override
  String get save => 'सहेजें';

  @override
  String get pastePoemHint => 'पहली पंक्ति = कविता का शीर्षक\n\nकविता का पाठ…';

  @override
  String get storeTitle => 'कविता संग्रह';

  @override
  String get storeUnavailable => 'स्टोर उपलब्ध नहीं है। अपना कनेक्शन जाँचें।';

  @override
  String get restorePurchases => 'ख़रीदारी बहाल करें';

  @override
  String get unlocked => 'अनलॉक';

  @override
  String get buy => 'ख़रीदें';

  @override
  String get poemsButton => 'कविताएँ';

  @override
  String get collections => 'संग्रह';

  @override
  String get myPoems => 'मेरी कविताएँ';

  @override
  String get purchaseFailed => 'ख़रीदारी विफल रही।';

  @override
  String get purchaseError => 'ख़रीदारी में त्रुटि।';

  @override
  String buyWithPrice(String price) {
    return '$price में ख़रीदें';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'कविता $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count कविताएँ',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count छंद',
    );
    return '$_temp0';
  }
}
