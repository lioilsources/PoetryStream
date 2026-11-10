// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get modeStream => 'Flux';

  @override
  String get modePoem => 'Poème';

  @override
  String get modeReading => 'Lecture';

  @override
  String get noPoems => 'Aucun poème';

  @override
  String get playbackLive => 'EN DIRECT';

  @override
  String get playbackPaused => 'PAUSE';

  @override
  String get addPoemButton => '+ POÈME';

  @override
  String get pastePoemTitle => 'Coller un poème';

  @override
  String get save => 'ENREGISTRER';

  @override
  String get pastePoemHint =>
      'Première ligne = titre du poème\n\nTexte du poème…';

  @override
  String get storeTitle => 'Recueils de poésie';

  @override
  String get storeUnavailable =>
      'Boutique indisponible. Vérifiez votre connexion.';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get unlocked => 'DÉBLOQUÉ';

  @override
  String get buy => 'ACHETER';

  @override
  String get poemsButton => 'POÈMES';

  @override
  String get collections => 'Recueils';

  @override
  String get myPoems => 'Mes poèmes';

  @override
  String get purchaseFailed => 'L\'achat a échoué.';

  @override
  String get purchaseError => 'Erreur d\'achat.';

  @override
  String buyWithPrice(String price) {
    return 'ACHETER $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poème $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poèmes',
      one: '$count poème',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strophes',
      one: '$count strophe',
    );
    return '$_temp0';
  }
}
