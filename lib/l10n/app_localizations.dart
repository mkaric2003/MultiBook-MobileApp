import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
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

  /// No description provided for @currency.
  ///
  /// In bs, this message translates to:
  /// **'Valuta'**
  String get currency;

  /// No description provided for @addBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj business'**
  String get addBusiness;

  /// No description provided for @addYourFirstBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Dodajte svoj prvi business'**
  String get addYourFirstBusiness;

  /// No description provided for @optionalExtras.
  ///
  /// In bs, this message translates to:
  /// **'Dodatne opcije'**
  String get optionalExtras;

  /// No description provided for @addressRequired.
  ///
  /// In bs, this message translates to:
  /// **'Adresa*'**
  String get addressRequired;

  /// No description provided for @shortDescription.
  ///
  /// In bs, this message translates to:
  /// **'Kratak opis'**
  String get shortDescription;

  /// No description provided for @describeYourBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Opišite svoj business...'**
  String get describeYourBusiness;

  /// No description provided for @describeYourBusinessServices.
  ///
  /// In bs, this message translates to:
  /// **'Opišite usluge svog businessa...'**
  String get describeYourBusinessServices;

  /// No description provided for @businessImages.
  ///
  /// In bs, this message translates to:
  /// **'Slike businessa'**
  String get businessImages;

  /// No description provided for @businessPhotos.
  ///
  /// In bs, this message translates to:
  /// **'Fotografije businessa'**
  String get businessPhotos;

  /// No description provided for @tapMapToPlacePin.
  ///
  /// In bs, this message translates to:
  /// **'Dodirnite mapu da postavite oznaku'**
  String get tapMapToPlacePin;

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

  /// No description provided for @german.
  ///
  /// In bs, this message translates to:
  /// **'Njemački'**
  String get german;

  /// No description provided for @spanish.
  ///
  /// In bs, this message translates to:
  /// **'Španski'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In bs, this message translates to:
  /// **'Francuski'**
  String get french;

  /// No description provided for @italian.
  ///
  /// In bs, this message translates to:
  /// **'Italijanski'**
  String get italian;

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
  /// **'Istaknute kolekcije'**
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

  /// No description provided for @serviceCost.
  ///
  /// In bs, this message translates to:
  /// **'Cijena usluge'**
  String get serviceCost;

  /// No description provided for @discountApplied.
  ///
  /// In bs, this message translates to:
  /// **'Popust je primijenjen'**
  String get discountApplied;

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

  /// No description provided for @amenityWifi.
  ///
  /// In bs, this message translates to:
  /// **'Wi-Fi'**
  String get amenityWifi;

  /// No description provided for @amenityParking.
  ///
  /// In bs, this message translates to:
  /// **'Parking'**
  String get amenityParking;

  /// No description provided for @amenityPool.
  ///
  /// In bs, this message translates to:
  /// **'Bazen'**
  String get amenityPool;

  /// No description provided for @amenitySpa.
  ///
  /// In bs, this message translates to:
  /// **'Spa'**
  String get amenitySpa;

  /// No description provided for @amenityPetFriendly.
  ///
  /// In bs, this message translates to:
  /// **'Dozvoljeni ljubimci'**
  String get amenityPetFriendly;

  /// No description provided for @amenityGym.
  ///
  /// In bs, this message translates to:
  /// **'Teretana'**
  String get amenityGym;

  /// No description provided for @amenityAirConditioning.
  ///
  /// In bs, this message translates to:
  /// **'Klima uređaj'**
  String get amenityAirConditioning;

  /// No description provided for @amenityHeating.
  ///
  /// In bs, this message translates to:
  /// **'Grijanje'**
  String get amenityHeating;

  /// No description provided for @amenityKitchen.
  ///
  /// In bs, this message translates to:
  /// **'Kuhinja'**
  String get amenityKitchen;

  /// No description provided for @amenityWasher.
  ///
  /// In bs, this message translates to:
  /// **'Veš mašina'**
  String get amenityWasher;

  /// No description provided for @amenityBalcony.
  ///
  /// In bs, this message translates to:
  /// **'Balkon'**
  String get amenityBalcony;

  /// No description provided for @amenitySeaView.
  ///
  /// In bs, this message translates to:
  /// **'Pogled na more'**
  String get amenitySeaView;

  /// No description provided for @amenityMountainView.
  ///
  /// In bs, this message translates to:
  /// **'Pogled na planine'**
  String get amenityMountainView;

  /// No description provided for @amenityWorkspace.
  ///
  /// In bs, this message translates to:
  /// **'Radni prostor'**
  String get amenityWorkspace;

  /// No description provided for @amenityElevator.
  ///
  /// In bs, this message translates to:
  /// **'Lift'**
  String get amenityElevator;

  /// No description provided for @amenitySkiInSkiOut.
  ///
  /// In bs, this message translates to:
  /// **'Skijanje do i od objekta'**
  String get amenitySkiInSkiOut;

  /// No description provided for @amenitySkiStorage.
  ///
  /// In bs, this message translates to:
  /// **'Spremište za skije'**
  String get amenitySkiStorage;

  /// No description provided for @amenitySkiRental.
  ///
  /// In bs, this message translates to:
  /// **'Iznajmljivanje skija'**
  String get amenitySkiRental;

  /// No description provided for @amenitySkiShuttle.
  ///
  /// In bs, this message translates to:
  /// **'Prijevoz do skijališta'**
  String get amenitySkiShuttle;

  /// No description provided for @selectCategory.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite kategoriju'**
  String get selectCategory;

  /// No description provided for @singleUnit.
  ///
  /// In bs, this message translates to:
  /// **'Jedna jedinica'**
  String get singleUnit;

  /// No description provided for @oneBookableStay.
  ///
  /// In bs, this message translates to:
  /// **'Jedan smještaj za rezervaciju'**
  String get oneBookableStay;

  /// No description provided for @multipleUnits.
  ///
  /// In bs, this message translates to:
  /// **'Više jedinica'**
  String get multipleUnits;

  /// No description provided for @roomsOrUnits.
  ///
  /// In bs, this message translates to:
  /// **'Sobe ili jedinice'**
  String get roomsOrUnits;

  /// No description provided for @categoryHotel.
  ///
  /// In bs, this message translates to:
  /// **'Hotel'**
  String get categoryHotel;

  /// No description provided for @categoryApartment.
  ///
  /// In bs, this message translates to:
  /// **'Apartman'**
  String get categoryApartment;

  /// No description provided for @categoryVilla.
  ///
  /// In bs, this message translates to:
  /// **'Vila'**
  String get categoryVilla;

  /// No description provided for @categoryBeachVilla.
  ///
  /// In bs, this message translates to:
  /// **'Vila na plaži'**
  String get categoryBeachVilla;

  /// No description provided for @categoryPoolVilla.
  ///
  /// In bs, this message translates to:
  /// **'Vila s bazenom'**
  String get categoryPoolVilla;

  /// No description provided for @categoryCabin.
  ///
  /// In bs, this message translates to:
  /// **'Koliba'**
  String get categoryCabin;

  /// No description provided for @categoryMountainCabin.
  ///
  /// In bs, this message translates to:
  /// **'Planinska koliba'**
  String get categoryMountainCabin;

  /// No description provided for @categoryCottage.
  ///
  /// In bs, this message translates to:
  /// **'Vikendica'**
  String get categoryCottage;

  /// No description provided for @categoryResort.
  ///
  /// In bs, this message translates to:
  /// **'Resort'**
  String get categoryResort;

  /// No description provided for @categoryGuesthouse.
  ///
  /// In bs, this message translates to:
  /// **'Pansion'**
  String get categoryGuesthouse;

  /// No description provided for @categoryHostel.
  ///
  /// In bs, this message translates to:
  /// **'Hostel'**
  String get categoryHostel;

  /// No description provided for @categoryAparthotel.
  ///
  /// In bs, this message translates to:
  /// **'Aparthotel'**
  String get categoryAparthotel;

  /// No description provided for @categoryGlamping.
  ///
  /// In bs, this message translates to:
  /// **'Glamping'**
  String get categoryGlamping;

  /// No description provided for @categoryVacationHome.
  ///
  /// In bs, this message translates to:
  /// **'Kuća za odmor'**
  String get categoryVacationHome;

  /// No description provided for @categoryHairSalon.
  ///
  /// In bs, this message translates to:
  /// **'Frizerski salon'**
  String get categoryHairSalon;

  /// No description provided for @categoryBarbershop.
  ///
  /// In bs, this message translates to:
  /// **'Berbernica'**
  String get categoryBarbershop;

  /// No description provided for @categoryBeautySalon.
  ///
  /// In bs, this message translates to:
  /// **'Kozmetički salon'**
  String get categoryBeautySalon;

  /// No description provided for @categoryNailSalon.
  ///
  /// In bs, this message translates to:
  /// **'Salon za nokte i pedikuru'**
  String get categoryNailSalon;

  /// No description provided for @categoryDentalClinic.
  ///
  /// In bs, this message translates to:
  /// **'Stomatološka ordinacija'**
  String get categoryDentalClinic;

  /// No description provided for @categoryMedicalClinic.
  ///
  /// In bs, this message translates to:
  /// **'Medicinska klinika'**
  String get categoryMedicalClinic;

  /// No description provided for @categoryPhysiotherapy.
  ///
  /// In bs, this message translates to:
  /// **'Fizioterapija'**
  String get categoryPhysiotherapy;

  /// No description provided for @categoryMassageSpa.
  ///
  /// In bs, this message translates to:
  /// **'Masaža i spa'**
  String get categoryMassageSpa;

  /// No description provided for @categoryMassageTherapy.
  ///
  /// In bs, this message translates to:
  /// **'Terapijska masaža'**
  String get categoryMassageTherapy;

  /// No description provided for @categorySpaWellness.
  ///
  /// In bs, this message translates to:
  /// **'Spa i wellness'**
  String get categorySpaWellness;

  /// No description provided for @categoryPersonalTraining.
  ///
  /// In bs, this message translates to:
  /// **'Personalni trening'**
  String get categoryPersonalTraining;

  /// No description provided for @categoryTutoring.
  ///
  /// In bs, this message translates to:
  /// **'Instrukcije i podučavanje'**
  String get categoryTutoring;

  /// No description provided for @categoryElectrician.
  ///
  /// In bs, this message translates to:
  /// **'Električar'**
  String get categoryElectrician;

  /// No description provided for @categoryPlumber.
  ///
  /// In bs, this message translates to:
  /// **'Vodoinstalater'**
  String get categoryPlumber;

  /// No description provided for @categoryCleaningService.
  ///
  /// In bs, this message translates to:
  /// **'Usluga čišćenja'**
  String get categoryCleaningService;

  /// No description provided for @categoryAutomotiveService.
  ///
  /// In bs, this message translates to:
  /// **'Auto servis'**
  String get categoryAutomotiveService;

  /// No description provided for @categoryCarWashDetailing.
  ///
  /// In bs, this message translates to:
  /// **'Praonica i detailing auta'**
  String get categoryCarWashDetailing;

  /// No description provided for @categoryTattooPiercing.
  ///
  /// In bs, this message translates to:
  /// **'Studio za tetovaže i piercing'**
  String get categoryTattooPiercing;

  /// No description provided for @categoryVeterinaryPetCare.
  ///
  /// In bs, this message translates to:
  /// **'Veterinarska i njega ljubimaca'**
  String get categoryVeterinaryPetCare;

  /// No description provided for @categoryPhotographyVideography.
  ///
  /// In bs, this message translates to:
  /// **'Fotografija i videografija'**
  String get categoryPhotographyVideography;

  /// No description provided for @categoryLocksmith.
  ///
  /// In bs, this message translates to:
  /// **'Bravar'**
  String get categoryLocksmith;

  /// No description provided for @categoryHvacService.
  ///
  /// In bs, this message translates to:
  /// **'Grijanje i klimatizacija'**
  String get categoryHvacService;

  /// No description provided for @categoryPainterDecorator.
  ///
  /// In bs, this message translates to:
  /// **'Slikar i dekorater'**
  String get categoryPainterDecorator;

  /// No description provided for @categoryLegalConsultation.
  ///
  /// In bs, this message translates to:
  /// **'Pravno savjetovanje'**
  String get categoryLegalConsultation;

  /// No description provided for @categoryAccountingConsultation.
  ///
  /// In bs, this message translates to:
  /// **'Računovodstveno savjetovanje'**
  String get categoryAccountingConsultation;

  /// No description provided for @categoryProfessionalService.
  ///
  /// In bs, this message translates to:
  /// **'Profesionalne usluge'**
  String get categoryProfessionalService;

  /// No description provided for @noSavedStaysYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate sačuvanih smještaja.'**
  String get noSavedStaysYet;

  /// No description provided for @createAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Kreiraj termin'**
  String get createAppointment;

  /// No description provided for @continueAppointmentLater.
  ///
  /// In bs, this message translates to:
  /// **'Ovaj termin možete nastaviti kasnije sa početne stranice.'**
  String get continueAppointmentLater;

  /// No description provided for @selectService.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite uslugu'**
  String get selectService;

  /// No description provided for @selectProvider.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite pružaoca usluge'**
  String get selectProvider;

  /// No description provided for @noServiceProvidersAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Još nema dostupnih pružalaca usluga.'**
  String get noServiceProvidersAvailable;

  /// No description provided for @selectDate.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite datum'**
  String get selectDate;

  /// No description provided for @availableTimes.
  ///
  /// In bs, this message translates to:
  /// **'Dostupni termini'**
  String get availableTimes;

  /// No description provided for @noAppointmentSlotsAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Nema dostupnih termina za odabrani datum.'**
  String get noAppointmentSlotsAvailable;

  /// No description provided for @addBusinessIntro.
  ///
  /// In bs, this message translates to:
  /// **'Počnite podešavanjem smještaja ili usluga.'**
  String get addBusinessIntro;

  /// No description provided for @businessType.
  ///
  /// In bs, this message translates to:
  /// **'Tip businessa'**
  String get businessType;

  /// No description provided for @stayBusinessExamples.
  ///
  /// In bs, this message translates to:
  /// **'Hoteli, apartmani, kolibe'**
  String get stayBusinessExamples;

  /// No description provided for @serviceBusinessExamples.
  ///
  /// In bs, this message translates to:
  /// **'Saloni, klinike, profesionalci'**
  String get serviceBusinessExamples;

  /// No description provided for @businessNameRequired.
  ///
  /// In bs, this message translates to:
  /// **'Naziv businessa*'**
  String get businessNameRequired;

  /// No description provided for @businessCategoryRequired.
  ///
  /// In bs, this message translates to:
  /// **'Kategorija businessa*'**
  String get businessCategoryRequired;

  /// No description provided for @stayInventoryRequired.
  ///
  /// In bs, this message translates to:
  /// **'Inventar smještaja*'**
  String get stayInventoryRequired;

  /// No description provided for @pricePerNightRequired.
  ///
  /// In bs, this message translates to:
  /// **'Cijena po noći*'**
  String get pricePerNightRequired;

  /// No description provided for @bookableUnits.
  ///
  /// In bs, this message translates to:
  /// **'Jedinice za rezervaciju'**
  String get bookableUnits;

  /// No description provided for @cityRequired.
  ///
  /// In bs, this message translates to:
  /// **'Grad*'**
  String get cityRequired;

  /// No description provided for @chargedPerHour.
  ///
  /// In bs, this message translates to:
  /// **'Naplaćuje se po satu'**
  String get chargedPerHour;

  /// No description provided for @chargedPerNight.
  ///
  /// In bs, this message translates to:
  /// **'Naplaćuje se po noći'**
  String get chargedPerNight;

  /// No description provided for @oneTimeCharge.
  ///
  /// In bs, this message translates to:
  /// **'Jednokratna naplata'**
  String get oneTimeCharge;

  /// No description provided for @tapToPlacePin.
  ///
  /// In bs, this message translates to:
  /// **'Dodirnite za postavljanje oznake na mapi'**
  String get tapToPlacePin;

  /// No description provided for @servicesOfferedRequired.
  ///
  /// In bs, this message translates to:
  /// **'Ponuđene usluge*'**
  String get servicesOfferedRequired;

  /// No description provided for @serviceTypeRequired.
  ///
  /// In bs, this message translates to:
  /// **'Tip usluge*'**
  String get serviceTypeRequired;

  /// No description provided for @durationRequired.
  ///
  /// In bs, this message translates to:
  /// **'Trajanje (min)*'**
  String get durationRequired;

  /// No description provided for @priceRequired.
  ///
  /// In bs, this message translates to:
  /// **'Cijena*'**
  String get priceRequired;

  /// No description provided for @descriptionOptional.
  ///
  /// In bs, this message translates to:
  /// **'Opis (opcionalno)'**
  String get descriptionOptional;

  /// No description provided for @serviceProvidersRequired.
  ///
  /// In bs, this message translates to:
  /// **'Pružaoci usluga*'**
  String get serviceProvidersRequired;

  /// No description provided for @serviceProviderRequired.
  ///
  /// In bs, this message translates to:
  /// **'Pružalac usluge*'**
  String get serviceProviderRequired;

  /// No description provided for @firstUnitTypeRequired.
  ///
  /// In bs, this message translates to:
  /// **'Prvi tip jedinice*'**
  String get firstUnitTypeRequired;

  /// No description provided for @firstRoomTypeRequired.
  ///
  /// In bs, this message translates to:
  /// **'Prvi tip sobe*'**
  String get firstRoomTypeRequired;

  /// No description provided for @availabilityRequired.
  ///
  /// In bs, this message translates to:
  /// **'Dostupnost*'**
  String get availabilityRequired;

  /// No description provided for @from.
  ///
  /// In bs, this message translates to:
  /// **'Od'**
  String get from;

  /// No description provided for @to.
  ///
  /// In bs, this message translates to:
  /// **'Do'**
  String get to;

  /// No description provided for @uploadCoverPhoto.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj naslovnu fotografiju'**
  String get uploadCoverPhoto;

  /// No description provided for @uploadLogo.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj logo'**
  String get uploadLogo;

  /// No description provided for @updateProfileImage.
  ///
  /// In bs, this message translates to:
  /// **'Ažuriraj profilnu sliku'**
  String get updateProfileImage;

  /// No description provided for @myBusinesses.
  ///
  /// In bs, this message translates to:
  /// **'Moji businessi'**
  String get myBusinesses;

  /// No description provided for @selectBusinessToManage.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite business kojim želite upravljati ili dodajte novi.'**
  String get selectBusinessToManage;

  /// No description provided for @noBusinessesYet.
  ///
  /// In bs, this message translates to:
  /// **'Još nema businessa'**
  String get noBusinessesYet;

  /// No description provided for @createBusinessToStart.
  ///
  /// In bs, this message translates to:
  /// **'Kreirajte business da počnete upravljati rezervacijama i zaradom.'**
  String get createBusinessToStart;

  /// No description provided for @appointmentCustomer.
  ///
  /// In bs, this message translates to:
  /// **'Korisnik termina'**
  String get appointmentCustomer;

  /// No description provided for @todaysBookings.
  ///
  /// In bs, this message translates to:
  /// **'Današnje rezervacije'**
  String get todaysBookings;

  /// No description provided for @todaysAppointments.
  ///
  /// In bs, this message translates to:
  /// **'Današnji termini'**
  String get todaysAppointments;

  /// No description provided for @serviceProvider.
  ///
  /// In bs, this message translates to:
  /// **'Pružalac usluge'**
  String get serviceProvider;

  /// No description provided for @selectDayForSlots.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite dan da provjerite koji su termini slobodni ili zauzeti.'**
  String get selectDayForSlots;

  /// No description provided for @slotColorsExplanation.
  ///
  /// In bs, this message translates to:
  /// **'Ljubičasti termini su zauzeti ili blokirani. Tamni termini su dostupni.'**
  String get slotColorsExplanation;

  /// No description provided for @noProviderHoursSelectedDay.
  ///
  /// In bs, this message translates to:
  /// **'Ovaj pružalac usluge nema radno vrijeme odabranog dana.'**
  String get noProviderHoursSelectedDay;

  /// No description provided for @personalInformation.
  ///
  /// In bs, this message translates to:
  /// **'Lični podaci'**
  String get personalInformation;

  /// No description provided for @security.
  ///
  /// In bs, this message translates to:
  /// **'Sigurnost'**
  String get security;

  /// No description provided for @addBusinessImage.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj sliku businessa'**
  String get addBusinessImage;

  /// No description provided for @addEveryBookableService.
  ///
  /// In bs, this message translates to:
  /// **'Dodajte svaku uslugu koju korisnici mogu rezervisati.'**
  String get addEveryBookableService;

  /// No description provided for @serviceProvidersDescription.
  ///
  /// In bs, this message translates to:
  /// **'Dodajte svaku osobu koja obavlja termine i podesite njenu ponavljajuću dostupnost.'**
  String get serviceProvidersDescription;

  /// No description provided for @recurringSlotsDescription.
  ///
  /// In bs, this message translates to:
  /// **'Kreirajte sedmične termine koji se ponavljaju. Korisnici će vidjeti samo dostupne termine.'**
  String get recurringSlotsDescription;

  /// No description provided for @endTimeAfterStart.
  ///
  /// In bs, this message translates to:
  /// **'Vrijeme završetka mora biti nakon vremena početka.'**
  String get endTimeAfterStart;

  /// No description provided for @addPhotosUpToSeven.
  ///
  /// In bs, this message translates to:
  /// **'Dodajte do 7 JPG ili PNG fotografija.'**
  String get addPhotosUpToSeven;

  /// No description provided for @businessLogo.
  ///
  /// In bs, this message translates to:
  /// **'Logo businessa'**
  String get businessLogo;

  /// No description provided for @coverPhoto.
  ///
  /// In bs, this message translates to:
  /// **'Naslovna fotografija'**
  String get coverPhoto;

  /// No description provided for @customerInformation.
  ///
  /// In bs, this message translates to:
  /// **'Podaci o korisniku'**
  String get customerInformation;

  /// No description provided for @confirmationDetails.
  ///
  /// In bs, this message translates to:
  /// **'Detalji potvrde'**
  String get confirmationDetails;

  /// No description provided for @confirmationCode.
  ///
  /// In bs, this message translates to:
  /// **'Kod potvrde'**
  String get confirmationCode;

  /// No description provided for @showCodeToProvider.
  ///
  /// In bs, this message translates to:
  /// **'Pokažite ovaj kod pružaocu usluge'**
  String get showCodeToProvider;

  /// No description provided for @quickInfo.
  ///
  /// In bs, this message translates to:
  /// **'Kratke informacije'**
  String get quickInfo;

  /// No description provided for @priceBreakdown.
  ///
  /// In bs, this message translates to:
  /// **'Pregled cijene'**
  String get priceBreakdown;

  /// No description provided for @billingInformation.
  ///
  /// In bs, this message translates to:
  /// **'Podaci za naplatu'**
  String get billingInformation;

  /// No description provided for @selectNewDate.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite novi datum'**
  String get selectNewDate;

  /// No description provided for @providerNoLongerAvailable.
  ///
  /// In bs, this message translates to:
  /// **'Ovaj pružalac usluge više nije dostupan.'**
  String get providerNoLongerAvailable;

  /// No description provided for @availableAddOns.
  ///
  /// In bs, this message translates to:
  /// **'Dostupni dodaci'**
  String get availableAddOns;

  /// No description provided for @autumnDiscounts.
  ///
  /// In bs, this message translates to:
  /// **'🍂 Jesenski popusti do 30%'**
  String get autumnDiscounts;

  /// No description provided for @selectTime.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite vrijeme'**
  String get selectTime;

  /// No description provided for @bookingInformation.
  ///
  /// In bs, this message translates to:
  /// **'Informacije o rezervaciji'**
  String get bookingInformation;

  /// No description provided for @checkInOutTimes.
  ///
  /// In bs, this message translates to:
  /// **'Prijava: 15:00 • Odjava: 11:00'**
  String get checkInOutTimes;

  /// No description provided for @priceSummary.
  ///
  /// In bs, this message translates to:
  /// **'Pregled cijene'**
  String get priceSummary;

  /// No description provided for @duration.
  ///
  /// In bs, this message translates to:
  /// **'Trajanje'**
  String get duration;

  /// No description provided for @pricePerSession.
  ///
  /// In bs, this message translates to:
  /// **'Cijena po terminu'**
  String get pricePerSession;

  /// No description provided for @addNewBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj novi business'**
  String get addNewBusiness;

  /// No description provided for @backToHome.
  ///
  /// In bs, this message translates to:
  /// **'Nazad na početnu'**
  String get backToHome;

  /// No description provided for @confirmAndPay.
  ///
  /// In bs, this message translates to:
  /// **'Potvrdi i plati {total}'**
  String confirmAndPay(String total);

  /// No description provided for @saveChanges.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvaj izmjene'**
  String get saveChanges;

  /// No description provided for @manage.
  ///
  /// In bs, this message translates to:
  /// **'Upravljaj'**
  String get manage;

  /// No description provided for @contactCustomer.
  ///
  /// In bs, this message translates to:
  /// **'Kontaktiraj korisnika'**
  String get contactCustomer;

  /// No description provided for @declineBooking.
  ///
  /// In bs, this message translates to:
  /// **'Odbij rezervaciju'**
  String get declineBooking;

  /// No description provided for @messageCustomer.
  ///
  /// In bs, this message translates to:
  /// **'Pošalji poruku korisniku'**
  String get messageCustomer;

  /// No description provided for @declineAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Odbij termin'**
  String get declineAppointment;

  /// No description provided for @rescheduleBooking.
  ///
  /// In bs, this message translates to:
  /// **'Promijeni termin rezervacije'**
  String get rescheduleBooking;

  /// No description provided for @proceedToPayment.
  ///
  /// In bs, this message translates to:
  /// **'Nastavi na plaćanje'**
  String get proceedToPayment;

  /// No description provided for @cancelBooking.
  ///
  /// In bs, this message translates to:
  /// **'Otkaži rezervaciju'**
  String get cancelBooking;

  /// No description provided for @seedDemoStays.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj 20 demo smještaja'**
  String get seedDemoStays;

  /// No description provided for @seedDemoServices.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj 29 demo usluga'**
  String get seedDemoServices;

  /// No description provided for @createBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Kreiraj business'**
  String get createBusiness;

  /// No description provided for @addService.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj uslugu'**
  String get addService;

  /// No description provided for @addProvider.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj pružaoca usluge'**
  String get addProvider;

  /// No description provided for @addAvailabilitySlot.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj termin dostupnosti'**
  String get addAvailabilitySlot;

  /// No description provided for @reviewAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Pregled termina'**
  String get reviewAppointment;

  /// No description provided for @blockSlot.
  ///
  /// In bs, this message translates to:
  /// **'Blokiraj termin'**
  String get blockSlot;

  /// No description provided for @unblockSlot.
  ///
  /// In bs, this message translates to:
  /// **'Odblokiraj termin'**
  String get unblockSlot;

  /// No description provided for @processingPayment.
  ///
  /// In bs, this message translates to:
  /// **'Plaćanje se obrađuje...'**
  String get processingPayment;

  /// No description provided for @rescheduling.
  ///
  /// In bs, this message translates to:
  /// **'Termin se mijenja...'**
  String get rescheduling;

  /// No description provided for @confirmReschedule.
  ///
  /// In bs, this message translates to:
  /// **'Potvrdi promjenu termina'**
  String get confirmReschedule;

  /// No description provided for @agreeToTermsAndPrivacy.
  ///
  /// In bs, this message translates to:
  /// **'Slažem se s Uslovima korištenja i Pravilima privatnosti'**
  String get agreeToTermsAndPrivacy;

  /// No description provided for @acceptTermsToContinue.
  ///
  /// In bs, this message translates to:
  /// **'Prihvatite uslove za nastavak.'**
  String get acceptTermsToContinue;

  /// No description provided for @businessPhotosCount.
  ///
  /// In bs, this message translates to:
  /// **'Fotografije businessa ({count}/{max})'**
  String businessPhotosCount(int count, int max);

  /// No description provided for @addPhotos.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj fotografije'**
  String get addPhotos;

  /// No description provided for @coverPhotoFormatHint.
  ///
  /// In bs, this message translates to:
  /// **'JPG, PNG do 10 MB'**
  String get coverPhotoFormatHint;

  /// No description provided for @logoFormatHint.
  ///
  /// In bs, this message translates to:
  /// **'JPG, PNG do 5 MB'**
  String get logoFormatHint;

  /// No description provided for @extraBreakfast.
  ///
  /// In bs, this message translates to:
  /// **'Doručak'**
  String get extraBreakfast;

  /// No description provided for @extraParking.
  ///
  /// In bs, this message translates to:
  /// **'Parking'**
  String get extraParking;

  /// No description provided for @extraSpaAccess.
  ///
  /// In bs, this message translates to:
  /// **'Pristup spa centru'**
  String get extraSpaAccess;

  /// No description provided for @extraAirportTransfer.
  ///
  /// In bs, this message translates to:
  /// **'Transfer s aerodroma'**
  String get extraAirportTransfer;

  /// No description provided for @extraLateCheckout.
  ///
  /// In bs, this message translates to:
  /// **'Kasna odjava'**
  String get extraLateCheckout;

  /// No description provided for @extraPetStay.
  ///
  /// In bs, this message translates to:
  /// **'Boravak kućnog ljubimca'**
  String get extraPetStay;

  /// No description provided for @extraBed.
  ///
  /// In bs, this message translates to:
  /// **'Dodatni krevet'**
  String get extraBed;

  /// No description provided for @extraLaundryService.
  ///
  /// In bs, this message translates to:
  /// **'Usluga pranja veša'**
  String get extraLaundryService;

  /// No description provided for @extraQuadBikeRental.
  ///
  /// In bs, this message translates to:
  /// **'Iznajmljivanje quad bicikla'**
  String get extraQuadBikeRental;

  /// No description provided for @extraGuidedTour.
  ///
  /// In bs, this message translates to:
  /// **'Lokalna vođena tura'**
  String get extraGuidedTour;

  /// No description provided for @extraHikingGuide.
  ///
  /// In bs, this message translates to:
  /// **'Privatni vodič za planinarenje'**
  String get extraHikingGuide;

  /// No description provided for @extraBoatTour.
  ///
  /// In bs, this message translates to:
  /// **'Privatna tura brodom'**
  String get extraBoatTour;

  /// No description provided for @leaveReview.
  ///
  /// In bs, this message translates to:
  /// **'Ostavi recenziju'**
  String get leaveReview;

  /// No description provided for @rateYourExperience.
  ///
  /// In bs, this message translates to:
  /// **'Ocijenite svoje iskustvo'**
  String get rateYourExperience;

  /// No description provided for @howWasYourExperience.
  ///
  /// In bs, this message translates to:
  /// **'Kako je bilo?'**
  String get howWasYourExperience;

  /// No description provided for @writeReviewOptional.
  ///
  /// In bs, this message translates to:
  /// **'Napišite recenziju (opcionalno)'**
  String get writeReviewOptional;

  /// No description provided for @shareYourExperience.
  ///
  /// In bs, this message translates to:
  /// **'Podijelite svoje iskustvo...'**
  String get shareYourExperience;

  /// No description provided for @submitReview.
  ///
  /// In bs, this message translates to:
  /// **'Objavi recenziju'**
  String get submitReview;

  /// No description provided for @couldNotSubmitReview.
  ///
  /// In bs, this message translates to:
  /// **'Nismo mogli objaviti recenziju. Pokušajte ponovo.'**
  String get couldNotSubmitReview;

  /// No description provided for @allReviews.
  ///
  /// In bs, this message translates to:
  /// **'Sve recenzije'**
  String get allReviews;

  /// No description provided for @activeBookings.
  ///
  /// In bs, this message translates to:
  /// **'Aktivne rezervacije'**
  String get activeBookings;

  /// No description provided for @activeAppointments.
  ///
  /// In bs, this message translates to:
  /// **'Aktivni termini'**
  String get activeAppointments;

  /// No description provided for @earningsThisMonth.
  ///
  /// In bs, this message translates to:
  /// **'Zarada ovog mjeseca'**
  String get earningsThisMonth;

  /// No description provided for @averageRating.
  ///
  /// In bs, this message translates to:
  /// **'Prosječna ocjena'**
  String get averageRating;

  /// No description provided for @earningsTrend.
  ///
  /// In bs, this message translates to:
  /// **'Trend zarade'**
  String get earningsTrend;

  /// No description provided for @bookingsTrend.
  ///
  /// In bs, this message translates to:
  /// **'Trend rezervacija'**
  String get bookingsTrend;

  /// No description provided for @appointmentsTrend.
  ///
  /// In bs, this message translates to:
  /// **'Trend termina'**
  String get appointmentsTrend;

  /// No description provided for @week.
  ///
  /// In bs, this message translates to:
  /// **'Sedmica {count}'**
  String week(int count);

  /// No description provided for @switchBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Promijeni business'**
  String get switchBusiness;

  /// No description provided for @appointments.
  ///
  /// In bs, this message translates to:
  /// **'Termini'**
  String get appointments;

  /// No description provided for @earnings.
  ///
  /// In bs, this message translates to:
  /// **'Zarada'**
  String get earnings;

  /// No description provided for @totalEarningsThisMonth.
  ///
  /// In bs, this message translates to:
  /// **'Ukupna zarada ovog mjeseca'**
  String get totalEarningsThisMonth;

  /// No description provided for @pendingPayouts.
  ///
  /// In bs, this message translates to:
  /// **'Isplate na čekanju'**
  String get pendingPayouts;

  /// No description provided for @completedPayouts.
  ///
  /// In bs, this message translates to:
  /// **'Završene isplate'**
  String get completedPayouts;

  /// No description provided for @earningsLoadFailed.
  ///
  /// In bs, this message translates to:
  /// **'Nismo mogli učitati zaradu.'**
  String get earningsLoadFailed;

  /// No description provided for @selectBusiness.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite business'**
  String get selectBusiness;

  /// No description provided for @payWithCash.
  ///
  /// In bs, this message translates to:
  /// **'Plati gotovinom'**
  String get payWithCash;

  /// No description provided for @confirmBooking.
  ///
  /// In bs, this message translates to:
  /// **'Potvrdi rezervaciju'**
  String get confirmBooking;

  /// No description provided for @validCardDetailsRequired.
  ///
  /// In bs, this message translates to:
  /// **'Unesite ispravan 16-cifren broj kartice, MM/GG i CVV.'**
  String get validCardDetailsRequired;

  /// No description provided for @onlineEarnings.
  ///
  /// In bs, this message translates to:
  /// **'Online zarada'**
  String get onlineEarnings;

  /// No description provided for @cashEarnings.
  ///
  /// In bs, this message translates to:
  /// **'Gotovinska zarada'**
  String get cashEarnings;

  /// No description provided for @markAsCompleted.
  ///
  /// In bs, this message translates to:
  /// **'Označi kao završeno'**
  String get markAsCompleted;

  /// No description provided for @cash.
  ///
  /// In bs, this message translates to:
  /// **'Gotovina'**
  String get cash;

  /// No description provided for @cashPaymentDue.
  ///
  /// In bs, this message translates to:
  /// **'Plaćanje gotovinom pri dolasku'**
  String get cashPaymentDue;

  /// No description provided for @markAsNoShow.
  ///
  /// In bs, this message translates to:
  /// **'Označi kao nedolazak'**
  String get markAsNoShow;

  /// No description provided for @noShow.
  ///
  /// In bs, this message translates to:
  /// **'Nije se pojavio'**
  String get noShow;

  /// No description provided for @noShowEarningsHint.
  ///
  /// In bs, this message translates to:
  /// **'Označavanjem nedolaska iznos će biti uklonjen iz zarade i statistike.'**
  String get noShowEarningsHint;

  /// No description provided for @earningsPeriod.
  ///
  /// In bs, this message translates to:
  /// **'Period'**
  String get earningsPeriod;

  /// No description provided for @currentWeek.
  ///
  /// In bs, this message translates to:
  /// **'Ova sedmica'**
  String get currentWeek;

  /// No description provided for @previousWeek.
  ///
  /// In bs, this message translates to:
  /// **'Prošla sedmica'**
  String get previousWeek;

  /// No description provided for @currentMonth.
  ///
  /// In bs, this message translates to:
  /// **'Ovaj mjesec'**
  String get currentMonth;

  /// No description provided for @previousMonth.
  ///
  /// In bs, this message translates to:
  /// **'Prošli mjesec'**
  String get previousMonth;

  /// No description provided for @currentYear.
  ///
  /// In bs, this message translates to:
  /// **'Ova godina'**
  String get currentYear;

  /// No description provided for @previousYear.
  ///
  /// In bs, this message translates to:
  /// **'Prošla godina'**
  String get previousYear;

  /// No description provided for @customRange.
  ///
  /// In bs, this message translates to:
  /// **'Prilagođeni period'**
  String get customRange;

  /// No description provided for @selectDateRange.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite period'**
  String get selectDateRange;

  /// No description provided for @startDate.
  ///
  /// In bs, this message translates to:
  /// **'Početni datum'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In bs, this message translates to:
  /// **'Završni datum'**
  String get endDate;

  /// No description provided for @providerCommissionRateHint.
  ///
  /// In bs, this message translates to:
  /// **'Provizija zaposlenika (%)'**
  String get providerCommissionRateHint;

  /// No description provided for @providerCommissionRateDescription.
  ///
  /// In bs, this message translates to:
  /// **'Postotak cijene usluge koji zaposlenik zarađuje za svakog odrađenog klijenta.'**
  String get providerCommissionRateDescription;

  /// No description provided for @providerCommissionRateRangeHint.
  ///
  /// In bs, this message translates to:
  /// **'0 - 100'**
  String get providerCommissionRateRangeHint;

  /// No description provided for @allEmployees.
  ///
  /// In bs, this message translates to:
  /// **'Svi zaposlenici'**
  String get allEmployees;

  /// No description provided for @grossEarnings.
  ///
  /// In bs, this message translates to:
  /// **'Bruto zarada'**
  String get grossEarnings;

  /// No description provided for @providerEarnings.
  ///
  /// In bs, this message translates to:
  /// **'Zarada zaposlenika'**
  String get providerEarnings;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In bs, this message translates to:
  /// **'PRAVILA PRIVATNOSTI\n\nMultiBook obrađuje podatke samo radi pružanja aplikacije za pronalazak i rezervaciju smještaja i usluga.\n\n1. Podaci koje prikupljamo\nPrikupljamo podatke računa koje unesete (ime, email, broj telefona, profilna slika i opcionalni datum rođenja), podatke o rezervacijama i terminima, poruke, sačuvane oglase, ocjene i tehničke podatke potrebne za sigurnost aplikacije.\n\n2. Lokacija\nLokaciju koristimo samo nakon vaše dozvole. Grad i adresa služe za prikaz relevantnih oglasa, mapa i pretrage u blizini. Lokaciju možete odbiti ili kasnije izmijeniti u profilu.\n\n3. Kako koristimo i dijelimo podatke\nPodaci se koriste za rezervacije, termine, plaćanja, komunikaciju s businessom, obavijesti, sigurnost i unapređenje aplikacije. Kada rezervišete, businessu dijelimo samo podatke potrebne za obradu: ime, kontakt, odabrani termin ili datume i relevantne zahtjeve. Ne prodajemo lične podatke.\n\n4. Plaćanja i sigurnost\nBusiness ne dobija pune podatke platne kartice. Čuvamo samo status plaćanja i potvrdu transakcije potrebne za rezervaciju. Koristimo Firebase infrastrukturu za autentikaciju, bazu, pohranu slika i notifikacije.\n\n5. Vaša prava\nMožete urediti profil, ukloniti sačuvane oglase, upravljati dozvolom lokacije i zatražiti brisanje računa kroz podršku. Poruke i podaci o rezervacijama mogu se čuvati koliko je potrebno za sigurnost, rješavanje sporova i zakonske obaveze.\n\n6. Izmjene\nOva pravila možemo ažurirati kada se aplikacija promijeni. O značajnim izmjenama obavijestit ćemo vas u aplikaciji.'**
  String get privacyPolicyContent;

  /// No description provided for @termsOfServiceContent.
  ///
  /// In bs, this message translates to:
  /// **'USLOVI KORIŠTENJA\n\nKorištenjem MultiBooka prihvatate ove uslove. MultiBook povezuje korisnike s nezavisnim businessima koji nude smještaj i usluge.\n\n1. Vaš račun\nDužni ste unijeti tačne podatke i čuvati pristup svom računu. Ne smijete koristiti tuđi račun, slati neželjene poruke, zaobilaziti sigurnosne mjere ili zloupotrebljavati aplikaciju.\n\n2. Rezervacije i termini\nPrije potvrde provjerite datume, vrijeme, broj gostiju, odabranu sobu ili uslugu i ukupnu cijenu. Potvrđena rezervacija ili appointment predstavlja dogovor između vas i odabranog businessa.\n\n3. Plaćanje, otkazivanje i promjene\nOvisno o ponudi, plaćanje može biti online ili gotovinom. Kod gotovinskog plaćanja obavezni ste platiti businessu prema potvrđenim detaljima. Pravila otkazivanja, reschedule opcije i dostupnost zavise od businessa i vrste rezervacije. Pravovremeno otkažite termin ako ne možete doći.\n\n4. Businessi i kvalitet usluge\nBusinessi su nezavisni pružaoci i odgovorni su za tačnost oglasa, dostupnost, kvalitet i pružanje usluge. MultiBook pruža recenzije i podršku, ali ne garantuje da će svaka usluga ili smještaj odgovarati vašim očekivanjima.\n\n5. Recenzije i ponašanje\nPišite iskrene, relevantne i pristojne recenzije. Zabranjeni su uvredljiv sadržaj, lažne rezervacije, prevara, diskriminacija i ponašanje koje ugrožava druge korisnike ili businesse.\n\n6. Izmjene uslova\nMožemo ažurirati ove uslove zbog novih funkcija, sigurnosti ili zakonskih zahtjeva. Nastavak korištenja nakon objave izmjena znači da ih prihvatate.'**
  String get termsOfServiceContent;

  /// No description provided for @supportRequests.
  ///
  /// In bs, this message translates to:
  /// **'Zahtjevi za podršku'**
  String get supportRequests;

  /// No description provided for @noSupportRequests.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate zahtjeva za podršku.'**
  String get noSupportRequests;

  /// No description provided for @newSupportRequest.
  ///
  /// In bs, this message translates to:
  /// **'Novi zahtjev'**
  String get newSupportRequest;

  /// No description provided for @supportRequestDescription.
  ///
  /// In bs, this message translates to:
  /// **'Pošaljite nam detalje problema, a naš tim će pregledati vaš zahtjev.'**
  String get supportRequestDescription;

  /// No description provided for @selectSupportTopic.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite temu'**
  String get selectSupportTopic;

  /// No description provided for @supportSubject.
  ///
  /// In bs, this message translates to:
  /// **'Naslov'**
  String get supportSubject;

  /// No description provided for @supportSubjectHint.
  ///
  /// In bs, this message translates to:
  /// **'Kratko opišite problem'**
  String get supportSubjectHint;

  /// No description provided for @supportMessage.
  ///
  /// In bs, this message translates to:
  /// **'Poruka'**
  String get supportMessage;

  /// No description provided for @supportMessageHint.
  ///
  /// In bs, this message translates to:
  /// **'Dodajte što više korisnih detalja...'**
  String get supportMessageHint;

  /// No description provided for @sendSupportRequest.
  ///
  /// In bs, this message translates to:
  /// **'Pošalji zahtjev'**
  String get sendSupportRequest;

  /// No description provided for @supportRequestSent.
  ///
  /// In bs, this message translates to:
  /// **'Vaš zahtjev je uspješno poslan.'**
  String get supportRequestSent;

  /// No description provided for @supportRequestFailed.
  ///
  /// In bs, this message translates to:
  /// **'Nismo uspjeli poslati zahtjev. Pokušajte ponovo.'**
  String get supportRequestFailed;

  /// No description provided for @supportCategoryAccount.
  ///
  /// In bs, this message translates to:
  /// **'Račun i profil'**
  String get supportCategoryAccount;

  /// No description provided for @supportCategoryBooking.
  ///
  /// In bs, this message translates to:
  /// **'Rezervacija smještaja'**
  String get supportCategoryBooking;

  /// No description provided for @supportCategoryAppointment.
  ///
  /// In bs, this message translates to:
  /// **'Termin usluge'**
  String get supportCategoryAppointment;

  /// No description provided for @supportCategoryPayment.
  ///
  /// In bs, this message translates to:
  /// **'Plaćanje'**
  String get supportCategoryPayment;

  /// No description provided for @supportCategoryTechnical.
  ///
  /// In bs, this message translates to:
  /// **'Tehnički problem'**
  String get supportCategoryTechnical;

  /// No description provided for @supportCategoryOther.
  ///
  /// In bs, this message translates to:
  /// **'Ostalo'**
  String get supportCategoryOther;

  /// No description provided for @supportStatusOpen.
  ///
  /// In bs, this message translates to:
  /// **'Otvoren'**
  String get supportStatusOpen;

  /// No description provided for @supportStatusInProgress.
  ///
  /// In bs, this message translates to:
  /// **'U obradi'**
  String get supportStatusInProgress;

  /// No description provided for @supportStatusResolved.
  ///
  /// In bs, this message translates to:
  /// **'Riješen'**
  String get supportStatusResolved;

  /// No description provided for @helpCenterHeading.
  ///
  /// In bs, this message translates to:
  /// **'Kako vam možemo pomoći?'**
  String get helpCenterHeading;

  /// No description provided for @helpCenterIntro.
  ///
  /// In bs, this message translates to:
  /// **'Pronađite jasne odgovore o smještajima, uslugama, plaćanju, promjenama rezervacija i sigurnom korištenju MultiBooka.'**
  String get helpCenterIntro;

  /// No description provided for @helpCenterSearchHint.
  ///
  /// In bs, this message translates to:
  /// **'Pretražite pitanja i odgovore'**
  String get helpCenterSearchHint;

  /// No description provided for @helpCenterBrowseTopics.
  ///
  /// In bs, this message translates to:
  /// **'Pregledajte po temi'**
  String get helpCenterBrowseTopics;

  /// No description provided for @helpCenterPopularArticles.
  ///
  /// In bs, this message translates to:
  /// **'Najčešća pitanja'**
  String get helpCenterPopularArticles;

  /// No description provided for @helpCenterSearchResults.
  ///
  /// In bs, this message translates to:
  /// **'Rezultati pretrage'**
  String get helpCenterSearchResults;

  /// No description provided for @helpCenterShowAll.
  ///
  /// In bs, this message translates to:
  /// **'Prikaži sve'**
  String get helpCenterShowAll;

  /// No description provided for @helpCenterNoResultsTitle.
  ///
  /// In bs, this message translates to:
  /// **'Nismo pronašli odgovor'**
  String get helpCenterNoResultsTitle;

  /// No description provided for @helpCenterNoResultsBody.
  ///
  /// In bs, this message translates to:
  /// **'Pokušajte s drugim pojmom ili nam pošaljite zahtjev za podršku.'**
  String get helpCenterNoResultsBody;

  /// No description provided for @helpCenterContactTitle.
  ///
  /// In bs, this message translates to:
  /// **'Još vam je potrebna pomoć?'**
  String get helpCenterContactTitle;

  /// No description provided for @helpCenterContactBody.
  ///
  /// In bs, this message translates to:
  /// **'Pošaljite zahtjev s što više detalja. Naš tim ga može pregledati i pratiti njegov status u aplikaciji.'**
  String get helpCenterContactBody;

  /// No description provided for @helpCenterContactButton.
  ///
  /// In bs, this message translates to:
  /// **'Kontaktirajte podršku'**
  String get helpCenterContactButton;

  /// No description provided for @helpTopicStays.
  ///
  /// In bs, this message translates to:
  /// **'Smještaji i rezervacije'**
  String get helpTopicStays;

  /// No description provided for @helpTopicAppointments.
  ///
  /// In bs, this message translates to:
  /// **'Termini usluga'**
  String get helpTopicAppointments;

  /// No description provided for @helpTopicChanges.
  ///
  /// In bs, this message translates to:
  /// **'Promjene i otkazivanja'**
  String get helpTopicChanges;

  /// No description provided for @helpTopicPayments.
  ///
  /// In bs, this message translates to:
  /// **'Plaćanja i cijene'**
  String get helpTopicPayments;

  /// No description provided for @helpTopicAccount.
  ///
  /// In bs, this message translates to:
  /// **'Račun i privatnost'**
  String get helpTopicAccount;

  /// No description provided for @helpTopicMessages.
  ///
  /// In bs, this message translates to:
  /// **'Poruke i obavijesti'**
  String get helpTopicMessages;

  /// No description provided for @helpTopicTechnical.
  ///
  /// In bs, this message translates to:
  /// **'Pretraga i lokacija'**
  String get helpTopicTechnical;

  /// No description provided for @helpTopicSafety.
  ///
  /// In bs, this message translates to:
  /// **'Sigurnost i podrška'**
  String get helpTopicSafety;

  /// No description provided for @helpFindingBookingStayTitle.
  ///
  /// In bs, this message translates to:
  /// **'Kako pronaći i rezervisati smještaj?'**
  String get helpFindingBookingStayTitle;

  /// No description provided for @helpFindingBookingStaySummary.
  ///
  /// In bs, this message translates to:
  /// **'Koraci od pretrage oglasa do potvrđene rezervacije.'**
  String get helpFindingBookingStaySummary;

  /// No description provided for @helpFindingBookingStayBody.
  ///
  /// In bs, this message translates to:
  /// **'1. Na početnoj stranici odaberite Smještaji, unesite grad ili naziv oglasa i po potrebi otvorite Filtere. Možete birati datume, broj gostiju, grad, cijenu, ocjenu, kategoriju i pogodnosti.\n\n2. Otvorite oglas i provjerite fotografije, lokaciju, cijenu po noći, pogodnosti, pravila i raspoložive jedinice ili sobe.\n\n3. Odaberite datume i goste. Ako business nudi više soba ili jedinica, izaberite željeni tip; ako ga ne izaberete, koristi se osnovna dostupna jedinica navedena uz cijenu oglasa.\n\n4. Na pregledu rezervacije provjerite ukupnu cijenu, poreze, naknade i dodatke. Nakon uspješnog plaćanja ili izbora gotovine, rezervacija je potvrđena i dostupna u Rezervacijama.'**
  String get helpFindingBookingStayBody;

  /// No description provided for @helpStayDatesRoomsTitle.
  ///
  /// In bs, this message translates to:
  /// **'Datumi, gosti i raspoloživost soba'**
  String get helpStayDatesRoomsTitle;

  /// No description provided for @helpStayDatesRoomsSummary.
  ///
  /// In bs, this message translates to:
  /// **'Kako MultiBook računa raspoloživost za privatne objekte i hotele.'**
  String get helpStayDatesRoomsSummary;

  /// No description provided for @helpStayDatesRoomsBody.
  ///
  /// In bs, this message translates to:
  /// **'Za privatnu jedinicu, poput apartmana ili vile s jednom jedinicom, zauzeti datumi ne mogu se odabrati. Provjerite datum prijave i odjave prije nastavka.\n\nZa objekte s više jedinica, poput hotela, raspoloživost se računa po odabranom tipu sobe i kapacitetu. Zato isti datum može ostati dostupan dok god postoji slobodna soba odgovarajućeg tipa.\n\nBroj odraslih i djece utiče na prikaz dostupnih opcija. Ako ne vidite željenu sobu, promijenite broj gostiju ili datume. Cijena se prikazuje po noći; dodatne usluge, porezi i naknade prikazuju se prije potvrde.'**
  String get helpStayDatesRoomsBody;

  /// No description provided for @helpStatusesTitle.
  ///
  /// In bs, this message translates to:
  /// **'Statusi rezervacija i termina'**
  String get helpStatusesTitle;

  /// No description provided for @helpStatusesSummary.
  ///
  /// In bs, this message translates to:
  /// **'Šta znače potvrđeno, završeno, otkazano i odbijeno.'**
  String get helpStatusesSummary;

  /// No description provided for @helpStatusesBody.
  ///
  /// In bs, this message translates to:
  /// **'Potvrđeno znači da je rezervacija smještaja ili termin usluge uspješno kreiran. Za online plaćanje to nastaje nakon uspješne potvrde plaćanja, a za gotovinu nakon potvrde rezervacije.\n\nZavršeno označava raniji termin ili boravak koji je protekao. Tada možete ostaviti jednu recenziju za business.\n\nOtkazano znači da je korisnik otkazao rezervaciju ili termin. Odbijeno označava promjenu statusa koju je napravio business. Ako imate pitanja o konkretnom statusu, otvorite detalje rezervacije ili pošaljite zahtjev podršci.'**
  String get helpStatusesBody;

  /// No description provided for @helpChangesTitle.
  ///
  /// In bs, this message translates to:
  /// **'Kako promijeniti ili otkazati rezervaciju?'**
  String get helpChangesTitle;

  /// No description provided for @helpChangesSummary.
  ///
  /// In bs, this message translates to:
  /// **'Pravila za otkazivanje i jednokratno pomjeranje termina usluge.'**
  String get helpChangesSummary;

  /// No description provided for @helpChangesBody.
  ///
  /// In bs, this message translates to:
  /// **'Otvorite Rezervacije, izaberite aktivnu stavku i pogledajte dostupne radnje. Rezervaciju smještaja ili termin možete otkazati dok je ta opcija dostupna u detaljima.\n\nZa termin usluge korisnik može jednom odabrati Promijeni termin. Nakon toga birate novi datum i samo slobodne slotove odgovarajuće dužine. Business može promijeniti termin više puta kada je to potrebno.\n\nOtkazivanje i promjena mogu uticati na dostupnost i naplatu prema pravilima businessa. Prije potvrde pažljivo provjerite novi datum, vrijeme, odabrane usluge i ukupan iznos.'**
  String get helpChangesBody;

  /// No description provided for @helpCashNoShowTitle.
  ///
  /// In bs, this message translates to:
  /// **'Online plaćanje, gotovina i nedolazak'**
  String get helpCashNoShowTitle;

  /// No description provided for @helpCashNoShowSummary.
  ///
  /// In bs, this message translates to:
  /// **'Razlika između načina plaćanja i šta se dešava ako ne dođete.'**
  String get helpCashNoShowSummary;

  /// No description provided for @helpCashNoShowBody.
  ///
  /// In bs, this message translates to:
  /// **'Business može ponuditi online plaćanje ili plaćanje gotovinom. Kod online plaćanja unosite podatke kartice u sigurnom koraku plaćanja. Kod gotovine iznos plaćate direktno businessu pri dolasku ili nakon usluge, prema potvrđenim detaljima.\n\nBez obzira na način plaćanja, potvrđena stavka ulazi u evidenciju businessa. Za prošlu gotovinsku rezervaciju ili termin business može označiti nedolazak ako se klijent nije pojavio. Time se iznos uklanja iz zarade, statistike i trendova businessa.\n\nAko smatrate da je status ili iznos pogrešan, prvo provjerite detalje rezervacije, zatim kontaktirajte business porukom ili otvorite zahtjev podršci.'**
  String get helpCashNoShowBody;

  /// No description provided for @helpPaymentSecurityTitle.
  ///
  /// In bs, this message translates to:
  /// **'Sigurnost kartice, cijene i potvrde'**
  String get helpPaymentSecurityTitle;

  /// No description provided for @helpPaymentSecuritySummary.
  ///
  /// In bs, this message translates to:
  /// **'Šta se prikazuje prije plaćanja i koje podatke business vidi.'**
  String get helpPaymentSecuritySummary;

  /// No description provided for @helpPaymentSecurityBody.
  ///
  /// In bs, this message translates to:
  /// **'Prije plaćanja MultiBook prikazuje detaljan obračun: osnovnu cijenu smještaja ili usluga, izabrane dodatke, naknade i poreze. Potvrdite plaćanje tek kada su iznos, datumi i vrijeme tačni.\n\nBusiness ne dobija puni broj vaše kartice. U detaljima može biti prikazan samo način plaćanja i maskirani završetak kartice, kada je dostupan.\n\nSačuvajte potvrdu rezervacije ili termina i njen kod. On pomaže pri komunikaciji s businessom i podrškom. Nikada ne šaljite puni broj kartice, CVV, lozinku ili kodove za prijavu kroz chat.'**
  String get helpPaymentSecurityBody;

  /// No description provided for @helpProfileDataTitle.
  ///
  /// In bs, this message translates to:
  /// **'Profil, lokacija i lični podaci'**
  String get helpProfileDataTitle;

  /// No description provided for @helpProfileDataSummary.
  ///
  /// In bs, this message translates to:
  /// **'Kako urediti podatke, upravljati dozvolom lokacije i zaštititi račun.'**
  String get helpProfileDataSummary;

  /// No description provided for @helpProfileDataBody.
  ///
  /// In bs, this message translates to:
  /// **'U Profilu možete urediti ime, broj telefona, adresu, grad, datum rođenja, državni pozivni broj i profilnu sliku. Email je povezan s vašim načinom prijave i zato može biti zaključan za direktnu izmjenu.\n\nLokaciju tražimo uz vašu dozvolu kako bismo prikazali oglase u vašem gradu, karte i rezultate u blizini. Dozvolu možete odbiti ili promijeniti u postavkama uređaja; grad zatim možete ručno urediti u profilu.\n\nČuvajte lozinku i pristup računu. Ako primijetite nepoznatu aktivnost ili želite brisanje računa, odmah pošaljite zahtjev podršci.'**
  String get helpProfileDataBody;

  /// No description provided for @helpMessagesTitle.
  ///
  /// In bs, this message translates to:
  /// **'Poruke, obavijesti i podrška'**
  String get helpMessagesTitle;

  /// No description provided for @helpMessagesSummary.
  ///
  /// In bs, this message translates to:
  /// **'Kako komunicirati s businessom i upravljati obavijestima.'**
  String get helpMessagesSummary;

  /// No description provided for @helpMessagesBody.
  ///
  /// In bs, this message translates to:
  /// **'Poruke u MultiBooku uvijek se vode između korisnika i konkretnog businessa, ne samo vlasnika businessa. Chat možete otvoriti iz detalja rezervacije ili termina, a listu svih razgovora pronaći ćete u Profilu ili More sekciji.\n\nPush obavijest za novu poruku se ne šalje dok je taj chat otvoren. Nepročitane poruke su označene u listi razgovora i na relevantnim stavkama navigacije.\n\nZa problem koji ne može riješiti business, otvorite Kontaktirajte nas. Zahtjev uključuje temu, naslov i poruku, a njegov status možete pratiti u Zahtjevima za podršku.'**
  String get helpMessagesBody;

  /// No description provided for @helpLocationSearchTitle.
  ///
  /// In bs, this message translates to:
  /// **'Pretraga, filteri i lokacija'**
  String get helpLocationSearchTitle;

  /// No description provided for @helpLocationSearchSummary.
  ///
  /// In bs, this message translates to:
  /// **'Kako dobiti relevantnije rezultate za smještaje i usluge.'**
  String get helpLocationSearchSummary;

  /// No description provided for @helpLocationSearchBody.
  ///
  /// In bs, this message translates to:
  /// **'Za smještaj možete pretraživati grad ili naziv oglasa te koristiti filtre za datume, goste, cijenu, ocjenu, kategoriju i pogodnosti. Za usluge možete birati datum, vrijeme, vrstu businessa, grad, cijenu i sortiranje.\n\nKada filtrirate uslugu po vremenu, MultiBook uzima u obzir trajanje odabranih usluga i stvarno zauzete slotove svih zaposlenika. Rezultat se prikazuje samo ako je kod najmanje jednog odgovarajućeg zaposlenika moguć cijeli termin.\n\nAko ne pronalazite rezultate, odaberite Sve gradove, proširite raspon cijene, promijenite datum ili uklonite dio filtera.'**
  String get helpLocationSearchBody;

  /// No description provided for @helpSafetyTitle.
  ///
  /// In bs, this message translates to:
  /// **'Sigurnost, recenzije i prijava problema'**
  String get helpSafetyTitle;

  /// No description provided for @helpSafetySummary.
  ///
  /// In bs, this message translates to:
  /// **'Pravila za sigurnu komunikaciju, tačne recenzije i prijavu sumnjivog sadržaja.'**
  String get helpSafetySummary;

  /// No description provided for @helpSafetyBody.
  ///
  /// In bs, this message translates to:
  /// **'Koristite MultiBook chat za komunikaciju o rezervaciji ili terminu i dijelite samo podatke koji su potrebni. Ne šaljite lozinke, CVV, jednokratne kodove ni pune podatke kartice.\n\nNakon završenog boravka ili termina možete ostaviti jednu iskrenu recenziju po businessu. Ocjena i komentar trebaju opisivati stvarno iskustvo, bez uvreda, diskriminacije, prijetnji ili lažnih navoda.\n\nAko je oglas netačan, komunikacija neprimjerena ili sumnjate na prevaru, sačuvajte relevantne detalje i pošaljite zahtjev podršci. U hitnim ili sigurnosno osjetljivim situacijama kontaktirajte lokalne nadležne službe.'**
  String get helpSafetyBody;

  /// No description provided for @savedPaymentMethods.
  ///
  /// In bs, this message translates to:
  /// **'Sačuvane metode plaćanja'**
  String get savedPaymentMethods;

  /// No description provided for @savedPaymentMethodsDescription.
  ///
  /// In bs, this message translates to:
  /// **'Odaberite podrazumijevanu karticu za brže plaćanje.'**
  String get savedPaymentMethodsDescription;

  /// No description provided for @noSavedPaymentMethods.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate sačuvanih kartica.'**
  String get noSavedPaymentMethods;

  /// No description provided for @addPaymentMethod.
  ///
  /// In bs, this message translates to:
  /// **'Dodaj karticu'**
  String get addPaymentMethod;

  /// No description provided for @defaultPaymentMethod.
  ///
  /// In bs, this message translates to:
  /// **'Podrazumijevana'**
  String get defaultPaymentMethod;

  /// No description provided for @setAsDefault.
  ///
  /// In bs, this message translates to:
  /// **'Postavi kao glavnu'**
  String get setAsDefault;

  /// No description provided for @activePromotions.
  ///
  /// In bs, this message translates to:
  /// **'Aktivne promocije'**
  String get activePromotions;

  /// No description provided for @noPromotions.
  ///
  /// In bs, this message translates to:
  /// **'Još nemate kreiranih promocija.'**
  String get noPromotions;

  /// No description provided for @createPromotion.
  ///
  /// In bs, this message translates to:
  /// **'Kreiraj promociju'**
  String get createPromotion;

  /// No description provided for @promotionName.
  ///
  /// In bs, this message translates to:
  /// **'Naziv promocije'**
  String get promotionName;

  /// No description provided for @promotionNameHint.
  ///
  /// In bs, this message translates to:
  /// **'npr. Ljetni popust'**
  String get promotionNameHint;

  /// No description provided for @discountType.
  ///
  /// In bs, this message translates to:
  /// **'Tip popusta'**
  String get discountType;

  /// No description provided for @discountValue.
  ///
  /// In bs, this message translates to:
  /// **'Vrijednost popusta'**
  String get discountValue;

  /// No description provided for @promoCodeOptional.
  ///
  /// In bs, this message translates to:
  /// **'Promo kod (opcionalno)'**
  String get promoCodeOptional;

  /// No description provided for @startsOn.
  ///
  /// In bs, this message translates to:
  /// **'Počinje'**
  String get startsOn;

  /// No description provided for @endsOn.
  ///
  /// In bs, this message translates to:
  /// **'Završava'**
  String get endsOn;

  /// No description provided for @minimumBookingValue.
  ///
  /// In bs, this message translates to:
  /// **'Minimalna vrijednost rezervacije'**
  String get minimumBookingValue;

  /// No description provided for @minimumNights.
  ///
  /// In bs, this message translates to:
  /// **'Minimalan broj noći'**
  String get minimumNights;

  /// No description provided for @usageLimitOptional.
  ///
  /// In bs, this message translates to:
  /// **'Limit korištenja (opcionalno)'**
  String get usageLimitOptional;

  /// No description provided for @percentageDiscount.
  ///
  /// In bs, this message translates to:
  /// **'Postotak'**
  String get percentageDiscount;

  /// No description provided for @fixedDiscount.
  ///
  /// In bs, this message translates to:
  /// **'Fiksni iznos'**
  String get fixedDiscount;

  /// No description provided for @couponDiscount.
  ///
  /// In bs, this message translates to:
  /// **'Kod kupona'**
  String get couponDiscount;

  /// No description provided for @promotionActive.
  ///
  /// In bs, this message translates to:
  /// **'Aktivna'**
  String get promotionActive;

  /// No description provided for @promotionInactive.
  ///
  /// In bs, this message translates to:
  /// **'Neaktivna'**
  String get promotionInactive;

  /// No description provided for @discountValueHint.
  ///
  /// In bs, this message translates to:
  /// **'npr. 10'**
  String get discountValueHint;

  /// No description provided for @promoCodeHint.
  ///
  /// In bs, this message translates to:
  /// **'npr. LJETO10'**
  String get promoCodeHint;

  /// No description provided for @promotion.
  ///
  /// In bs, this message translates to:
  /// **'Popust'**
  String get promotion;

  /// No description provided for @providerPrivacyPolicyContent.
  ///
  /// In bs, this message translates to:
  /// **'POLITIKA PRIVATNOSTI ZA PROVIDERE\n\nMultiBook obrađuje podatke o provider računu i businessu kako bi objavio i upravljao smještajem ili uslugama. To uključuje profil businessa, lokaciju, slike, cijene, dostupnost, zaposlenike, promocije, rezervacije, termine, zaradu i poruke s customerima.\n\n1. Podaci customera\nZa potvrđene rezervacije dobijate samo podatke potrebne za izvršenje smještaja ili usluge: ime, kontakt podatke, datume/vrijeme, odabranu uslugu i relevantne detalje rezervacije. Koristite ih isključivo za tu rezervaciju. Ne prodajete ih, ne dijelite bez pravne osnove i ne koristite za neželjeni marketing.\n\n2. Sigurnost i evidencije\nČuvajte pristup provider računu i ograničite pristup ovlaštenim zaposlenicima. Nikada ne tražite lozinke, CVV kodove ili pune podatke kartice putem chata. Poruke, recenzije, otkazivanja, no-show evidencije i transakcijski snapshoti mogu se čuvati radi podrške, sprečavanja prevara, sporova, finansijskog izvještavanja i zakonskih obaveza.\n\n3. Vaša prava\nPodatke businessa možete urediti kroz Upravljanje smještajima i uslugama. Za brisanje računa, pristup podacima ili pitanja o privatnosti kontaktirajte MultiBook podršku. Značajne izmjene politike objavit ćemo u aplikaciji.'**
  String get providerPrivacyPolicyContent;

  /// No description provided for @providerTermsOfServiceContent.
  ///
  /// In bs, this message translates to:
  /// **'USLOVI KORIŠTENJA ZA PROVIDERE\n\nUpravljanjem businessom na MultiBooku prihvatate ove uslove za providere. MultiBook nezavisnim businessima daje alate za objavu smještaja ili usluga, upravljanje dostupnošću i komunikaciju s customerima.\n\n1. Tačni oglasi\nPodaci o businessu, cijenama, dostupnosti, pogodnostima, zaposlenicima i uslugama moraju biti tačni. Ne objavljujte obmanjujuće slike, ponude ili dostupnost.\n\n2. Rezervacije i plaćanja\nPotvrđena rezervacija ili termin predstavljaju dogovor između businessa i customera. Ispunite ga osim u opravdanim izuzetnim okolnostima. Kontrole za odbijanje, otkazivanje, promjenu termina i cash no-show koristite tačno. Online i gotovinska plaćanja vode se odvojeno; odgovorni ste za poreze, račune, povrate i primjenjive zakonske obaveze.\n\n3. Ponašanje i mjere\nPodatke customera koristite samo za izvršenje rezervisanog smještaja ili usluge. Komunikacija mora biti profesionalna; zabranjeni su diskriminacija, uznemiravanje, spam, manipulacija recenzijama i preusmjeravanje plaćanja izvan odobrenih tokova. Možemo ograničiti oglase ili račune koji ugrožavaju korisnike ili zloupotrebljavaju platformu.\n\n4. Izmjene\nUslove možemo izmijeniti iz pravnih, sigurnosnih ili produktnih razloga. Nastavak korištenja nakon objave znači prihvatanje ažuriranih uslova.'**
  String get providerTermsOfServiceContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bs',
    'de',
    'en',
    'es',
    'fr',
    'it',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bs':
      return AppLocalizationsBs();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
