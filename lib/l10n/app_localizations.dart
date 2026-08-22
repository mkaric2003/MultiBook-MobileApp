import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bs.dart';
import 'app_localizations_en.dart';

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
    Locale('bs'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In bs, this message translates to:
  /// **'MultiBook'**
  String get appName;

  /// No description provided for @language.
  ///
  /// In bs, this message translates to:
  /// **'Jezik'**
  String get language;

  /// No description provided for @languageAndLocalization.
  ///
  /// In bs, this message translates to:
  /// **'Jezik i lokalizacija'**
  String get languageAndLocalization;

  /// No description provided for @languageAndCurrency.
  ///
  /// In bs, this message translates to:
  /// **'Jezik i valuta'**
  String get languageAndCurrency;

  /// No description provided for @selectLanguage.
  ///
  /// In bs, this message translates to:
  /// **'Odaberi jezik'**
  String get selectLanguage;

  /// No description provided for @bosnian.
  ///
  /// In bs, this message translates to:
  /// **'Bosanski'**
  String get bosnian;

  /// No description provided for @english.
  ///
  /// In bs, this message translates to:
  /// **'Engleski'**
  String get english;

  /// No description provided for @cancel.
  ///
  /// In bs, this message translates to:
  /// **'Odustani'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In bs, this message translates to:
  /// **'Gotovo'**
  String get done;

  /// No description provided for @save.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvaj'**
  String get save;

  /// No description provided for @profile.
  ///
  /// In bs, this message translates to:
  /// **'Profil'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In bs, this message translates to:
  /// **'Uredi profil'**
  String get editProfile;

  /// No description provided for @account.
  ///
  /// In bs, this message translates to:
  /// **'Račun'**
  String get account;

  /// No description provided for @myBookings.
  ///
  /// In bs, this message translates to:
  /// **'Moje rezervacije'**
  String get myBookings;

  /// No description provided for @saved.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvano'**
  String get saved;

  /// No description provided for @paymentMethods.
  ///
  /// In bs, this message translates to:
  /// **'Načini plaćanja'**
  String get paymentMethods;

  /// No description provided for @notifications.
  ///
  /// In bs, this message translates to:
  /// **'Notifikacije'**
  String get notifications;

  /// No description provided for @messages.
  ///
  /// In bs, this message translates to:
  /// **'Poruke'**
  String get messages;

  /// No description provided for @support.
  ///
  /// In bs, this message translates to:
  /// **'Podrška'**
  String get support;

  /// No description provided for @helpCenter.
  ///
  /// In bs, this message translates to:
  /// **'Centar za pomoć'**
  String get helpCenter;

  /// No description provided for @contactUs.
  ///
  /// In bs, this message translates to:
  /// **'Kontaktirajte nas'**
  String get contactUs;

  /// No description provided for @termsOfService.
  ///
  /// In bs, this message translates to:
  /// **'Uslovi korištenja'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In bs, this message translates to:
  /// **'Pravila privatnosti'**
  String get privacyPolicy;

  /// No description provided for @logOut.
  ///
  /// In bs, this message translates to:
  /// **'Odjavi se'**
  String get logOut;

  /// No description provided for @signInTitle.
  ///
  /// In bs, this message translates to:
  /// **'Prijavite se na MultiBook'**
  String get signInTitle;

  /// No description provided for @signInDescription.
  ///
  /// In bs, this message translates to:
  /// **'Pristupite svojim rezervacijama i omiljenim\nuslugama odmah.'**
  String get signInDescription;

  /// No description provided for @signIn.
  ///
  /// In bs, this message translates to:
  /// **'Prijavi se'**
  String get signIn;

  /// No description provided for @forgotPassword.
  ///
  /// In bs, this message translates to:
  /// **'Zaboravili ste lozinku?'**
  String get forgotPassword;

  /// No description provided for @continueWithApple.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi s Appleom'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi s Googleom'**
  String get continueWithGoogle;

  /// No description provided for @dontHaveAccount.
  ///
  /// In bs, this message translates to:
  /// **'Nemate račun?'**
  String get dontHaveAccount;

  /// No description provided for @createOne.
  ///
  /// In bs, this message translates to:
  /// **'Kreirajte ga'**
  String get createOne;

  /// No description provided for @appleSignInSoon.
  ///
  /// In bs, this message translates to:
  /// **'Apple prijava uskoro će biti dostupna.'**
  String get appleSignInSoon;

  /// No description provided for @signUpTitle.
  ///
  /// In bs, this message translates to:
  /// **'Kreirajte MultiBook račun'**
  String get signUpTitle;

  /// No description provided for @signUpDescription.
  ///
  /// In bs, this message translates to:
  /// **'Pridružite se hiljadama korisnika koji otkrivaju omiljeni smještaj i usluge.'**
  String get signUpDescription;

  /// No description provided for @createAccount.
  ///
  /// In bs, this message translates to:
  /// **'Kreiraj račun'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In bs, this message translates to:
  /// **'Već imate račun?'**
  String get alreadyHaveAccount;

  /// No description provided for @skip.
  ///
  /// In bs, this message translates to:
  /// **'Preskoči'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In bs, this message translates to:
  /// **'Započni'**
  String get getStarted;

  /// No description provided for @onboardingFirstTitle.
  ///
  /// In bs, this message translates to:
  /// **'Upravljajte smještajima i\nuslugama na jednom mjestu'**
  String get onboardingFirstTitle;

  /// No description provided for @onboardingFirstDescription.
  ///
  /// In bs, this message translates to:
  /// **'Jednostavno upravljajte hotelima, apartmanima i uslužnim businessima iz jedne aplikacije.'**
  String get onboardingFirstDescription;

  /// No description provided for @onboardingSecondTitle.
  ///
  /// In bs, this message translates to:
  /// **'Pratite rezervacije i\nzaradu jednostavno'**
  String get onboardingSecondTitle;

  /// No description provided for @onboardingSecondDescription.
  ///
  /// In bs, this message translates to:
  /// **'Budite u toku s rezervacijama i pratite prihode u stvarnom vremenu.'**
  String get onboardingSecondDescription;

  /// No description provided for @onboardingThirdTitle.
  ///
  /// In bs, this message translates to:
  /// **'Povežite se direktno\ns korisnicima'**
  String get onboardingThirdTitle;

  /// No description provided for @onboardingThirdDescription.
  ///
  /// In bs, this message translates to:
  /// **'Primajte trenutne notifikacije, upravljajte rezervacijama i razgovarajte s klijentima na jednom mjestu.'**
  String get onboardingThirdDescription;

  /// No description provided for @businessManagement.
  ///
  /// In bs, this message translates to:
  /// **'Upravljanje businessom'**
  String get businessManagement;

  /// No description provided for @financials.
  ///
  /// In bs, this message translates to:
  /// **'Finansije'**
  String get financials;

  /// No description provided for @notificationsAndCommunication.
  ///
  /// In bs, this message translates to:
  /// **'Notifikacije i komunikacija'**
  String get notificationsAndCommunication;

  /// No description provided for @settings.
  ///
  /// In bs, this message translates to:
  /// **'Postavke'**
  String get settings;

  /// No description provided for @businessProfile.
  ///
  /// In bs, this message translates to:
  /// **'Business profil'**
  String get businessProfile;

  /// No description provided for @manageStaysAndServices.
  ///
  /// In bs, this message translates to:
  /// **'Upravljanje smještajima i uslugama'**
  String get manageStaysAndServices;

  /// No description provided for @availabilityAndCalendar.
  ///
  /// In bs, this message translates to:
  /// **'Dostupnost i kalendar'**
  String get availabilityAndCalendar;

  /// No description provided for @promotionsAndDiscounts.
  ///
  /// In bs, this message translates to:
  /// **'Promocije i popusti'**
  String get promotionsAndDiscounts;

  /// No description provided for @payoutMethods.
  ///
  /// In bs, this message translates to:
  /// **'Načini isplate'**
  String get payoutMethods;

  /// No description provided for @transactionHistory.
  ///
  /// In bs, this message translates to:
  /// **'Historija transakcija'**
  String get transactionHistory;

  /// No description provided for @invoicesAndTaxInformation.
  ///
  /// In bs, this message translates to:
  /// **'Računi i poreske informacije'**
  String get invoicesAndTaxInformation;

  /// No description provided for @accountSettings.
  ///
  /// In bs, this message translates to:
  /// **'Postavke računa'**
  String get accountSettings;

  /// No description provided for @helpAndSupport.
  ///
  /// In bs, this message translates to:
  /// **'Pomoć i podrška'**
  String get helpAndSupport;

  /// No description provided for @orContinueWith.
  ///
  /// In bs, this message translates to:
  /// **'ili nastavi sa'**
  String get orContinueWith;

  /// No description provided for @selectCity.
  ///
  /// In bs, this message translates to:
  /// **'Odaberi grad'**
  String get selectCity;

  /// No description provided for @searchCities.
  ///
  /// In bs, this message translates to:
  /// **'Pretraži gradove'**
  String get searchCities;

  /// No description provided for @allCities.
  ///
  /// In bs, this message translates to:
  /// **'Svi gradovi'**
  String get allCities;

  /// No description provided for @noCitiesFound.
  ///
  /// In bs, this message translates to:
  /// **'Nema pronađenih gradova'**
  String get noCitiesFound;

  /// No description provided for @useCity.
  ///
  /// In bs, this message translates to:
  /// **'Koristi \"{city}\"'**
  String useCity(String city);

  /// No description provided for @emailAddressRequired.
  ///
  /// In bs, this message translates to:
  /// **'E-mail adresa*'**
  String get emailAddressRequired;

  /// No description provided for @enterYourEmail.
  ///
  /// In bs, this message translates to:
  /// **'Unesite email'**
  String get enterYourEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In bs, this message translates to:
  /// **'Lozinka*'**
  String get passwordRequired;

  /// No description provided for @enterYourPassword.
  ///
  /// In bs, this message translates to:
  /// **'Unesite lozinku'**
  String get enterYourPassword;

  /// No description provided for @firstNameRequired.
  ///
  /// In bs, this message translates to:
  /// **'Ime*'**
  String get firstNameRequired;

  /// No description provided for @lastName.
  ///
  /// In bs, this message translates to:
  /// **'Prezime'**
  String get lastName;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In bs, this message translates to:
  /// **'Potvrdite lozinku*'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordStrength.
  ///
  /// In bs, this message translates to:
  /// **'Jačina lozinke'**
  String get passwordStrength;

  /// No description provided for @passwordWeak.
  ///
  /// In bs, this message translates to:
  /// **'Slaba'**
  String get passwordWeak;

  /// No description provided for @passwordFair.
  ///
  /// In bs, this message translates to:
  /// **'Dovoljna'**
  String get passwordFair;

  /// No description provided for @passwordGood.
  ///
  /// In bs, this message translates to:
  /// **'Dobra'**
  String get passwordGood;

  /// No description provided for @passwordStrong.
  ///
  /// In bs, this message translates to:
  /// **'Jaka'**
  String get passwordStrong;

  /// No description provided for @atLeastEightCharacters.
  ///
  /// In bs, this message translates to:
  /// **'Najmanje 8 znakova'**
  String get atLeastEightCharacters;

  /// No description provided for @oneUppercaseLetter.
  ///
  /// In bs, this message translates to:
  /// **'Jedno veliko slovo'**
  String get oneUppercaseLetter;

  /// No description provided for @oneNumber.
  ///
  /// In bs, this message translates to:
  /// **'Jedan broj'**
  String get oneNumber;

  /// No description provided for @oneSymbol.
  ///
  /// In bs, this message translates to:
  /// **'Jedan simbol'**
  String get oneSymbol;

  /// No description provided for @agreeToPrefix.
  ///
  /// In bs, this message translates to:
  /// **'Slažem se sa '**
  String get agreeToPrefix;

  /// No description provided for @and.
  ///
  /// In bs, this message translates to:
  /// **' i '**
  String get and;

  /// No description provided for @useYourLocation.
  ///
  /// In bs, this message translates to:
  /// **'Koristi vašu lokaciju'**
  String get useYourLocation;

  /// No description provided for @locationPermissionDescription.
  ///
  /// In bs, this message translates to:
  /// **'Dozvolite MultiBooku korištenje trenutne lokacije kako bismo sačuvali vaš grad i prikazali relevantan smještaj i usluge u blizini.'**
  String get locationPermissionDescription;

  /// No description provided for @useCurrentLocation.
  ///
  /// In bs, this message translates to:
  /// **'Koristi trenutnu lokaciju'**
  String get useCurrentLocation;

  /// No description provided for @notNow.
  ///
  /// In bs, this message translates to:
  /// **'Ne sada'**
  String get notNow;

  /// No description provided for @locationUnavailable.
  ///
  /// In bs, this message translates to:
  /// **'Lokacija nije dostupna'**
  String get locationUnavailable;

  /// No description provided for @openSettings.
  ///
  /// In bs, this message translates to:
  /// **'Postavke'**
  String get openSettings;

  /// No description provided for @ok.
  ///
  /// In bs, this message translates to:
  /// **'U redu'**
  String get ok;

  /// No description provided for @userTypeTitle.
  ///
  /// In bs, this message translates to:
  /// **'Kako ćete koristiti MultiBook?'**
  String get userTypeTitle;

  /// No description provided for @userTypeDescription.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite iskustvo koje vam najviše odgovara. Ovo možete promijeniti kasnije.'**
  String get userTypeDescription;

  /// No description provided for @ownBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Vlasnik sam businessa'**
  String get ownBusiness;

  /// No description provided for @ownBusinessDescription.
  ///
  /// In bs, this message translates to:
  /// **'Upravljajte smještajima ili uslugama, rezervacijama i zaradom.'**
  String get ownBusinessDescription;

  /// No description provided for @customer.
  ///
  /// In bs, this message translates to:
  /// **'Ja sam korisnik'**
  String get customer;

  /// No description provided for @customerDescription.
  ///
  /// In bs, this message translates to:
  /// **'Rezervišite smještaj i termine za usluge na jednom mjestu.'**
  String get customerDescription;

  /// No description provided for @continueLabel.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi'**
  String get continueLabel;

  /// No description provided for @writeMessage.
  ///
  /// In bs, this message translates to:
  /// **'Napišite poruku'**
  String get writeMessage;

  /// No description provided for @seen.
  ///
  /// In bs, this message translates to:
  /// **'Viđeno'**
  String get seen;

  /// No description provided for @isTyping.
  ///
  /// In bs, this message translates to:
  /// **'{name} piše'**
  String isTyping(String name);

  /// No description provided for @noMessagesYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nema poruka.'**
  String get noMessagesYet;

  /// No description provided for @noNotificationsYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate notifikacija.'**
  String get noNotificationsYet;

  /// No description provided for @now.
  ///
  /// In bs, this message translates to:
  /// **'Sada'**
  String get now;

  /// No description provided for @minutesAgo.
  ///
  /// In bs, this message translates to:
  /// **'prije {count} min'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In bs, this message translates to:
  /// **'prije {count} h'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In bs, this message translates to:
  /// **'prije {count} d'**
  String daysAgo(int count);

  /// No description provided for @home.
  ///
  /// In bs, this message translates to:
  /// **'Početna'**
  String get home;

  /// No description provided for @bookings.
  ///
  /// In bs, this message translates to:
  /// **'Rezervacije'**
  String get bookings;

  /// No description provided for @explore.
  ///
  /// In bs, this message translates to:
  /// **'Istraži'**
  String get explore;

  /// No description provided for @stays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji'**
  String get stays;

  /// No description provided for @services.
  ///
  /// In bs, this message translates to:
  /// **'Usluge'**
  String get services;

  /// No description provided for @whereTo.
  ///
  /// In bs, this message translates to:
  /// **'Gdje želite ići?'**
  String get whereTo;

  /// No description provided for @findAService.
  ///
  /// In bs, this message translates to:
  /// **'Pronađi uslugu'**
  String get findAService;

  /// No description provided for @searchResults.
  ///
  /// In bs, this message translates to:
  /// **'Rezultati pretrage'**
  String get searchResults;

  /// No description provided for @noStaysMatchFilters.
  ///
  /// In bs, this message translates to:
  /// **'Nijedan smještaj ne odgovara vašim filterima.'**
  String get noStaysMatchFilters;

  /// No description provided for @noServicesMatchFilters.
  ///
  /// In bs, this message translates to:
  /// **'Nijedna usluga ne odgovara vašim filterima.'**
  String get noServicesMatchFilters;

  /// No description provided for @continueBooking.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi rezervaciju'**
  String get continueBooking;

  /// No description provided for @continueAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi zakazivanje'**
  String get continueAppointment;

  /// No description provided for @popularNearYou.
  ///
  /// In bs, this message translates to:
  /// **'Popularno u vašoj blizini'**
  String get popularNearYou;

  /// No description provided for @recommendedForYou.
  ///
  /// In bs, this message translates to:
  /// **'Preporučeno za vas'**
  String get recommendedForYou;

  /// No description provided for @exploreMoreServices.
  ///
  /// In bs, this message translates to:
  /// **'Istražite više usluga'**
  String get exploreMoreServices;

  /// No description provided for @today.
  ///
  /// In bs, this message translates to:
  /// **'Danas'**
  String get today;

  /// No description provided for @weekend.
  ///
  /// In bs, this message translates to:
  /// **'Vikend'**
  String get weekend;

  /// No description provided for @featured.
  ///
  /// In bs, this message translates to:
  /// **'Izdvojeno'**
  String get featured;

  /// No description provided for @perNight.
  ///
  /// In bs, this message translates to:
  /// **'/noć'**
  String get perNight;

  /// No description provided for @fromPrice.
  ///
  /// In bs, this message translates to:
  /// **'Od {price}'**
  String fromPrice(String price);

  /// No description provided for @appointmentDuration.
  ///
  /// In bs, this message translates to:
  /// **'Termin od {minutes} min'**
  String appointmentDuration(int minutes);

  /// No description provided for @guests.
  ///
  /// In bs, this message translates to:
  /// **'{count} gostiju'**
  String guests(int count);

  /// No description provided for @resume.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi'**
  String get resume;

  /// No description provided for @withProvider.
  ///
  /// In bs, this message translates to:
  /// **'Kod {name}'**
  String withProvider(String name);

  /// No description provided for @browseByCategory.
  ///
  /// In bs, this message translates to:
  /// **'Pregledaj po kategoriji'**
  String get browseByCategory;

  /// No description provided for @featuredCollections.
  ///
  /// In bs, this message translates to:
  /// **'Izdvojene kolekcije'**
  String get featuredCollections;

  /// No description provided for @trendingNearYou.
  ///
  /// In bs, this message translates to:
  /// **'Popularno u vašoj blizini'**
  String get trendingNearYou;

  /// No description provided for @recentlyViewed.
  ///
  /// In bs, this message translates to:
  /// **'Nedavno pregledano'**
  String get recentlyViewed;

  /// No description provided for @viewAllCategories.
  ///
  /// In bs, this message translates to:
  /// **'Prikaži sve kategorije'**
  String get viewAllCategories;

  /// No description provided for @showFewerCategories.
  ///
  /// In bs, this message translates to:
  /// **'Prikaži manje kategorija'**
  String get showFewerCategories;

  /// No description provided for @noServicesAvailableInCity.
  ///
  /// In bs, this message translates to:
  /// **'U ovom gradu još nema dostupnih usluga.'**
  String get noServicesAvailableInCity;

  /// No description provided for @autumnGetaways.
  ///
  /// In bs, this message translates to:
  /// **'Jesenski odmori'**
  String get autumnGetaways;

  /// No description provided for @saveUpToThirtyPercent.
  ///
  /// In bs, this message translates to:
  /// **'Uštedite do 30%'**
  String get saveUpToThirtyPercent;

  /// No description provided for @weekendEscapes.
  ///
  /// In bs, this message translates to:
  /// **'Vikend bijegovi'**
  String get weekendEscapes;

  /// No description provided for @nextBreakCloser.
  ///
  /// In bs, this message translates to:
  /// **'Vaš sljedeći odmor bliži je nego što mislite'**
  String get nextBreakCloser;

  /// No description provided for @beachfrontStays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji uz plažu'**
  String get beachfrontStays;

  /// No description provided for @wakeUpToOceanViews.
  ///
  /// In bs, this message translates to:
  /// **'Budite se uz pogled na more'**
  String get wakeUpToOceanViews;

  /// No description provided for @topRatedServices.
  ///
  /// In bs, this message translates to:
  /// **'Najbolje ocijenjene usluge'**
  String get topRatedServices;

  /// No description provided for @bookInstantlyBestPrices.
  ///
  /// In bs, this message translates to:
  /// **'Rezervišite odmah · Najbolje cijene'**
  String get bookInstantlyBestPrices;

  /// No description provided for @lastMinuteAvailability.
  ///
  /// In bs, this message translates to:
  /// **'Dostupnost u zadnji čas'**
  String get lastMinuteAvailability;

  /// No description provided for @findOpeningToday.
  ///
  /// In bs, this message translates to:
  /// **'Pronađite slobodan termin danas'**
  String get findOpeningToday;

  /// No description provided for @trustedLocalExperts.
  ///
  /// In bs, this message translates to:
  /// **'Pouzdani lokalni stručnjaci'**
  String get trustedLocalExperts;

  /// No description provided for @verifiedProvidersNearYou.
  ///
  /// In bs, this message translates to:
  /// **'Potvrđeni pružaoci usluga u blizini'**
  String get verifiedProvidersNearYou;

  /// No description provided for @romanticGetaways.
  ///
  /// In bs, this message translates to:
  /// **'Romantični odmori'**
  String get romanticGetaways;

  /// No description provided for @perfectForCouples.
  ///
  /// In bs, this message translates to:
  /// **'Savršeno za parove'**
  String get perfectForCouples;

  /// No description provided for @familyFriendly.
  ///
  /// In bs, this message translates to:
  /// **'Prilagođeno porodici'**
  String get familyFriendly;

  /// No description provided for @kidApprovedStays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji koje djeca vole'**
  String get kidApprovedStays;

  /// No description provided for @quickCityBreaks.
  ///
  /// In bs, this message translates to:
  /// **'Brzi gradski odmori'**
  String get quickCityBreaks;

  /// No description provided for @oceanViewsIncluded.
  ///
  /// In bs, this message translates to:
  /// **'Pogled na more uključen'**
  String get oceanViewsIncluded;

  /// No description provided for @petFriendlyStays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji za kućne ljubimce'**
  String get petFriendlyStays;

  /// No description provided for @bringYourBestFriend.
  ///
  /// In bs, this message translates to:
  /// **'Povedite svog najboljeg prijatelja'**
  String get bringYourBestFriend;

  /// No description provided for @poolStays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji s bazenom'**
  String get poolStays;

  /// No description provided for @makeASplash.
  ///
  /// In bs, this message translates to:
  /// **'Uživajte u osvježenju'**
  String get makeASplash;

  /// No description provided for @mountainEscapes.
  ///
  /// In bs, this message translates to:
  /// **'Planinski odmori'**
  String get mountainEscapes;

  /// No description provided for @freshAirAndViews.
  ///
  /// In bs, this message translates to:
  /// **'Svjež zrak i predivni pogledi'**
  String get freshAirAndViews;

  /// No description provided for @cityBreaks.
  ///
  /// In bs, this message translates to:
  /// **'Gradski odmori'**
  String get cityBreaks;

  /// No description provided for @stayCloseToAction.
  ///
  /// In bs, this message translates to:
  /// **'Budite blizu svih dešavanja'**
  String get stayCloseToAction;

  /// No description provided for @wellnessAndSpa.
  ///
  /// In bs, this message translates to:
  /// **'Wellness i spa'**
  String get wellnessAndSpa;

  /// No description provided for @relaxAndRejuvenate.
  ///
  /// In bs, this message translates to:
  /// **'Opustite se i obnovite energiju'**
  String get relaxAndRejuvenate;

  /// No description provided for @beautyAndGrooming.
  ///
  /// In bs, this message translates to:
  /// **'Ljepota i njega'**
  String get beautyAndGrooming;

  /// No description provided for @lookYourBest.
  ///
  /// In bs, this message translates to:
  /// **'Izgledajte najbolje'**
  String get lookYourBest;

  /// No description provided for @homeRepairs.
  ///
  /// In bs, this message translates to:
  /// **'Kućne popravke'**
  String get homeRepairs;

  /// No description provided for @fixItRight.
  ///
  /// In bs, this message translates to:
  /// **'Popravite kako treba'**
  String get fixItRight;

  /// No description provided for @autoServices.
  ///
  /// In bs, this message translates to:
  /// **'Auto usluge'**
  String get autoServices;

  /// No description provided for @keepMoving.
  ///
  /// In bs, this message translates to:
  /// **'Nastavite dalje'**
  String get keepMoving;

  /// No description provided for @healthAndCare.
  ///
  /// In bs, this message translates to:
  /// **'Zdravlje i njega'**
  String get healthAndCare;

  /// No description provided for @feelYourBest.
  ///
  /// In bs, this message translates to:
  /// **'Osjećajte se najbolje'**
  String get feelYourBest;

  /// No description provided for @learnAndGrow.
  ///
  /// In bs, this message translates to:
  /// **'Učite i rastite'**
  String get learnAndGrow;

  /// No description provided for @buildNewSkills.
  ///
  /// In bs, this message translates to:
  /// **'Steknite nove vještine'**
  String get buildNewSkills;

  /// No description provided for @petCare.
  ///
  /// In bs, this message translates to:
  /// **'Njega ljubimaca'**
  String get petCare;

  /// No description provided for @careForEveryCompanion.
  ///
  /// In bs, this message translates to:
  /// **'Njega za svakog ljubimca'**
  String get careForEveryCompanion;

  /// No description provided for @professionalServices.
  ///
  /// In bs, this message translates to:
  /// **'Profesionalne usluge'**
  String get professionalServices;

  /// No description provided for @expertSupportWhenNeeded.
  ///
  /// In bs, this message translates to:
  /// **'Stručna podrška kada vam treba'**
  String get expertSupportWhenNeeded;

  /// No description provided for @upcoming.
  ///
  /// In bs, this message translates to:
  /// **'Predstojeće'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In bs, this message translates to:
  /// **'Prošle'**
  String get past;

  /// No description provided for @noBookingsYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate rezervacija.'**
  String get noBookingsYet;

  /// No description provided for @noServiceBookingsYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate zakazanih usluga.'**
  String get noServiceBookingsYet;

  /// No description provided for @bookAgain.
  ///
  /// In bs, this message translates to:
  /// **'Rezerviši ponovo'**
  String get bookAgain;

  /// No description provided for @viewDetails.
  ///
  /// In bs, this message translates to:
  /// **'Pogledaj detalje'**
  String get viewDetails;

  /// No description provided for @confirmed.
  ///
  /// In bs, this message translates to:
  /// **'Potvrđeno'**
  String get confirmed;

  /// No description provided for @declined.
  ///
  /// In bs, this message translates to:
  /// **'Odbijeno'**
  String get declined;

  /// No description provided for @cancelled.
  ///
  /// In bs, this message translates to:
  /// **'Otkazano'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In bs, this message translates to:
  /// **'Završeno'**
  String get completed;

  /// No description provided for @adults.
  ///
  /// In bs, this message translates to:
  /// **'{count, plural, one{# odrasla osoba} other{# odraslih osoba}}'**
  String adults(int count);

  /// No description provided for @children.
  ///
  /// In bs, this message translates to:
  /// **'{count, plural, one{# dijete} other{# djece}}'**
  String children(int count);

  /// No description provided for @serviceDuration.
  ///
  /// In bs, this message translates to:
  /// **'{minutes} min'**
  String serviceDuration(int minutes);

  /// No description provided for @bookingDetails.
  ///
  /// In bs, this message translates to:
  /// **'Detalji rezervacije'**
  String get bookingDetails;

  /// No description provided for @saveBookingDraft.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvati nacrt rezervacije?'**
  String get saveBookingDraft;

  /// No description provided for @continueBookingLater.
  ///
  /// In bs, this message translates to:
  /// **'Ovu rezervaciju možete nastaviti kasnije sa početne stranice.'**
  String get continueBookingLater;

  /// No description provided for @discard.
  ///
  /// In bs, this message translates to:
  /// **'Odbaci'**
  String get discard;

  /// No description provided for @saveDraft.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvaj nacrt'**
  String get saveDraft;

  /// No description provided for @selectDates.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite datume'**
  String get selectDates;

  /// No description provided for @checkIn.
  ///
  /// In bs, this message translates to:
  /// **'Prijava'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In bs, this message translates to:
  /// **'Odjava'**
  String get checkOut;

  /// No description provided for @guestSelection.
  ///
  /// In bs, this message translates to:
  /// **'Gosti'**
  String get guestSelection;

  /// No description provided for @adult.
  ///
  /// In bs, this message translates to:
  /// **'Odrasli'**
  String get adult;

  /// No description provided for @ages13Plus.
  ///
  /// In bs, this message translates to:
  /// **'13+ godina'**
  String get ages13Plus;

  /// No description provided for @child.
  ///
  /// In bs, this message translates to:
  /// **'Djeca'**
  String get child;

  /// No description provided for @ages2To12.
  ///
  /// In bs, this message translates to:
  /// **'2–12 godina'**
  String get ages2To12;

  /// No description provided for @infant.
  ///
  /// In bs, this message translates to:
  /// **'Bebe'**
  String get infant;

  /// No description provided for @under2.
  ///
  /// In bs, this message translates to:
  /// **'Ispod 2 godine'**
  String get under2;

  /// No description provided for @bookingSummary.
  ///
  /// In bs, this message translates to:
  /// **'Sažetak rezervacije'**
  String get bookingSummary;

  /// No description provided for @dates.
  ///
  /// In bs, this message translates to:
  /// **'Datumi'**
  String get dates;

  /// No description provided for @nights.
  ///
  /// In bs, this message translates to:
  /// **'{count, plural, one{# noć} other{# noći}}'**
  String nights(int count);

  /// No description provided for @serviceFee.
  ///
  /// In bs, this message translates to:
  /// **'Naknada za uslugu'**
  String get serviceFee;

  /// No description provided for @taxes.
  ///
  /// In bs, this message translates to:
  /// **'Porezi'**
  String get taxes;

  /// No description provided for @total.
  ///
  /// In bs, this message translates to:
  /// **'Ukupno'**
  String get total;

  /// No description provided for @appointmentDetails.
  ///
  /// In bs, this message translates to:
  /// **'Detalji termina'**
  String get appointmentDetails;

  /// No description provided for @cancelAppointmentQuestion.
  ///
  /// In bs, this message translates to:
  /// **'Otkazati termin?'**
  String get cancelAppointmentQuestion;

  /// No description provided for @cannotBeUndone.
  ///
  /// In bs, this message translates to:
  /// **'Ova radnja se ne može poništiti.'**
  String get cannotBeUndone;

  /// No description provided for @keepAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Zadrži termin'**
  String get keepAppointment;

  /// No description provided for @cancelAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Otkaži termin'**
  String get cancelAppointment;

  /// No description provided for @rescheduleAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Promijeni termin'**
  String get rescheduleAppointment;

  /// No description provided for @messageProvider.
  ///
  /// In bs, this message translates to:
  /// **'Pošalji poruku pružaocu usluge'**
  String get messageProvider;

  /// No description provided for @appointmentInformation.
  ///
  /// In bs, this message translates to:
  /// **'Informacije o terminu'**
  String get appointmentInformation;

  /// No description provided for @service.
  ///
  /// In bs, this message translates to:
  /// **'Usluga'**
  String get service;

  /// No description provided for @provider.
  ///
  /// In bs, this message translates to:
  /// **'Pružalac usluge'**
  String get provider;

  /// No description provided for @dateAndTime.
  ///
  /// In bs, this message translates to:
  /// **'Datum i vrijeme'**
  String get dateAndTime;

  /// No description provided for @status.
  ///
  /// In bs, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @reference.
  ///
  /// In bs, this message translates to:
  /// **'Referenca'**
  String get reference;

  /// No description provided for @filters.
  ///
  /// In bs, this message translates to:
  /// **'Filteri'**
  String get filters;

  /// No description provided for @reset.
  ///
  /// In bs, this message translates to:
  /// **'Resetuj'**
  String get reset;

  /// No description provided for @clearAll.
  ///
  /// In bs, this message translates to:
  /// **'Očisti sve'**
  String get clearAll;

  /// No description provided for @showResults.
  ///
  /// In bs, this message translates to:
  /// **'Prikaži rezultate'**
  String get showResults;

  /// No description provided for @filtersApplied.
  ///
  /// In bs, this message translates to:
  /// **'Primijenjeno filtera: {count}'**
  String filtersApplied(int count);

  /// No description provided for @city.
  ///
  /// In bs, this message translates to:
  /// **'Grad'**
  String get city;

  /// No description provided for @propertyType.
  ///
  /// In bs, this message translates to:
  /// **'Tip objekta'**
  String get propertyType;

  /// No description provided for @stayType.
  ///
  /// In bs, this message translates to:
  /// **'Tip smještaja'**
  String get stayType;

  /// No description provided for @priceRange.
  ///
  /// In bs, this message translates to:
  /// **'Raspon cijena'**
  String get priceRange;

  /// No description provided for @rating.
  ///
  /// In bs, this message translates to:
  /// **'Ocjena'**
  String get rating;

  /// No description provided for @amenities.
  ///
  /// In bs, this message translates to:
  /// **'Pogodnosti'**
  String get amenities;

  /// No description provided for @date.
  ///
  /// In bs, this message translates to:
  /// **'Datum'**
  String get date;

  /// No description provided for @time.
  ///
  /// In bs, this message translates to:
  /// **'Vrijeme'**
  String get time;

  /// No description provided for @anyDate.
  ///
  /// In bs, this message translates to:
  /// **'Bilo koji datum'**
  String get anyDate;

  /// No description provided for @anyTime.
  ///
  /// In bs, this message translates to:
  /// **'Bilo koje vrijeme'**
  String get anyTime;

  /// No description provided for @businessCategory.
  ///
  /// In bs, this message translates to:
  /// **'Kategorija businessa'**
  String get businessCategory;

  /// No description provided for @category.
  ///
  /// In bs, this message translates to:
  /// **'Kategorija'**
  String get category;

  /// No description provided for @allCategories.
  ///
  /// In bs, this message translates to:
  /// **'Sve kategorije'**
  String get allCategories;

  /// No description provided for @sortBy.
  ///
  /// In bs, this message translates to:
  /// **'Sortiraj po'**
  String get sortBy;

  /// No description provided for @checkInDate.
  ///
  /// In bs, this message translates to:
  /// **'Datum prijave'**
  String get checkInDate;

  /// No description provided for @checkOutDate.
  ///
  /// In bs, this message translates to:
  /// **'Datum odjave'**
  String get checkOutDate;

  /// No description provided for @stayUnavailable.
  ///
  /// In bs, this message translates to:
  /// **'Ovaj smještaj nije dostupan.'**
  String get stayUnavailable;

  /// No description provided for @removedFromSaved.
  ///
  /// In bs, this message translates to:
  /// **'Uklonjeno iz sačuvanih'**
  String get removedFromSaved;

  /// No description provided for @addedToSaved.
  ///
  /// In bs, this message translates to:
  /// **'Dodano u sačuvane'**
  String get addedToSaved;

  /// No description provided for @availableRooms.
  ///
  /// In bs, this message translates to:
  /// **'Dostupne sobe'**
  String get availableRooms;

  /// No description provided for @aboutThisStay.
  ///
  /// In bs, this message translates to:
  /// **'O ovom smještaju'**
  String get aboutThisStay;

  /// No description provided for @checkAvailability.
  ///
  /// In bs, this message translates to:
  /// **'Provjeri dostupnost'**
  String get checkAvailability;

  /// No description provided for @guestReviews.
  ///
  /// In bs, this message translates to:
  /// **'Recenzije gostiju'**
  String get guestReviews;

  /// No description provided for @seeAllReviews.
  ///
  /// In bs, this message translates to:
  /// **'Pogledaj sve recenzije'**
  String get seeAllReviews;

  /// No description provided for @location.
  ///
  /// In bs, this message translates to:
  /// **'Lokacija'**
  String get location;

  /// No description provided for @locationOnRequest.
  ///
  /// In bs, this message translates to:
  /// **'Lokacija dostupna na upit'**
  String get locationOnRequest;

  /// No description provided for @openInMaps.
  ///
  /// In bs, this message translates to:
  /// **'Otvori u Mapama'**
  String get openInMaps;

  /// No description provided for @unableToOpenMaps.
  ///
  /// In bs, this message translates to:
  /// **'Nije moguće otvoriti Google Maps.'**
  String get unableToOpenMaps;

  /// No description provided for @cityCentre.
  ///
  /// In bs, this message translates to:
  /// **'Centar grada'**
  String get cityCentre;

  /// No description provided for @reviews.
  ///
  /// In bs, this message translates to:
  /// **'{count} recenzija'**
  String reviews(int count);

  /// No description provided for @roomGuestsAndSize.
  ///
  /// In bs, this message translates to:
  /// **'{guests} gostiju · {size} m²'**
  String roomGuestsAndSize(int guests, int size);

  /// No description provided for @book.
  ///
  /// In bs, this message translates to:
  /// **'Rezerviši'**
  String get book;

  /// No description provided for @serviceUnavailable.
  ///
  /// In bs, this message translates to:
  /// **'Ova usluga nije dostupna.'**
  String get serviceUnavailable;

  /// No description provided for @about.
  ///
  /// In bs, this message translates to:
  /// **'O usluzi'**
  String get about;

  /// No description provided for @gallery.
  ///
  /// In bs, this message translates to:
  /// **'Galerija'**
  String get gallery;

  /// No description provided for @servicesOffered.
  ///
  /// In bs, this message translates to:
  /// **'Ponuđene usluge'**
  String get servicesOffered;

  /// No description provided for @customerReviews.
  ///
  /// In bs, this message translates to:
  /// **'Recenzije korisnika'**
  String get customerReviews;

  /// No description provided for @perSession.
  ///
  /// In bs, this message translates to:
  /// **'po terminu'**
  String get perSession;

  /// No description provided for @away.
  ///
  /// In bs, this message translates to:
  /// **'udaljeno'**
  String get away;

  /// No description provided for @inCity.
  ///
  /// In bs, this message translates to:
  /// **'{title} u gradu {city}'**
  String inCity(String title, String city);

  /// No description provided for @noCategoryAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Nema dostupnih objekata kategorije {category}.'**
  String noCategoryAvailable(String category);

  /// No description provided for @noCategoryAvailableInCity.
  ///
  /// In bs, this message translates to:
  /// **'Nema dostupnih objekata kategorije {category} u gradu {city}.'**
  String noCategoryAvailableInCity(String category, String city);

  /// No description provided for @payment.
  ///
  /// In bs, this message translates to:
  /// **'Plaćanje'**
  String get payment;

  /// No description provided for @creditDebitCard.
  ///
  /// In bs, this message translates to:
  /// **'Kreditna/debitna kartica'**
  String get creditDebitCard;

  /// No description provided for @cardNumber.
  ///
  /// In bs, this message translates to:
  /// **'Broj kartice'**
  String get cardNumber;

  /// No description provided for @cardNumberExample.
  ///
  /// In bs, this message translates to:
  /// **'1234 5678 9012 3456'**
  String get cardNumberExample;

  /// No description provided for @expiry.
  ///
  /// In bs, this message translates to:
  /// **'Datum isteka'**
  String get expiry;

  /// No description provided for @expiryExample.
  ///
  /// In bs, this message translates to:
  /// **'MM/GG'**
  String get expiryExample;

  /// No description provided for @cvv.
  ///
  /// In bs, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @cvvExample.
  ///
  /// In bs, this message translates to:
  /// **'123'**
  String get cvvExample;

  /// No description provided for @nameOnCard.
  ///
  /// In bs, this message translates to:
  /// **'Ime na kartici'**
  String get nameOnCard;

  /// No description provided for @cardholderNameExample.
  ///
  /// In bs, this message translates to:
  /// **'John Doe'**
  String get cardholderNameExample;

  /// No description provided for @fullName.
  ///
  /// In bs, this message translates to:
  /// **'Puno ime'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In bs, this message translates to:
  /// **'Unesite puno ime'**
  String get enterFullName;

  /// No description provided for @email.
  ///
  /// In bs, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @emailExample.
  ///
  /// In bs, this message translates to:
  /// **'vas.email@primjer.com'**
  String get emailExample;

  /// No description provided for @phoneNumber.
  ///
  /// In bs, this message translates to:
  /// **'Broj telefona'**
  String get phoneNumber;

  /// No description provided for @phoneNumberExample.
  ///
  /// In bs, this message translates to:
  /// **'+1 (555) 123-4567'**
  String get phoneNumberExample;

  /// No description provided for @billingAddress.
  ///
  /// In bs, this message translates to:
  /// **'Adresa za naplatu'**
  String get billingAddress;

  /// No description provided for @enterBillingAddress.
  ///
  /// In bs, this message translates to:
  /// **'Unesite adresu za naplatu'**
  String get enterBillingAddress;

  /// No description provided for @firstName.
  ///
  /// In bs, this message translates to:
  /// **'Ime'**
  String get firstName;

  /// No description provided for @lastNameRequired.
  ///
  /// In bs, this message translates to:
  /// **'Prezime*'**
  String get lastNameRequired;

  /// No description provided for @emailAddress.
  ///
  /// In bs, this message translates to:
  /// **'E-mail adresa'**
  String get emailAddress;

  /// No description provided for @chooseFromLibrary.
  ///
  /// In bs, this message translates to:
  /// **'Odaberi iz biblioteke'**
  String get chooseFromLibrary;

  /// No description provided for @takePhoto.
  ///
  /// In bs, this message translates to:
  /// **'Snimi fotografiju'**
  String get takePhoto;

  /// No description provided for @enterAddress.
  ///
  /// In bs, this message translates to:
  /// **'Unesite adresu'**
  String get enterAddress;

  /// No description provided for @searchCountry.
  ///
  /// In bs, this message translates to:
  /// **'Pretraži državu'**
  String get searchCountry;

  /// No description provided for @dateOfBirth.
  ///
  /// In bs, this message translates to:
  /// **'Datum rođenja'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthExample.
  ///
  /// In bs, this message translates to:
  /// **'DD. MM. GGGG.'**
  String get dateOfBirthExample;

  /// No description provided for @cityOptional.
  ///
  /// In bs, this message translates to:
  /// **'Grad (opcionalno)'**
  String get cityOptional;

  /// No description provided for @enterCity.
  ///
  /// In bs, this message translates to:
  /// **'Unesite grad'**
  String get enterCity;

  /// No description provided for @addressOptional.
  ///
  /// In bs, this message translates to:
  /// **'Adresa (opcionalno)'**
  String get addressOptional;

  /// No description provided for @saveAppointmentDraft.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvati nacrt termina?'**
  String get saveAppointmentDraft;

  /// No description provided for @saveSelectedExtras.
  ///
  /// In bs, this message translates to:
  /// **'Odabrani dodaci također će biti sačuvani.'**
  String get saveSelectedExtras;

  /// No description provided for @addExtras.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj dodatke'**
  String get addExtras;

  /// No description provided for @totalPaid.
  ///
  /// In bs, this message translates to:
  /// **'Ukupno plaćeno'**
  String get totalPaid;

  /// No description provided for @entirePlace.
  ///
  /// In bs, this message translates to:
  /// **'Cijeli objekat'**
  String get entirePlace;

  /// No description provided for @roomOrUnit.
  ///
  /// In bs, this message translates to:
  /// **'Soba ili jedinica'**
  String get roomOrUnit;

  /// No description provided for @day.
  ///
  /// In bs, this message translates to:
  /// **'Dan'**
  String get day;

  /// No description provided for @businessName.
  ///
  /// In bs, this message translates to:
  /// **'Naziv businessa'**
  String get businessName;

  /// No description provided for @enterBusinessName.
  ///
  /// In bs, this message translates to:
  /// **'Unesite naziv businessa'**
  String get enterBusinessName;

  /// No description provided for @enterPricePerNight.
  ///
  /// In bs, this message translates to:
  /// **'Unesite cijenu po noći'**
  String get enterPricePerNight;

  /// No description provided for @enterBusinessAddress.
  ///
  /// In bs, this message translates to:
  /// **'Unesite adresu businessa'**
  String get enterBusinessAddress;

  /// No description provided for @roomNameExample.
  ///
  /// In bs, this message translates to:
  /// **'npr. Deluxe soba'**
  String get roomNameExample;

  /// No description provided for @unitNameExample.
  ///
  /// In bs, this message translates to:
  /// **'npr. Deluxe soba ili vrtna kućica'**
  String get unitNameExample;

  /// No description provided for @maxGuests.
  ///
  /// In bs, this message translates to:
  /// **'Maks. gostiju'**
  String get maxGuests;

  /// No description provided for @sizeSquareMeters.
  ///
  /// In bs, this message translates to:
  /// **'Veličina m²'**
  String get sizeSquareMeters;

  /// No description provided for @pricePerNight.
  ///
  /// In bs, this message translates to:
  /// **'Cijena po noći'**
  String get pricePerNight;

  /// No description provided for @roomsAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Dostupno soba'**
  String get roomsAvailable;

  /// No description provided for @unitsAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Dostupno jedinica'**
  String get unitsAvailable;

  /// No description provided for @providerNameExample.
  ///
  /// In bs, this message translates to:
  /// **'Ime pružaoca usluge, npr. Sarah Johnson'**
  String get providerNameExample;

  /// No description provided for @serviceNameExample.
  ///
  /// In bs, this message translates to:
  /// **'npr. Šišanje, izbjeljivanje zuba, električni pregled'**
  String get serviceNameExample;

  /// No description provided for @durationExample.
  ///
  /// In bs, this message translates to:
  /// **'60'**
  String get durationExample;

  /// No description provided for @priceExample.
  ///
  /// In bs, this message translates to:
  /// **'50'**
  String get priceExample;

  /// No description provided for @describeService.
  ///
  /// In bs, this message translates to:
  /// **'Ukratko opišite ovu uslugu'**
  String get describeService;

  /// No description provided for @providerNameHint.
  ///
  /// In bs, this message translates to:
  /// **'Ime osobe koja pruža usluge'**
  String get providerNameHint;

  /// No description provided for @couldNotDeclineBooking.
  ///
  /// In bs, this message translates to:
  /// **'Nije bilo moguće odbiti ovu rezervaciju.'**
  String get couldNotDeclineBooking;
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
      <String>['bs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bs':
      return AppLocalizationsBs();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
