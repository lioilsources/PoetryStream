// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get modeStream => 'Ροή';

  @override
  String get modePoem => 'Ποίημα';

  @override
  String get modeReading => 'Ανάγνωση';

  @override
  String get noPoems => 'Κανένα ποίημα';

  @override
  String get playbackLive => 'ΖΩΝΤΑΝΑ';

  @override
  String get playbackPaused => 'ΠΑΥΣΗ';

  @override
  String get addPoemButton => '+ ΠΟΙΗΜΑ';

  @override
  String get pastePoemTitle => 'Επικόλληση ποιήματος';

  @override
  String get save => 'ΑΠΟΘΗΚΕΥΣΗ';

  @override
  String get pastePoemHint =>
      'Πρώτη γραμμή = τίτλος ποιήματος\n\nΚείμενο ποιήματος…';

  @override
  String get storeTitle => 'Ποιητικές συλλογές';

  @override
  String get storeUnavailable =>
      'Το κατάστημα δεν είναι διαθέσιμο. Ελέγξτε τη σύνδεσή σας.';

  @override
  String get restorePurchases => 'Επαναφορά αγορών';

  @override
  String get unlocked => 'ΞΕΚΛΕΙΔΩΜΕΝΟ';

  @override
  String get buy => 'ΑΓΟΡΑ';

  @override
  String get poemsButton => 'ΠΟΙΗΜΑΤΑ';

  @override
  String get collections => 'Συλλογές';

  @override
  String get myPoems => 'Τα ποιήματά μου';

  @override
  String get purchaseFailed => 'Η αγορά απέτυχε.';

  @override
  String get purchaseError => 'Σφάλμα αγοράς.';

  @override
  String buyWithPrice(String price) {
    return 'ΑΓΟΡΑ $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Ποίημα $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ποιήματα',
      one: '$count ποίημα',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count στροφές',
      one: '$count στροφή',
    );
    return '$_temp0';
  }
}
