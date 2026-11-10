// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get modeStream => 'Dòng chảy';

  @override
  String get modePoem => 'Bài thơ';

  @override
  String get modeReading => 'Đọc';

  @override
  String get noPoems => 'Chưa có bài thơ';

  @override
  String get playbackLive => 'TRỰC TIẾP';

  @override
  String get playbackPaused => 'TẠM DỪNG';

  @override
  String get addPoemButton => '+ BÀI THƠ';

  @override
  String get pastePoemTitle => 'Dán bài thơ';

  @override
  String get save => 'LƯU';

  @override
  String get pastePoemHint => 'Dòng đầu = tên bài thơ\n\nNội dung bài thơ…';

  @override
  String get storeTitle => 'Tuyển tập thơ';

  @override
  String get storeUnavailable =>
      'Cửa hàng không khả dụng. Hãy kiểm tra kết nối.';

  @override
  String get restorePurchases => 'Khôi phục giao dịch mua';

  @override
  String get unlocked => 'ĐÃ MỞ KHÓA';

  @override
  String get buy => 'MUA';

  @override
  String get poemsButton => 'THƠ';

  @override
  String get collections => 'Tuyển tập';

  @override
  String get myPoems => 'Thơ của tôi';

  @override
  String get purchaseFailed => 'Mua không thành công.';

  @override
  String get purchaseError => 'Lỗi khi mua.';

  @override
  String buyWithPrice(String price) {
    return 'MUA $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Bài thơ $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bài thơ',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count khổ thơ',
    );
    return '$_temp0';
  }
}
