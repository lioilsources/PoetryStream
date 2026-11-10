// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get modeStream => '流';

  @override
  String get modePoem => '诗歌';

  @override
  String get modeReading => '阅读';

  @override
  String get noPoems => '暂无诗歌';

  @override
  String get playbackLive => '直播中';

  @override
  String get playbackPaused => '已暂停';

  @override
  String get addPoemButton => '＋诗歌';

  @override
  String get pastePoemTitle => '粘贴诗歌';

  @override
  String get save => '保存';

  @override
  String get pastePoemHint => '第一行 = 诗歌标题\n\n诗歌正文…';

  @override
  String get storeTitle => '诗集';

  @override
  String get storeUnavailable => '商店不可用。请检查网络连接。';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get unlocked => '已解锁';

  @override
  String get buy => '购买';

  @override
  String get poemsButton => '诗歌';

  @override
  String get collections => '诗集';

  @override
  String get myPoems => '我的诗歌';

  @override
  String get purchaseFailed => '购买失败。';

  @override
  String get purchaseError => '购买出错。';

  @override
  String buyWithPrice(String price) {
    return '购买 $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return '诗歌 $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 首诗',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 节',
    );
    return '$_temp0';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get modeStream => '流';

  @override
  String get modePoem => '诗歌';

  @override
  String get modeReading => '阅读';

  @override
  String get noPoems => '暂无诗歌';

  @override
  String get playbackLive => '直播中';

  @override
  String get playbackPaused => '已暂停';

  @override
  String get addPoemButton => '＋诗歌';

  @override
  String get pastePoemTitle => '粘贴诗歌';

  @override
  String get save => '保存';

  @override
  String get pastePoemHint => '第一行 = 诗歌标题\n\n诗歌正文…';

  @override
  String get storeTitle => '诗集';

  @override
  String get storeUnavailable => '商店不可用。请检查网络连接。';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get unlocked => '已解锁';

  @override
  String get buy => '购买';

  @override
  String get poemsButton => '诗歌';

  @override
  String get collections => '诗集';

  @override
  String get myPoems => '我的诗歌';

  @override
  String get purchaseFailed => '购买失败。';

  @override
  String get purchaseError => '购买出错。';

  @override
  String buyWithPrice(String price) {
    return '购买 $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return '诗歌 $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 首诗',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 节',
    );
    return '$_temp0';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get modeStream => '串流';

  @override
  String get modePoem => '詩歌';

  @override
  String get modeReading => '閱讀';

  @override
  String get noPoems => '尚無詩歌';

  @override
  String get playbackLive => '直播中';

  @override
  String get playbackPaused => '已暫停';

  @override
  String get addPoemButton => '＋詩歌';

  @override
  String get pastePoemTitle => '貼上詩歌';

  @override
  String get save => '儲存';

  @override
  String get pastePoemHint => '第一行 = 詩歌標題\n\n詩歌內文…';

  @override
  String get storeTitle => '詩集';

  @override
  String get storeUnavailable => '商店無法使用。請檢查網路連線。';

  @override
  String get restorePurchases => '恢復購買';

  @override
  String get unlocked => '已解鎖';

  @override
  String get buy => '購買';

  @override
  String get poemsButton => '詩歌';

  @override
  String get collections => '詩集';

  @override
  String get myPoems => '我的詩歌';

  @override
  String get purchaseFailed => '購買失敗。';

  @override
  String get purchaseError => '購買發生錯誤。';

  @override
  String buyWithPrice(String price) {
    return '購買 $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return '詩歌 $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 首詩',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 節',
    );
    return '$_temp0';
  }
}
