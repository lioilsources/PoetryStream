// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get modeStream => 'ଷ୍ଟ୍ରିମ୍';

  @override
  String get modePoem => 'କବିତା';

  @override
  String get modeReading => 'ପଠନ';

  @override
  String get noPoems => 'କୌଣସି କବିତା ନାହିଁ';

  @override
  String get playbackLive => 'ଲାଇଭ୍';

  @override
  String get playbackPaused => 'ବିରତି';

  @override
  String get addPoemButton => '+ କବିତା';

  @override
  String get pastePoemTitle => 'କବିତା ଲଗାନ୍ତୁ';

  @override
  String get save => 'ସଞ୍ଚୟ';

  @override
  String get pastePoemHint => 'ପ୍ରଥମ ଧାଡ଼ି = କବିତାର ଶୀର୍ଷକ\n\nକବିତାର ପାଠ…';

  @override
  String get storeTitle => 'କବିତା ସଂକଳନ';

  @override
  String get storeUnavailable => 'ଷ୍ଟୋର୍ ଉପଲବ୍ଧ ନାହିଁ। ସଂଯୋଗ ଯାଞ୍ଚ କରନ୍ତୁ।';

  @override
  String get restorePurchases => 'କ୍ରୟ ପୁନଃସ୍ଥାପନ';

  @override
  String get unlocked => 'ଖୋଲା ଯାଇଛି';

  @override
  String get buy => 'କିଣନ୍ତୁ';

  @override
  String get poemsButton => 'କବିତା';

  @override
  String get collections => 'ସଂକଳନ';

  @override
  String get myPoems => 'ମୋ କବିତା';

  @override
  String get purchaseFailed => 'କ୍ରୟ ବିଫଳ ହେଲା।';

  @override
  String get purchaseError => 'କ୍ରୟରେ ତ୍ରୁଟି।';

  @override
  String buyWithPrice(String price) {
    return '$price ରେ କିଣନ୍ତୁ';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'କବିତା $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countଟି କବିତା',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countଟି ସ୍ତବକ',
    );
    return '$_temp0';
  }
}
