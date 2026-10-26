import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_en.dart';
import 'app_localizations_sk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('en'),
    Locale('sk'),
  ];

  /// Display mode: verses streaming one by one
  ///
  /// In cs, this message translates to:
  /// **'Stream'**
  String get modeStream;

  /// Display mode: whole poem stanza by stanza
  ///
  /// In cs, this message translates to:
  /// **'Báseň'**
  String get modePoem;

  /// Display mode: scrolling reading view
  ///
  /// In cs, this message translates to:
  /// **'Čtení'**
  String get modeReading;

  /// Empty state in reading view
  ///
  /// In cs, this message translates to:
  /// **'Žádné básně'**
  String get noPoems;

  /// Play/pause button label while playing
  ///
  /// In cs, this message translates to:
  /// **'ŽIVĚ'**
  String get playbackLive;

  /// Play/pause button label while paused
  ///
  /// In cs, this message translates to:
  /// **'PAUZA'**
  String get playbackPaused;

  /// Button opening the paste-poem sheet
  ///
  /// In cs, this message translates to:
  /// **'+ BÁSEŇ'**
  String get addPoemButton;

  /// Title of the paste-poem sheet
  ///
  /// In cs, this message translates to:
  /// **'Vložit báseň'**
  String get pastePoemTitle;

  /// Save button
  ///
  /// In cs, this message translates to:
  /// **'ULOŽIT'**
  String get save;

  /// Hint in the paste-poem text field
  ///
  /// In cs, this message translates to:
  /// **'První řádek = název básně\n\nText básně…'**
  String get pastePoemHint;

  /// Store sheet header
  ///
  /// In cs, this message translates to:
  /// **'Sbírky básní'**
  String get storeTitle;

  /// Store not available message
  ///
  /// In cs, this message translates to:
  /// **'Obchod není dostupný. Zkontrolujte připojení.'**
  String get storeUnavailable;

  /// Restore purchases button
  ///
  /// In cs, this message translates to:
  /// **'Obnovit nákupy'**
  String get restorePurchases;

  /// Badge on an owned collection
  ///
  /// In cs, this message translates to:
  /// **'ODEMČENO'**
  String get unlocked;

  /// Buy button without known price
  ///
  /// In cs, this message translates to:
  /// **'KOUPIT'**
  String get buy;

  /// Button opening the poem list
  ///
  /// In cs, this message translates to:
  /// **'BÁSNĚ'**
  String get poemsButton;

  /// Section header in the poem list
  ///
  /// In cs, this message translates to:
  /// **'Sbírky'**
  String get collections;

  /// Name of the user's own pasted poems collection
  ///
  /// In cs, this message translates to:
  /// **'Moje básně'**
  String get myPoems;

  /// Purchase could not be started
  ///
  /// In cs, this message translates to:
  /// **'Nákup se nezdařil.'**
  String get purchaseFailed;

  /// Fallback store error message
  ///
  /// In cs, this message translates to:
  /// **'Chyba při nákupu.'**
  String get purchaseError;

  /// Buy button with localized store price
  ///
  /// In cs, this message translates to:
  /// **'KOUPIT {price}'**
  String buyWithPrice(String price);

  /// Title for a poem without a title
  ///
  /// In cs, this message translates to:
  /// **'Báseň {number}'**
  String poemFallbackTitle(int number);

  /// Number of poems in a collection
  ///
  /// In cs, this message translates to:
  /// **'{count, plural, =1{1 báseň} few{{count} básně} other{{count} básní}}'**
  String poemCount(int count);

  /// Number of stanzas in a poem
  ///
  /// In cs, this message translates to:
  /// **'{count, plural, =1{1 strofa} few{{count} strofy} other{{count} strof}}'**
  String stanzaCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['cs', 'en', 'sk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return AppLocalizationsCs();
    case 'en':
      return AppLocalizationsEn();
    case 'sk':
      return AppLocalizationsSk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
