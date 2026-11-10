// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get modeStream => 'स्ट्रीम';

  @override
  String get modePoem => 'कविता';

  @override
  String get modeReading => 'वाचन';

  @override
  String get noPoems => 'कविता नाहीत';

  @override
  String get playbackLive => 'लाइव्ह';

  @override
  String get playbackPaused => 'विराम';

  @override
  String get addPoemButton => '+ कविता';

  @override
  String get pastePoemTitle => 'कविता चिकटवा';

  @override
  String get save => 'जतन करा';

  @override
  String get pastePoemHint => 'पहिली ओळ = कवितेचे शीर्षक\n\nकवितेचा मजकूर…';

  @override
  String get storeTitle => 'काव्यसंग्रह';

  @override
  String get storeUnavailable => 'स्टोअर उपलब्ध नाही. कनेक्शन तपासा.';

  @override
  String get restorePurchases => 'खरेदी पुनर्संचयित करा';

  @override
  String get unlocked => 'अनलॉक केले';

  @override
  String get buy => 'खरेदी करा';

  @override
  String get poemsButton => 'कविता';

  @override
  String get collections => 'संग्रह';

  @override
  String get myPoems => 'माझ्या कविता';

  @override
  String get purchaseFailed => 'खरेदी अयशस्वी झाली.';

  @override
  String get purchaseError => 'खरेदीत त्रुटी.';

  @override
  String buyWithPrice(String price) {
    return '$price मध्ये खरेदी करा';
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
      other: '$count कविता',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count कडवी',
    );
    return '$_temp0';
  }
}
