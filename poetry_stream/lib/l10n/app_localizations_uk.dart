// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get modeStream => 'Потік';

  @override
  String get modePoem => 'Вірш';

  @override
  String get modeReading => 'Читання';

  @override
  String get noPoems => 'Немає віршів';

  @override
  String get playbackLive => 'ЕФІР';

  @override
  String get playbackPaused => 'ПАУЗА';

  @override
  String get addPoemButton => '+ ВІРШ';

  @override
  String get pastePoemTitle => 'Вставити вірш';

  @override
  String get save => 'ЗБЕРЕГТИ';

  @override
  String get pastePoemHint => 'Перший рядок = назва вірша\n\nТекст вірша…';

  @override
  String get storeTitle => 'Збірки віршів';

  @override
  String get storeUnavailable => 'Магазин недоступний. Перевірте підключення.';

  @override
  String get restorePurchases => 'Відновити покупки';

  @override
  String get unlocked => 'ВІДКРИТО';

  @override
  String get buy => 'КУПИТИ';

  @override
  String get poemsButton => 'ВІРШІ';

  @override
  String get collections => 'Збірки';

  @override
  String get myPoems => 'Мої вірші';

  @override
  String get purchaseFailed => 'Не вдалося здійснити покупку.';

  @override
  String get purchaseError => 'Помилка покупки.';

  @override
  String buyWithPrice(String price) {
    return 'КУПИТИ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Вірш $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count вірша',
      many: '$count віршів',
      few: '$count вірші',
      one: '$count вірш',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count строфи',
      many: '$count строф',
      few: '$count строфи',
      one: '$count строфа',
    );
    return '$_temp0';
  }
}
