// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get modeStream => '스트림';

  @override
  String get modePoem => '시';

  @override
  String get modeReading => '읽기';

  @override
  String get noPoems => '시가 없습니다';

  @override
  String get playbackLive => '라이브';

  @override
  String get playbackPaused => '일시정지';

  @override
  String get addPoemButton => '+ 시';

  @override
  String get pastePoemTitle => '시 붙여넣기';

  @override
  String get save => '저장';

  @override
  String get pastePoemHint => '첫 줄 = 시 제목\n\n시 본문…';

  @override
  String get storeTitle => '시집';

  @override
  String get storeUnavailable => '스토어를 사용할 수 없습니다. 연결을 확인하세요.';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get unlocked => '잠금 해제됨';

  @override
  String get buy => '구매';

  @override
  String get poemsButton => '시';

  @override
  String get collections => '시집';

  @override
  String get myPoems => '내 시';

  @override
  String get purchaseFailed => '구매에 실패했습니다.';

  @override
  String get purchaseError => '구매 오류.';

  @override
  String buyWithPrice(String price) {
    return '$price에 구매';
  }

  @override
  String poemFallbackTitle(int number) {
    return '시 $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '시 $count편',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count연',
    );
    return '$_temp0';
  }
}
