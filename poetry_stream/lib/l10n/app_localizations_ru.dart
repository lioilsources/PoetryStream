// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get modeStream => 'Поток';

  @override
  String get modePoem => 'Стихотворение';

  @override
  String get modeReading => 'Чтение';

  @override
  String get noPoems => 'Нет стихотворений';

  @override
  String get playbackLive => 'ЭФИР';

  @override
  String get playbackPaused => 'ПАУЗА';

  @override
  String get addPoemButton => '+ СТИХ';

  @override
  String get pastePoemTitle => 'Вставить стихотворение';

  @override
  String get save => 'СОХРАНИТЬ';

  @override
  String get pastePoemHint =>
      'Первая строка = название стихотворения\n\nТекст стихотворения…';

  @override
  String get storeTitle => 'Сборники стихов';

  @override
  String get storeUnavailable => 'Магазин недоступен. Проверьте подключение.';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get unlocked => 'ОТКРЫТО';

  @override
  String get buy => 'КУПИТЬ';

  @override
  String get poemsButton => 'СТИХИ';

  @override
  String get collections => 'Сборники';

  @override
  String get myPoems => 'Мои стихи';

  @override
  String get purchaseFailed => 'Не удалось совершить покупку.';

  @override
  String get purchaseError => 'Ошибка покупки.';

  @override
  String buyWithPrice(String price) {
    return 'КУПИТЬ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Стихотворение $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count стихотворения',
      many: '$count стихотворений',
      few: '$count стихотворения',
      one: '$count стихотворение',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count строфы',
      many: '$count строф',
      few: '$count строфы',
      one: '$count строфа',
    );
    return '$_temp0';
  }
}
