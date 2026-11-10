// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get modeStream => 'ಸ್ಟ್ರೀಮ್';

  @override
  String get modePoem => 'ಕವನ';

  @override
  String get modeReading => 'ಓದು';

  @override
  String get noPoems => 'ಯಾವುದೇ ಕವನಗಳಿಲ್ಲ';

  @override
  String get playbackLive => 'ನೇರ';

  @override
  String get playbackPaused => 'ವಿರಾಮ';

  @override
  String get addPoemButton => '+ ಕವನ';

  @override
  String get pastePoemTitle => 'ಕವನ ಅಂಟಿಸಿ';

  @override
  String get save => 'ಉಳಿಸಿ';

  @override
  String get pastePoemHint => 'ಮೊದಲ ಸಾಲು = ಕವನದ ಶೀರ್ಷಿಕೆ\n\nಕವನದ ಪಠ್ಯ…';

  @override
  String get storeTitle => 'ಕವನ ಸಂಕಲನಗಳು';

  @override
  String get storeUnavailable => 'ಸ್ಟೋರ್ ಲಭ್ಯವಿಲ್ಲ. ನಿಮ್ಮ ಸಂಪರ್ಕ ಪರಿಶೀಲಿಸಿ.';

  @override
  String get restorePurchases => 'ಖರೀದಿಗಳನ್ನು ಮರುಸ್ಥಾಪಿಸಿ';

  @override
  String get unlocked => 'ಅನ್‌ಲಾಕ್ ಆಗಿದೆ';

  @override
  String get buy => 'ಖರೀದಿಸಿ';

  @override
  String get poemsButton => 'ಕವನಗಳು';

  @override
  String get collections => 'ಸಂಕಲನಗಳು';

  @override
  String get myPoems => 'ನನ್ನ ಕವನಗಳು';

  @override
  String get purchaseFailed => 'ಖರೀದಿ ವಿಫಲವಾಯಿತು.';

  @override
  String get purchaseError => 'ಖರೀದಿ ದೋಷ.';

  @override
  String buyWithPrice(String price) {
    return '$price ಗೆ ಖರೀದಿಸಿ';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'ಕವನ $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ಕವನಗಳು',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ನುಡಿಗಳು',
    );
    return '$_temp0';
  }
}
