// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get modeStream => 'ਸਟ੍ਰੀਮ';

  @override
  String get modePoem => 'ਕਵਿਤਾ';

  @override
  String get modeReading => 'ਪੜ੍ਹਨਾ';

  @override
  String get noPoems => 'ਕੋਈ ਕਵਿਤਾ ਨਹੀਂ';

  @override
  String get playbackLive => 'ਲਾਈਵ';

  @override
  String get playbackPaused => 'ਵਿਰਾਮ';

  @override
  String get addPoemButton => '+ ਕਵਿਤਾ';

  @override
  String get pastePoemTitle => 'ਕਵਿਤਾ ਚਿਪਕਾਓ';

  @override
  String get save => 'ਸੰਭਾਲੋ';

  @override
  String get pastePoemHint => 'ਪਹਿਲੀ ਸਤਰ = ਕਵਿਤਾ ਦਾ ਸਿਰਲੇਖ\n\nਕਵਿਤਾ ਦਾ ਪਾਠ…';

  @override
  String get storeTitle => 'ਕਾਵਿ ਸੰਗ੍ਰਹਿ';

  @override
  String get storeUnavailable => 'ਸਟੋਰ ਉਪਲਬਧ ਨਹੀਂ। ਆਪਣਾ ਕੁਨੈਕਸ਼ਨ ਜਾਂਚੋ।';

  @override
  String get restorePurchases => 'ਖਰੀਦਾਂ ਬਹਾਲ ਕਰੋ';

  @override
  String get unlocked => 'ਅਨਲੌਕ';

  @override
  String get buy => 'ਖਰੀਦੋ';

  @override
  String get poemsButton => 'ਕਵਿਤਾਵਾਂ';

  @override
  String get collections => 'ਸੰਗ੍ਰਹਿ';

  @override
  String get myPoems => 'ਮੇਰੀਆਂ ਕਵਿਤਾਵਾਂ';

  @override
  String get purchaseFailed => 'ਖਰੀਦ ਨਾਕਾਮ ਰਹੀ।';

  @override
  String get purchaseError => 'ਖਰੀਦ ਵਿੱਚ ਗਲਤੀ।';

  @override
  String buyWithPrice(String price) {
    return '$price ਵਿੱਚ ਖਰੀਦੋ';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'ਕਵਿਤਾ $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਕਵਿਤਾਵਾਂ',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ਬੰਦ',
    );
    return '$_temp0';
  }
}
