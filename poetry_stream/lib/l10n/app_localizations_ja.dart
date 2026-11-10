// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get modeStream => 'ストリーム';

  @override
  String get modePoem => '詩';

  @override
  String get modeReading => '読書';

  @override
  String get noPoems => '詩がありません';

  @override
  String get playbackLive => 'ライブ';

  @override
  String get playbackPaused => '一時停止';

  @override
  String get addPoemButton => '＋詩';

  @override
  String get pastePoemTitle => '詩を貼り付け';

  @override
  String get save => '保存';

  @override
  String get pastePoemHint => '1行目 = 詩のタイトル\n\n詩の本文…';

  @override
  String get storeTitle => '詩集';

  @override
  String get storeUnavailable => 'ストアを利用できません。接続を確認してください。';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get unlocked => '解除済み';

  @override
  String get buy => '購入';

  @override
  String get poemsButton => '詩';

  @override
  String get collections => '詩集';

  @override
  String get myPoems => 'マイ詩';

  @override
  String get purchaseFailed => '購入に失敗しました。';

  @override
  String get purchaseError => '購入エラー。';

  @override
  String buyWithPrice(String price) {
    return '$priceで購入';
  }

  @override
  String poemFallbackTitle(int number) {
    return '詩 $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count篇の詩',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count連',
    );
    return '$_temp0';
  }
}
