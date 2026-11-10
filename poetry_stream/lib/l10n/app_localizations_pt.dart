// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get modeStream => 'Fluxo';

  @override
  String get modePoem => 'Poema';

  @override
  String get modeReading => 'Leitura';

  @override
  String get noPoems => 'Nenhum poema';

  @override
  String get playbackLive => 'AO VIVO';

  @override
  String get playbackPaused => 'PAUSADO';

  @override
  String get addPoemButton => '+ POEMA';

  @override
  String get pastePoemTitle => 'Colar um poema';

  @override
  String get save => 'SALVAR';

  @override
  String get pastePoemHint =>
      'Primeira linha = título do poema\n\nTexto do poema…';

  @override
  String get storeTitle => 'Coletâneas de poesia';

  @override
  String get storeUnavailable => 'Loja indisponível. Verifique sua conexão.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get unlocked => 'DESBLOQUEADO';

  @override
  String get buy => 'COMPRAR';

  @override
  String get poemsButton => 'POEMAS';

  @override
  String get collections => 'Coletâneas';

  @override
  String get myPoems => 'Meus poemas';

  @override
  String get purchaseFailed => 'A compra falhou.';

  @override
  String get purchaseError => 'Erro na compra.';

  @override
  String buyWithPrice(String price) {
    return 'COMPRAR $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poema $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poemas',
      one: '$count poema',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrofes',
      one: '$count estrofe',
    );
    return '$_temp0';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get modeStream => 'Fluxo';

  @override
  String get modePoem => 'Poema';

  @override
  String get modeReading => 'Leitura';

  @override
  String get noPoems => 'Nenhum poema';

  @override
  String get playbackLive => 'AO VIVO';

  @override
  String get playbackPaused => 'PAUSADO';

  @override
  String get addPoemButton => '+ POEMA';

  @override
  String get pastePoemTitle => 'Colar um poema';

  @override
  String get save => 'SALVAR';

  @override
  String get pastePoemHint =>
      'Primeira linha = título do poema\n\nTexto do poema…';

  @override
  String get storeTitle => 'Coletâneas de poesia';

  @override
  String get storeUnavailable => 'Loja indisponível. Verifique sua conexão.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get unlocked => 'DESBLOQUEADO';

  @override
  String get buy => 'COMPRAR';

  @override
  String get poemsButton => 'POEMAS';

  @override
  String get collections => 'Coletâneas';

  @override
  String get myPoems => 'Meus poemas';

  @override
  String get purchaseFailed => 'A compra falhou.';

  @override
  String get purchaseError => 'Erro na compra.';

  @override
  String buyWithPrice(String price) {
    return 'COMPRAR $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poema $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poemas',
      one: '$count poema',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrofes',
      one: '$count estrofe',
    );
    return '$_temp0';
  }
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get modeStream => 'Fluxo';

  @override
  String get modePoem => 'Poema';

  @override
  String get modeReading => 'Leitura';

  @override
  String get noPoems => 'Nenhum poema';

  @override
  String get playbackLive => 'EM DIRETO';

  @override
  String get playbackPaused => 'EM PAUSA';

  @override
  String get addPoemButton => '+ POEMA';

  @override
  String get pastePoemTitle => 'Colar um poema';

  @override
  String get save => 'GUARDAR';

  @override
  String get pastePoemHint =>
      'Primeira linha = título do poema\n\nTexto do poema…';

  @override
  String get storeTitle => 'Coletâneas de poesia';

  @override
  String get storeUnavailable => 'Loja indisponível. Verifique a ligação.';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get unlocked => 'DESBLOQUEADO';

  @override
  String get buy => 'COMPRAR';

  @override
  String get poemsButton => 'POEMAS';

  @override
  String get collections => 'Coletâneas';

  @override
  String get myPoems => 'Os meus poemas';

  @override
  String get purchaseFailed => 'A compra falhou.';

  @override
  String get purchaseError => 'Erro na compra.';

  @override
  String buyWithPrice(String price) {
    return 'COMPRAR $price';
  }

  @override
  String poemFallbackTitle(int number) {
    return 'Poema $number';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poemas',
      one: '$count poema',
    );
    return '$_temp0';
  }

  @override
  String stanzaCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estrofes',
      one: '$count estrofe',
    );
    return '$_temp0';
  }
}
