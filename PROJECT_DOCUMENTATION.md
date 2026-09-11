# MultiBook — projektna dokumentacija

## 1. Projekat i ideja

**MultiBook** je mobilna marketplace aplikacija za rezervaciju smještaja i termina za usluge. Aplikacija objedinjuje dva tržišta koja imaju sličan tok rezervacije, ali različita pravila dostupnosti:

- **Stays** — hoteli, apartmani, vile, kabine, vikendice, resorti i sličan smještaj.
- **Services** — frizerski i beauty saloni, stomatološke ordinacije, wellness, autoservisi, električari, edukatori i druge usluge koje se rezervišu u terminu.

Postoje dvije korisničke uloge:

- **Customer** pronalazi business, pregleda ponudu, filtrira rezultate, rezerviše smještaj ili termin, plaća, čuva favorite i komunicira s businessom.
- **Provider** (business owner) kreira i upravlja jednim ili više businessa, prati rezervacije/termine, upravlja dostupnošću i komunicira s customerima.

Ključna poslovna odluka je da razgovor i rezervacija pripadaju **businessu**, a ne samo provider korisniku. Jedan provider može imati više businessa, zato conversation i booking/appointment uvijek nose `businessId` i `businessOwnerId`.

---

## 2. Glavni korisnički tokovi

### Customer

1. Onboarding se prvi put prikaže i lokalno zapamti.
2. Customer se registruje email/password ili Google prijavom.
3. Nakon autentikacije bira tip računa; customer ide na customer home, provider na business home.
4. Pri ulasku na customer home aplikacija traži dozvolu za lokaciju i sprema adresu/grad u profil.
5. Customer bira **Stays** ili **Services**, pretražuje, filtrira, otvara detail, čuva business ili započinje rezervaciju.
6. Prekinuti booking/appointment tok može biti spremljen kao draft i kasnije nastavljen.
7. Nakon potvrđenog plaćanja nastaje booking ili appointment, prikazan je confirmation ekran i stavka se pojavljuje u *My bookings*.

### Provider

1. Provider kreira ili uređuje stay/service business, unosi lokaciju, slike, ponudu i dostupnost.
2. Nakon prvog businessa početni ekran postaje dashboard; selektovani business se čuva u user profilu.
3. Provider mijenja business na dashboardu / business selectoru, pregleda njegove bookinge ili appointmente i upravlja njima.
4. Iz **Manage Stays & Services** otvara puni, unaprijed popunjeni editor selektovanog businessa i sprema izmjene preko REST API-ja.
5. Za stays vidi zauzete dane; za services vidi zauzete i blokirane 30-minutne slotove po radniku.

---

## 3. Tehnološki stack

| Oblast | Tehnologija | Namjena |
|---|---|---|
| Mobilna aplikacija | Flutter / Dart | Jedan kod za iOS i Android |
| State management | `flutter_bloc` | Cubit/BLoC i eksplicitna UI stanja |
| Lokalni widget state | `flutter_hooks` | HookWidget/useEffect bez `setState` |
| Navigacija | `go_router` | Declarativne rute i auth/onboarding redirecti |
| DI | `get_it` + `injectable` | Registracija data sourcea, repozitorija i Firebase servisa |
| Modeli | `dart_mappable` | Tipizirani modeli i serializacija |
| Backend | Firebase Auth, Firestore, Storage, Functions, Messaging | Auth, baza, fajlovi, server-side pretraga i notifikacije |
| Cloud Functions | TypeScript, Node.js 22, Functions v2 | Trigger notifikacije, agregirane metrike i callable pretrage |
| Mape i lokacija | `google_maps_flutter`, `geolocator`, Nominatim preko `dio` | Pin na mapi, lokacija uređaja i besplatni reverse geocoding |
| Slike | `image_picker`, `flutter_image_compress` | Odabir i WebP kompresija prije Storage uploada |
| UI | Google Fonts, Flutter SVG, Cupertino, FL Chart | Dark dizajn, ikone, date picker i dashboard chartovi |
| Ostalo | Shared Preferences, country_picker, toastification, url_launcher | Cache, country code, toast poruke i otvaranje mapa |

Pune verzije paketa su u [pubspec.yaml](pubspec.yaml). Node dependencies i build skripte su u [functions/package.json](functions/package.json).

---

## 4. Arhitektura aplikacije

### 4.1 Slojevi

Projekt prati odvajanje odgovornosti:

```text
Presentation (View / Widget / Cubit-BLoC)
                  │
                  ▼
              Use case
                  │
                  ▼
        Repository contract
                  │
                  ▼
        Repository implementation
                  │
                  ▼
          Data source adapteri
                  │
                  ▼
         ApiClient / Firebase / lokalni cache
```

- **Presentation** prikazuje stanje i šalje korisničke akcije Cubit/BLoC-u. Nema direktnih Firebase poziva.
- **Use case** je obavezan ulaz u REST module. Svaki use case izlaže jednu tipiziranu operaciju kroz `execute()` i zavisi samo od repository ugovora; nalazi se u `src/domain/use_cases/<module>/`.
- **Repository contract** je u `src/domain/repositories/`, a njegova `Impl` klasa u `src/data/repositories/`. Implementacija koordinira data sourcee, dok use case ne poznaje HTTP detalje.
- **Data source** implementira adapter prema konkretnom backend resursu ili pluginu uređaja. HTTP adapter koristi zajedničku networking infrastrukturu umjesto da sam upravlja transportom.
- **Core networking** (`src/core/networking/`) sadrži transportne primitive koje nisu vezane ni za jedan feature: `ApiClient`, `SseClient` i `SseConnection`.
- **Models/enums** su eksplicitni i tipizirani. Feature-specifični modeli idu u `feature/domain/models`, a zajednički persisted modeli u `src/data/models`.

### 4.1.1 REST moduli i greške

REST migracija se uvodi modul po modul. Standardni tok za migrirani modul je:

```text
Cubit → Use case → Repository contract → RepositoryImpl → Data source → ApiClient
```

`users` je prvi migrirani REST modul. Njegov contract je `UsersRepository`, implementacija `UsersRepositoryImpl`, a HTTP endpointi su u `UsersApiDataSource`.

### 4.1.3 Customer drafts REST migracija

Customer booking i appointment draftovi koriste jedan `CustomerDraftsRepository` jer pripadaju istoj customer-drafts odgovornosti. Tok je striktno:

```text
CustomerDashboardCubit / draft Cubit → action-specific draft use case → CustomerDraftsRepository → CustomerDraftsRepositoryImpl → CustomerDraftsApiDataSource → ApiClient
```

`CustomerDraftsApiDataSource` koristi `GET`, `PUT` i `DELETE` endpoint-e pod `/v1/drafts/booking` i `/v1/drafts/appointment`. `ApiClient.delete` normalizuje Dio grešku u isti `ApiException` oblik kao `get`, `post`, `put` i `patch`.

- Svaki customer ima najviše jedan booking i jedan appointment draft.
- `GET` koji dobije `404` vraća `Success(null)`; dashboard zato ne prikazuje grešku kada draft ne postoji.
- Odgovori su camelCase-kompatibilni s postojećim `BookingDraftModel` i `AppointmentDraftModel`.
- `businessImageUrl` može biti Firebase Storage path ili direktni HTTPS URL. `FirebaseStorageDataSource.getDownloadUrl` prosljeđuje HTTPS URL bez dodatnog Firebase lookup-a.
- Nastavak appointmenta i bookinga učitava puni business agregat preko postojećeg REST `GetBusinessDetailUseCase`, a ne preko Firestore business dokumenta. Ako business više nije dostupan, UI prikazuje stanje greške umjesto beskonačnog loadera.

Očekivane REST greške ne putuju do Cubit-a kao `DioException` ili `ApiException`. `ApiClient` normalizuje Dio grešku u `ApiException`, a `RestRepositoryExecutor` iz `src/core/errors/` je centralno mjesto koje je mapira u `Result<T>` i `AppFailure`:

- `401` → `UnauthorizedFailure`
- `403` → `ForbiddenFailure`
- `400` i `422` → `ValidationFailure`
- `404` → `NotFoundFailure`
- timeout/network i nepoznati HTTP status → `NetworkFailure`
- `5xx` → `ServerFailure`
- neočekivana lokalna greška → `UnknownFailure`

Use case vraća `Success<T>` ili `FailureResult<T>`. Cubit grana po tom rezultatu i emituje odgovarajuće UI stanje; ne hvata exception za očekivani REST failure. Korisnički tekst ostaje u presentation/lokalizacijskom sloju, dok se tehnički detalji koriste samo za logovanje.

Svaka poslovna radnja ima vlastiti use case i vlastiti fajl: `GetBookingDraftUseCase`, `SaveBookingDraftUseCase`, `DeleteBookingDraftUseCase`, te ekvivalenti za appointment draft. Isti princip važi za create, list, cancel, availability i reschedule radnje; use case nije generički facade nad više nepovezanih akcija.

### 4.1.4 Customer stay bookings REST migracija

Customer stay booking read flow koristi poseban `CustomerBookingsRepository`, jer je odgovornost drugačija od checkout kreiranja i od customer draftova:

```text
CustomerBookingsCubit / CustomerBookingDetailsCubit / BookingDetailsCubit
        → GetCustomerBookingsUseCase / CancelCustomerBookingUseCase / GetStayAvailabilityUseCase
        → CustomerBookingsRepository
        → CustomerBookingsRepositoryImpl
        → CustomerBookingsApiDataSource
        → ApiClient
```

- `GET /v1/bookings` vraća samo booking-e prijavljenog customera i REST offset cursor (`nextCursor`); `CustomerBookingsCubit` više ne koristi Firestore `DataCursor` za stay tab.
- `PATCH /v1/bookings/{id}/cancel` vraća ažurirani `BookingModel`; detail Cubit njime zamjenjuje lokalnu stavku nakon uspješnog otkazivanja.
- `GET /v1/businesses/{id}/stay/availability` vraća samo `unavailableRanges`, bez tuđih booking detalja. Za multiple-unit stay šalje se `room_type_id`, a backend označava datum nedostupnim tek kada je kapacitet tog room typea popunjen.
- `BookingListResponse`, `StayAvailabilityResponse` i `StayUnavailableRange` su tipizirani REST response modeli; svaki model je u vlastitom fajlu. `BookingModel` ostaje zajednički persisted model.
- Customer stay lista, customer cancel i customer calendar availability nemaju Firestore fallback. Stari Firestore `BookingRepository` je uklonjen; provider booking i provider stay calendar koriste REST.

### 4.1.5 Customer service appointments REST migracija

Customer service tab, customer cancellation i reschedule koriste zaseban `CustomerAppointmentsRepository` i akcijski razdvojene use case-e:

```text
CustomerBookingsCubit / AppointmentDetailsCubit / RescheduleAppointmentCubit
        → GetCustomerAppointmentsUseCase / CancelCustomerAppointmentUseCase / RescheduleCustomerAppointmentUseCase
        → CustomerAppointmentsRepository
        → CustomerAppointmentsRepositoryImpl
        → CustomerAppointmentsApiDataSource
        → ApiClient
```

- `GET /v1/appointments` vraća samo appointment-e prijavljenog customera za customer poziv i koristi REST offset cursor (`nextCursor`), sa zasebnim cursorom od stay taba.
- `PATCH /v1/appointments/{id}/status` koristi se za customer cancellation, a `PATCH /v1/appointments/{id}/reschedule` vraća novi kompletni `AppointmentModel` nakon uspješne promjene.
- `AppointmentListResponse` je tipizirani paginirani response. Lista/status/reschedule REST odgovori već sadrže presentation podatke i offerings, pa nema Firestore business enrichment/fallbacka u customer service flowu.
- Calendar availability koristi `GET /v1/businesses/{businessID}/service/staff/{staffID}/available-slots` sa odabranim offering ID-evima. Backend iz PostgreSQL weekly availabilityja, ručnih blokada i potvrđenih appointmenta vraća samo bookable start minute; kod reschedule-a `exclude_appointment_id` zadržava mogućnost izbora trenutnog termina.
- Appointment details business učitava kroz `GetBusinessDetailUseCase`, a dashboard gradove kroz `GetDiscoveryCitiesUseCase`; oba toka koriste customer discovery REST API.

### 4.1.6 Reviews REST migracija

Kreiranje, provjera i prikaz recenzija koriste zaseban Reviews modul:

```text
RateBusinessCubit / detail Cubit / BusinessReviewsSheet
        → CreateReviewUseCase | HasBusinessReviewUseCase |
          GetBusinessReviewsUseCase
        → ReviewsRepository
        → ReviewsRepositoryImpl
        → ReviewsApiDataSource
        → ApiClient
```

- `POST /v1/businesses/{businessId}/reviews` prihvata source ID/tip, rating i opcionalni komentar. Backend iz rezervacije ili termina određuje customera, business ownera i snapshot prikazne podatke.
- `GET /v1/businesses/{businessId}/review-status` provjerava da li je prijavljeni customer već ocijenio business.
- `GET /v1/businesses/{businessId}/reviews` vraća newest-first offset stranice; detail preview traži 4 stavke, a *All reviews* učitava stranice po 20.
- I dalje vrijedi pravilo jedne recenzije po customeru i businessu, ne po pojedinačnoj rezervaciji. Izvor mora pripadati calleru i businessu te biti završen.
- PostgreSQL čuva Storage path avatara; `ReviewsApiDataSource` ga razrješava u download URL samo za prikaz.
- Flutter nema Firestore ni callable fallback za recenzije. Postojeći `createReview` Cloud Function i Firestore pravila ostaju u projektu, ali ih migrirani Flutter flow više ne koristi.

### 4.1.7 Dashboard metrics REST migracija

Provider dashboard koristi zaseban live Metrics tok:

```text
DashboardCubit → WatchDashboardMetricsUseCase → DashboardMetricsRepository
        → DashboardMetricsRepositoryImpl → DashboardMetricsApiDataSource
        → ApiClient SSE
```

- `GET /v1/businesses/{businessId}/dashboard-metrics/stream` odmah šalje kompletan snapshot i zatim novi snapshot nakon svake commitane promjene rezervacije.
- Flutter koristi jedan SSE subscription umjesto odvojenih Firestore summary i current-month subscriptiona. Stream se registruje u `SessionStreamRegistry` i automatski reconnecta s ograničenim exponential backoffom.
- `DashboardMetrics` i zasebni `DashboardMetricsMonth` model koriste `dart_mappable`; iznosi s API-ja ostaju u minor units sve do zajedničkog currency formattera koji ih pretvara u decimalni prikaz.
- Dashboard više ne čita `business_metrics` Firestore dokumente niti poziva metrics callable initializer.
- Firebase metrics Functions i pravila ostaju u projektu kao legacy infrastruktura; Flutter dashboard ih više ne koristi.

### 4.1.8 Earnings REST migracija

Provider Earnings koristi isti generički SSE transport kao dashboard, ali zaseban domenski tok:

```text
EarningsView → EarningsCubit → WatchEarningsMetricsUseCase
        → EarningsMetricsRepository → EarningsMetricsRepositoryImpl
        → EarningsMetricsApiDataSource → SseClient → ApiClient
```

- `GET /v1/businesses/{businessId}/earnings/stream` prima inkluzivni `startDate`/`endDate` raspon, lokalni `utcOffsetMinutes` i opcionalni `staffId`, odmah šalje rezultat i osvježava ga nakon commitane promjene rezervacije. Offset uređaja određuje granice kalendarskog dana/sedmice/mjeseca, tako da lokalni period ne zavisi od UTC datuma.
- Datum se primjenjuje na `created_at`: prihod pripada momentu kreiranja rezervacije, bez obzira kada će se termin ili boravak desiti.
- Potvrđeni i završeni cash booking ulazi odmah; no-show/status promjena ga izuzima. Online booking ulazi tek kada je `payment_status=paid`.
- `EarningsCubit` upravlja aktivnim businessom, periodom, provider filterom i SSE subscriptionom. Widget ne poziva use case direktno.
- API i Flutter koriste minor units za ukupni, online, cash i historijski provider iznos. Konverzija u decimalni prikaz dešava se samo u zajedničkom currency formatteru.
- Flutter Earnings više nema Firestore repository/data source niti čita `business_metrics` kolekciju. Postojeće Firebase aggregate funkcije i pravila ostaju samo kao legacy infrastruktura dok se zasebno ne uklone.

### 4.1.2 Businesses REST migracija

Provider business modul koristi postojeći `BusinessModel` i njegov `dart_mappable` `toMap`/`fromMap`; za REST se ne uvode posebni `CreateBusinessInput`, `CreatedBusiness` ili slični transport modeli.

```text
AddBusinessBloc / provider Cubit
        → CreateBusinessUseCase | GetOwnedBusinessesUseCase |
          GetOwnedBusinessUseCase | UpdateBusinessUseCase
        → BusinessesRepository
        → BusinessesRepositoryImpl
        → BusinessesApiDataSource
        → ApiClient
```

- `GET /v1/businesses` vraća samo lagane sažetke za *My Businesses*, tabove i business selector. `GetOwnedBusinessesUseCase` ih cacheira i sprečava paralelne identične zahtjeve.
- `GET /v1/businesses/{id}` vraća puni owner-only aggregate i poziva se samo kad provider otvori **Manage Stays & Services** editor. Zato se pri saveu ne izgube `amenities`, `extras`, rooms, offerings ili staff koji nisu dio summary odgovora.
- `POST /v1/businesses` i `PUT /v1/businesses/{id}` primaju `BusinessModel.toMap()` i vraćaju puni `BusinessModel`. `PUT` je potpuna zamjena editabilnog aggregata, ne parcijalni update.
- Firebase ostaje samo za Auth i Storage. PostgreSQL čuva Firebase Storage path; `BusinessesApiDataSource` download URL koristi samo za prikaz i prije REST `PUT` ga normalizuje nazad u Storage path.

### 4.1.3 Customer discovery i development seed

Customer home **Popular Near You** više ne koristi Firestore cursore. `CustomerDashboardCubit` preko `GetPopularNearbyBusinessesUseCase` poziva `GET /v1/discovery/businesses` s parametrima `type` (`stays` ili `services`), `city`, `limit` i `offset`. Odgovor ostaje `BusinessModel`-kompatibilan, a postojeći UI zadržava paginaciju i *load more* ponašanje.

Customer **Explore** također ne čita Firestore business kolekciju: izbor grada koristi `GET /v1/discovery/cities`, koji čita trajni deduplicirani katalog gradova popunjen pri svakom upisu business lokacije, a *Trending near you* koristi isti paginirani `GET /v1/discovery/businesses` za `type=services`. Kategorijski i collection rezultati ostaju na server-side `GET /v1/stays/search` i `GET /v1/services/search` rutama.

Featured stay i service collections koriste `GET /v1/discovery/featured-collections`. PostgreSQL čuva redoslijed, ID i image URL, dok backend vraća postojeće l10n ključeve pa Flutter zadržava prijevode za sve podržane jezike.

**Recommended for you** koristi `GET /v1/discovery/recommended-stays`, a ne Firestore. Backend vraća do tri staya, prioritizira korisnikov spremljeni grad i preostala mjesta popunjava globalnim rankingom po ratingu i broju recenzija.

Development-only seed akcije u Add Business ekranu koriste `DevelopmentSeedUseCase` i REST endpoint-e `POST /v1/development/seed/stays` i `POST /v1/development/seed/services`. Seed media koristi direktne HTTPS URL-ove za demo kartice; Firebase Storage se ne poziva za te slike.

### 4.2 Struktura direktorija

```text
lib/
 ├─ main.dart                         # inicijalizacija DI-ja i aplikacije
 ├─ app.dart                          # MaterialApp, router i inicijalizacija notifikacija
 ├─ src/
 │   ├─ core/                         # konfiguracija, tema, DI, session lifecycle i shared errors
 │   ├─ domain/                       # use caseovi i repository ugovori
 │   ├─ data/
 │   │   ├─ data_sources/             # Firebase/HTTP/plugin adapteri
 │   │   ├─ repositories/             # repository implementacije
 │   │   ├─ models/ i enums/          # shared persisted modeli
 │   ├─ features/
 │   │   ├─ customer-side/            # customer featurei
 │   │   ├─ business-side/            # provider featurei
 │   │   └─ shared/                   # auth, chat, onboarding, notifikacije, lokacija
 │   ├─ global_widgets/               # reusable app bar, button, text field, picker
 │   └─ router/                       # AppRoutes i GoRouter stranice
 └─ utils/                            # npr. image compression

functions/src/
 ├─ notifications/                    # Firestore trigger notifikacije i dispatch
 ├─ metrics/                          # agregati zarade i KPI metrika po businessu
 ├─ stays/                            # modularni callable stay search
 └─ services/                         # modularni callable service search
```

### 4.3 Pravila implementacije

- Ne koristiti `setState`; za lokalne interakcije koristiti `HookWidget`, `useState`, `useEffect` ili Cubit stanje.
- Ne stavljati privatne pomoćne UI klase u veliki view fajl. Svaki custom widget ima svoj fajl u `presentation/widgets`.
- Feature modeli/enumi nisu u presentation fajlovima; idu u `domain/models` ili `domain/enums`.
- Svaki model ima vlastiti fajl i koristi `dart_mappable`; ručni `fromMap`, `toMap` i više model-klasa u jednom fajlu nisu dozvoljeni.
- Novi REST repository koristi `RestRepositoryExecutor`; ne kopirati HTTP-to-failure mapping u pojedinačne `RepositoryImpl` klase.
- Novi REST Cubit prima use case, a ne `RepositoryImpl`, `DataSource` ili `ApiClient`.
- Globalno ponovljive komponente su u `src/global_widgets`: `CustomAppBar`, `CustomButton`, `CustomTextfield`, `SearchableCityPickerSheet` i `LabeledDivider`.
- Light/dark teme i boje dolaze iz `AppTheme`, `AppPalette` i stabilnih brand/status vrijednosti u `AppColors`, ne iz nasumičnih hardkodiranih neutralnih boja u viewu.

---

## 5. Navigacija i ulaz u aplikaciju

`GoRouter` koristi tri zaštitna nivoa:

1. **Onboarding**: dok `has_seen_onboarding` nije postavljen u Shared Preferences, korisnik ostaje na `/onboarding`.
2. **Autentikacija**: neprijavljen korisnik ide na `/sign-in`. `GoRouter` prati Firebase Auth stanje preko `refreshListenable`, pa se zaštićene rute odmah uklanjaju nakon odjave. Nakon uspješnog sign-ina `SigninCubit` eksplicitno bira Home ili User Type Checker, kako novi Google/email account ne bi preskočio izbor tipa korisnika.
3. **Tip korisnika i entry screen**: user profil određuje customer/provider tok. Provider entry dodatno provjerava ima li business i otvara Add Business ili dashboard.

Sve rute su centralizovane u [lib/src/router/app_routes.dart](lib/src/router/app_routes.dart) i [lib/src/router/app_pages.dart](lib/src/router/app_pages.dart).

---

## 6. Dizajn sistema

- Aplikacija ima light i dark UI. Light ekrani koriste zelenkasto-tirkizni gradient iz `AppPalette`, koji `AppBackground` dodaje na nivou svake rute kako bi pozadina i sadržaj učestvovali u istoj navigacijskoj tranziciji. Kartice i forme ostaju pune surface boje, a podignuti bottom navigation koristi zasebnu `navigationSurface` boju usklađenu s gradientom. Dark pozadina ostaje jednobojna. Foreground, muted tekst i ostali borderi također dolaze iz theme-aware `AppPalette`, dok ljubičasti accent i status boje ostaju centralizovani u `AppColors`.
- Customer i provider kroz **Settings → Appearance** mogu odmah uključiti ili isključiti light temu. `ThemeCubit` mijenja `MaterialApp.themeMode`, a `ThemeRepositoryImpl` odabir trajno sprema u Shared Preferences; zadnja tema se vraća pri sljedećem pokretanju aplikacije.
- Selektovana stanja koriste primarnu ljubičastu; statusi koriste semantičke boje (confirmed, cancelled/declined, completed).
- Customer i provider home tokovi koriste `persistent_bottom_nav_bar_v2` `PersistentTabView` sa zajedničkim Instagram-style `InstagramBottomNavigation` prikazom. Navigacija je floating pill bez labela i indikatorske linije, a jedan selekcijski segment animirano klizi između tabova. Tab sadržaj se mijenja trenutno, bez horizontalne tranzicije ekrana. Pri vertikalnom scrollu prema dnu cijeli bar se blago smanjuje, a pri scrollu prema vrhu vraća punu veličinu; horizontalni scroll ne mijenja bar. Svaki tab zadržava vlastiti navigation stack i stanje, dok postojeći `GoRouter` i dalje upravlja aplikacijskim rutama izvan tabova. Root tabovi ne rezervišu donji `SafeArea`, pa se pozadina i scroll sadržaj protežu do dna i prolaze ispod navigation overlaya.
- Globalni `CustomAppBar` standardizira centrirani naslov, Cupertino back strelicu i border pri dnu.
- Forme koriste zajednički `CustomTextfield` i `CustomButton`; validacije, disable stanje i loading ostaju konzistentni.
- Feedback za sačuvane stavke koristi `toastification`, pozicioniran pri dnu i horizontalno centriran.

---

## 7. Autentikacija, profil i lokacija

### Autentikacija

- Email/password sign-up i sign-in preko Firebase Authentication.
- Google Sign-In je integrisan kroz `google_sign_in` i Firebase credential.
- Prilikom registracije se kreira Firestore dokument u `users/{uid}`.
- Ako kreiranje profila ne uspije nakon email sign-upa, aplikacija uklanja nepotpun Firebase Auth account da ne ostane nekonzistentan korisnik.
- Logout koristi replacement navigaciju (`context.go`) na sign-in, bez vraćanja na dashboard u navigation stacku.
- `AuthenticationRepository` izlaže Firebase `authStateChanges` kroz router notifier. Time auth redirect reaguje na stvarno Firebase stanje, a ne na zakašnjeli UI callback.

### Session stream lifecycle

Autentificirani Firestore i SSE streamovi nakon Firebase Auth odjave više nemaju važeći pristup. Zato aplikacija ne prepušta zatvaranje streamova slučajnom redoslijedu rebuilda i navigacije:

1. Root view odmah zamijeni trenutnu rutu sa sign-in ekranom.
2. `AuthenticationRepository.signOut()` poziva `SessionStreamRegistry.cancelAll()` **prije** `FirebaseAuth.signOut()`.
3. Registry otkazuje aktivne, autentikacijom vezane pretplate, uključujući dashboard/Earnings SSE i chat unread indikatore.
4. Dok je session u završavanju, registry odmah otkazuje svaku pretplatu koju neki sporiji async `load()` pokuša otvoriti.
5. Tek nakon toga briše se notification device registracija i poziva Firebase sign-out.

Ovaj redoslijed sprečava `cloud_firestore/permission-denied` race condition i `Cannot emit new states after calling close` greške pri prelazu između prijavljenog i neprijavljenog stanja. Cubiti/BLoC-i dodatno provjeravaju `isClosed` / `emit.isDone` poslije async granica.

### User model

`UserModel` sadrži identitet, `UserType` (`provider`/`customer`), `selectedBusinessId`, telefon, avatar, country code, datum rođenja, adresu i grad. Provider se inicijalno može postaviti kao default, a *User Type Checker* eksplicitno bira customer/provider tok za nov account.

### Lokacija

- `geolocator` traži runtime permission na customer home ulazu.
- Koordinate se reverse-geocodeuju preko Nominatim/OpenStreetMap endpointa, bez plaćenog Google Geocoding API-ja.
- Grad i adresa se spremaju u user profil i koriste za **Popular near you** / **Trending near you**.
- Business lokacija se bira na Google mapi; klik na *Open in Maps* koristi `url_launcher` za vanjsku Google Maps aplikaciju.

---

## 7.1 Lokalizacija

Lokalizacija koristi Flutterov službeni `gen-l10n` mehanizam, bez dodatnog third-party localization sloja:

- ARB katalozi: `lib/l10n/app_{bs,en,de,es,fr,it}.arb`.
- Generisani, tipizirani API: `AppLocalizations`; UI mu pristupa kroz `context.l10n` ekstenziju.
- Bosanski (`bs`) je početni i fallback jezik. Podržani su i engleski (`en`), njemački (`de`), španski (`es`), francuski (`fr`) i italijanski (`it`).
- `LocaleRepository` sprema odabrani kod jezika u SharedPreferences, a globalni `LocaleCubit` odmah mijenja `MaterialApp.locale` bez restarta aplikacije.
- Izbor jezika je dostupan na customer Profile i provider More ekranima. iOS `Info.plist` eksplicitno navodi `bs` i `en`.

Novi tekst uvijek treba dodati u sve ARB fajlove, zatim pokrenuti:

```bash
flutter gen-l10n
```

Ne treba hardkodirati korisnički vidljiv tekst u novim widgetima. Za dinamički tekst koristiti ICU plural/select poruke u ARB-u, posebno za goste, noći, slotove, cijene i statuse.

---

## 8. Business domen

`BusinessModel` je zajednički entitet za oba tržišta:

- identitet i vlasništvo: `id`, `ownerId`, `type`;
- sadržaj: naziv, kategorija, opis, lokacija, logo, cover i do sedam dodatnih slika;
- discovery: aktivnost, prosječna ocjena, broj recenzija i `featuredCollectionIds`;
- promotion signal: `isPromotionActive` je lagani discovery indikator za badge na karticama; puni promotion podaci se ne dupliciraju u business dokumentu;
- tip-specifični podaci: `stayDetails` ili `serviceDetails`.

### 8.1 Stays

Podržane kategorije: hotel, apartment, cabin, villa, beach villa, mountain cabin, cottage/weekend house, pool villa, resort, guesthouse, hostel, aparthotel, glamping i vacation home.

Stay može biti:

- **single unit** — npr. jedna vila/apartman; booking zauzima cijeli business za datume;
- **multiple units** — hotel/aparthotel ili bilo koji business s više jedinica; room modeli nose cijenu i raspoloživost.

Stay detalji sadrže cijenu po noći, rooms, amenities i optional extras. Dostupni amenityji uključuju Wi‑Fi, parking, pool, spa, pet-friendly, gym, kuhinju, balkon, pogled, ski-in/ski-out, ski storage/rental/shuttle i druge. Extras imaju cijenu i jedinicu naplate (po noći, jednokratno ili po satu), npr. breakfast, transfer, parking, quad bike rental, boat tour i local guide.

Stay collections bira provider jer isti hotel može imati smisla u više kolekcija:

`romantic_getaways`, `family_friendly`, `weekend_escapes`, `beachfront_stays`, `pet_friendly`, `pool_stays`, `mountain_escapes`, `city_breaks`.

### 8.2 Services

Podržani su hair/barber/beauty/nail saloni, dentalne i medicinske ordinacije, physiotherapy, masaža/spa, treneri, edukacija, electrician/plumber/cleaning, automotive, detailing, tattoo, veterina, photo/video, locksmith, HVAC, painter/decorator, legal/accounting i ostale profesionalne usluge.

Service business sadrži:

- listu **service offerings** (naziv, trajanje, cijena, add-ons);
- jednog ili više **provider/staff** članova;
- availability slotove po provideru;
- automatski dodijeljene service featured collections na osnovu kategorije.

Kolekcije su `wellness_spa`, `beauty_grooming`, `home_repairs`, `auto_services`, `health_care`, `learn_grow`, `pet_care` i `professional_services`. Provider ih ne bira ručno, što sprječava nelogične kombinacije kategorije i kolekcije.

### 8.3 Dodavanje businessa

Add Business feature koristi BLoC, zasebne widgete za formu, medije, stay jedinice, service ponude, osoblje i slotove. Slike se biraju iz galerije/kamere, kompresuju i uploaduju u Firebase Storage; nakon toga se kompletan postojeći `BusinessModel` šalje na Go REST API, koji ga trajno upisuje u PostgreSQL.

Razvojni seed metod puni bazu realističnim stay i service podacima (različiti gradovi, kategorije, cijene, rating, slike, rooms, extras, staff i ponuda). Seed je samo za development/testiranje i ne treba biti dostupan u produkcijskom UI-ju.

### 8.4 Upravljanje i uređivanje businessa

**Manage Stays & Services** nije zaseban, ograničen katalog editor. Lista/selector prvo koriste lagani `GET /v1/businesses` summary. Kada provider otvori editor, `AddBusinessBloc` poziva `GET /v1/businesses/{id}` i tek iz punog REST aggregata popunjava isti **Add Business** obrazac u edit modu. Time create i update dijele istu validaciju, strukturu forme i `BusinessModel`, a nepotrebni detaljni request se ne radi za svaki business u listi.

- Formu unaprijed popunjavaju naziv, kategorija, grad/adresa, koordinate, opis, inventory tip, cijena, amenities, extras i njihove cijene, featured collections, ponude, zaposlenici, provizije i availability slotovi.
- Za multiple-unit stay provider može uređivati, dodavati i uklanjati više bookable room/unit stavki. Svaka stavka nosi naziv, kapacitet, kvadraturu, cijenu po noći, količinu i aktivnost.
- Service business zadržava uređivanje kompletne liste offeringsa i provider/staff članova zajedno s njihovim slotovima i commission rate-om.
- Tip businessa je zaključan tokom izmjene kako postojeći stay/service dokument ne bi promijenio domenski tip i ostavio nekonzistentne rezervacije ili appointmente.
- Postojeći logo, cover i `photoUrls` se prikažu kao mrežne slike i ne uploaduju se ponovo. Firebase download URL je UI-only vrijednost: prije `PUT` se normalizuje u trajni Storage path, koji Go API sprema u PostgreSQL. Galerija ostaje ograničena na najviše sedam dodatnih slika.
- Update zadržava identitet businessa, ownera, valutu, rating, broj recenzija, aktivno stanje i `isPromotionActive`; REST `PUT` zamjenjuje editabilni business aggregate. Zbog toga editor uvijek prvo fetch-a puni detail, umjesto da šalje nepotpun list summary.

### 8.5 Promotions & Discounts

Provider za pojedinačni business upravlja promocijama kroz **Promotions & Discounts** feature. Promotion je zaseban dokument u `promotions` kolekciji i sadrži business/vlasnika, naziv, tip, vrijednost, period važenja, opcionalni promo kod, minimum iznosa, stay-only minimum noći, usage limit i aktivno stanje.

- Tipovi su `percentage`, `fixedAmount` i `couponCode`. Coupon code koristi definisanu procentualnu vrijednost tek nakon ispravnog unosa koda.
- Nakon create, activate/deactivate ili delete akcije repository ažurira samo `business.isPromotionActive`. Time kartice mogu odmah prikazati dijagonalni **Popust** banner bez čitanja kompletne promotion definicije za svaki business u feedu.
- Automatski percentage/fixed popust se učitava u review/payment toku. Coupon se server-side ponovo validira pri potvrdi plaćanja; nepostojeći ili istekao kod zaustavlja kreiranje rezervacije.
- Popust se računa nad stay subtotalom (room + extras) odnosno appointment service subtotalom, prije service fee i poreza. Kod staya se provjerava i minimalan broj noći; appointment nema minimum-nights pravilo.
- Review, payment, confirmation i details ekrani prikazuju popust i umanjeni total. Payment/confirmation prikaz dodatno koristi precrtanu izvornu vrijednost gdje je relevantno.
- Snapshoti se čuvaju uz rezultat transakcije: booking ima `discountAmount` i `originalTotal`, a appointment ima `originalServiceCost` i `discountAmount`. Stare rezervacije bez tih polja sigurno koriste postojeći total kao fallback.

---

## 9. Customer featurei

### Home / Dashboard

- Tabovi **Stays** i **Services**.
- Direktno Firestore učitavanje bez aktivnih filtera.
- Recommended stays, popular/trending businessi u customerovom gradu, horizontalni scroll i cursor paginacija.
- Quick filter chipovi ostaju vidljivi kad se prikažu rezultati, kako kontekst pretrage ne nestaje.
- Kartice otvaraju odgovarajući stay/service detail.

### Search i filters

- Debounce sprječava Firestore request na svako upisano slovo.
- Pretraga podržava naziv businessa i grad.
- Stay filteri: check-in/check-out, broj gostiju, grad, raspon cijene, rating i amenityji.
- Service filteri: datum, vrijeme u 30-minutnim koracima, kategorija businessa, grad, raspon cijene i sortiranje.
- Ako nema aktivnih filtera, home koristi discovery feed. Ako su stay filteri aktivni, `StaySearchDataSource` koristi autentificirani `GET /v1/stays/search` Go endpoint; Flutter šalje samo vrijednosti koje je korisnik stvarno odabrao, uz tehničke pagination parametre. Time se kombinovano filtriranje i availability izvršavaju server-side bez preuzimanja kandidata na uređaj.

### Stay detail i booking

- Hero galerija prikazuje cover kao prvu sliku, zatim `photoUrls`; broj page indikatora odgovara stvarnom broju slika.
- Prikazani su cijena, ocjene, lokacija i mapa, rooms, amenities, extras, opis i recenzije.
- Ako customer ne odabere room type, flow koristi default jedinicu/cijenu businessa gdje je to dozvoljeno.
- Booking details bira raspon datuma (ponedjeljak je prvi dan sedmice), goste i provjerava dostupnost.
- Review stay bira extras i izračunava room subtotal, cleaning/service fee, taxes i total. Ako business ima aktivnu promociju, review/payment koriste umanjeni subtotal, jasno prikazuju popust i sniženi ukupni iznos.
- Payment podržava karticu, Apple Pay, Google Pay i **plaćanje gotovinom**. Kartica validira format broja, expiry i 3-cifreni CVV; gotovina ne traži kartične podatke.
- Booking se kreira kao `confirmed`; mogući statusi su `confirmed`, `declined`, `cancelled`, `completed` i `noShow`.
- Customer može otkazati booking; providerovo odbijanje je `declined`, customerovo otkazivanje je `cancelled`.
- Za gotovinske rezervacije business odmah vidi očekivanu zaradu. Nakon isteka termina provider može označiti `noShow`; iznos se tada uklanja iz zarade, cash/online podjele, broja rezervacija i chart agregata.

### Service detail i appointment

- Detail prikazuje galeriju, kategoriju, ocjenu, mapu, service offeringe, cijene/trajanja, opis i staff.
- Customer može odabrati više usluga; ukupno trajanje određuje koliko susjednih 30-minutnih slotova mora ostati slobodno.
- Dostupnost se provjerava po konkretnom provideru; zauzeti ili blokirani slotovi nisu selektabilni.
- Review appointment prikazuje odabrane usluge i add-ons; special requests su namjerno izbačeni iz sadašnjeg flowa. Aktivni popust se prikazuje prije payment koraka, a konačni obračun se ponovo validira pri kreiranju appointmenta.
- Payment kreira `confirmed` appointment i atomarno zauzima njegove slotove. Dostupni su kartica, Apple Pay, Google Pay i gotovina.
- Appointment detail prikazuje business, izvođača, usluge, datum/vrijeme, cijene, payment metodu i confirmation code.
- Customer može otkazati appointment i može ga rescheduleati samo jednom; provider može rescheduleati bez tog ograničenja. Past cash appointment može biti označen kao `no_show` kada customer ne dođe.

### Draftovi

- REST `GET /v1/drafts/booking` i `PUT /v1/drafts/booking` čuvaju i vraćaju prekinuti stay flow za trenutno prijavljenog customera.
- REST `GET /v1/drafts/appointment` i `PUT /v1/drafts/appointment` čuvaju i vraćaju odabrane usluge, providera, datum, slotove i add-ons service flowa.
- REST `DELETE` endpointi brišu odgovarajući draft nakon uspješne potvrde plaćanja.
- Pri napuštanju flowa prikazuje se odluka da se draft sačuva ili odbaci.
- Draft vraća označene datume, slotove i extras/add-ons pri nastavku.

### My Bookings, Saved, Profile i Explore

- **My bookings** razdvaja stays i services na upcoming/past. Oba taba učitavaju REST stranice sa zasebnim cursorima i lokalno se osvježavaju nakon REST cancel/reschedule akcija; customer tabovi nemaju Firestore fallback.
- **Saved** koristi Go REST za spremanje, uklanjanje, provjeru i listanje korisnikovih businessa. Lista prikazuje aktuelne podatke za smještaje i servise, a lokalni broadcast odmah osvježava listu i stanje srca nakon uspješne promjene. Animirano uklanjanje, toast feedback i optimistic UX ostaju sačuvani.
- **Profile/Edit Profile** omogućava avatar, puno ime, telefon sa country pickerom, datum rođenja preko Cupertino pickera, adresu i grad.
- **Contact us** koristi zaseban Support Tickets feature, a ne customer-business chat. Customer kreira ticket s kategorijom, naslovom i porukom te vidi samo vlastite tickete i njihove statuse (`open`, `inProgress`, `resolved`).
- Ticketi se čuvaju u Supabase `support_tickets` tabeli i dostupni su samo kroz customer-only `GET/POST /v1/support-tickets`. Backend izvodi customer identitet, ime, email i početni `open` status iz autentificiranog profila; Flutter šalje samo kategoriju, naslov i poruku. Lista se osvježava pri otvaranju i nakon uspješnog kreiranja, bez Firestore fallbacka, streama ili pollinga. Status kasnije mijenja interni support/admin alat.
- **Explore** ima odvojene stay/service prikaze, izbor grada uključujući *All cities*, browse-by-category, kolekcije, top/trending poslovanja i recently viewed. Dinamički discovery/search podaci dolaze s Go endpointa, bez Firestore fallbacka.
- Recently viewed se sprema po useru i businessu preko `PUT /v1/recently-viewed/{businessID}`, a stay/service liste čitaju `GET /v1/recently-viewed`. Backend zadržava najviše 30 referenci po useru i pri čitanju vraća aktuelne business podatke, bez Firestore fallbacka ili dupliciranja kartica. Nakon uspješnog REST upisa, `RecentlyViewedUpdatesService` šalje lokalni broadcast signal aktivnim Recently Viewed cubitima da osvježe listu; nema socket konekcije ni periodičnog pollinga.
- Rezultati kategorije/kolekcije koriste cursor paginaciju.

---

## 10. Provider featurei

### Dashboard, earnings i business management

- Dashboard prikazuje selektovani business, aktivne bookinge/appointmente, zaradu u tekućem mjesecu, prosječni rating i FL Chart trendove iz PostgreSQL snapshot metrika koje dobija kroz SSE.
- Earnings prikazuje ukupnu mjesečnu zaradu, odvojeno **online** i **cash** earnings, te trend prihoda i volumena rezervacija.
- Earnings period filter podržava: current week, past week, this month, past month, this year, last year i custom raspon. Custom početni/završni datum se bira u Cupertino date pickeru.
- Kod service businessa Earnings omogućava i izbor zaposlenika. Prikazuju se **gross earnings** (ukupna vrijednost njegovih appointmenta) i **provider earnings** (njegova ugovorena provizija), uz trend prihoda i broj appointmenta za odabrani period.
- Svaki zaposlenik ima `commissionRate` (podrazumijevano 100%). Pri kreiranju appointmenta spremaju se historijski snapshoti `providerCommissionRate` i `providerEarnings`, pa kasnija promjena provizije ne mijenja ranije obračune.
- Go backend računa owner-only earnings projekciju direktno iz indeksiranih PostgreSQL rezervacija. Dnevni gross/provider iznosi omogućavaju week i custom filtere bez čitanja pojedinačnih appointmenta na mobilnoj strani.
- Za djelimične mjesece (sedmica i custom period) API vraća samo dnevne vrijednosti unutar inkluzivnog odabranog raspona, uključujući zasebne daily online i cash earnings, pa podjela ostaje tačna.
- Cash rezervacija/appointment ulazi u earnings odmah pri potvrdi kao očekivani prihod. No-show je dostupan samo provideru, samo za završeni cash termin/rezervaciju sa statusom `confirmed` ili `completed`; uz akciju se prikazuje objašnjenje o uticaju na metrike.
- Dashboard i Earnings metrike backend računa iz indeksiranih PostgreSQL reservation redova, bez kopirane aggregate tabele i inicijalizacijskog poziva. Firestore `business_metrics` dokumente migrirani Flutter flow više ne čita.
- `selectedBusinessId` u user dokumentu je jedini izvor aktivnog businessa i promjene se reaktivno reflektuju na dashboard i booking ekran.
- Ako provider nema businessa, dashboard prikazuje empty state i *Add new business* akciju.
- *My Businesses* lista podržava dodavanje, biranje aktivnog businessa i swipe-to-delete sa animacijom kartice bez reloadanja cijelog ekrana.
- Swipe-to-delete poziva `DELETE /v1/businesses/{businessID}` kroz zaseban `DeleteBusinessUseCase`; Flutter više ne briše business ni povezane podatke direktno iz Firestorea.

### Provider bookings i appointments

- Bookings ekran i provider stay calendar koriste `ProviderBookingsRepository` REST sloj za selektovani business, status filtere i cursor paginaciju; nemaju Firestore booking fallback.
- Manage Booking prikazuje customera, room, datume, goste, cijenu, završavanje i odbijanje. Kod past cash stavki nudi i No-show akciju sa hintom o uklanjanju iz earnings metrika.
- Service appointment kartice imaju Manage akciju za customer detalje, završavanje, cancel, reschedule, kontakt i No-show za past cash termine.
- Provider cancel rezultira statusom `declined`; customer cancel rezultira `cancelled`.

### Availability & Calendar

- Provider service calendar čita i mijenja ručne blokade kroz `/v1/businesses/{businessID}/service/staff/{staffID}/availability-blocks`.
- Svaki REST poziv prolazi kroz action-specific use case, `ServiceAvailabilityRepository` ugovor, implementaciju, API data source i `ApiClient`.
- Blokade su PostgreSQL vremenski rasponi; Flutter zadržava postojeći UX 30-minutnog block/unblock slota.

- Prikaz zavisi od tipa selektovanog businessa.
- **Stays:** zauzeti datumi se generišu iz potvrđenih bookinga; multiple-unit business može imati više bookinga istog dana.
- **Services:** odabirom dana prikazuju se slobodni, zauzeti i ručno blokirani 30-minutni slotovi po provideru.
- Klik na zauzeti appointment može otvoriti overlay s customer avatarom, imenom, emailom, telefonom i contact akcijom.
- Provider može ručno blokirati slobodan slot ili ga kasnije odblokirati. Blokovi su odvojeni dokumenti kako ne nose privatne customer podatke.

### More i account settings

- More grupiše business management, financijske placeholder sekcije, komunikaciju i settings.
- Stvarni unread indikator za Messages ne koristi dummy vrijednost.
- Account settings podržava izmjenu osnovnog profila, avatar upload i password/security akcije.

---

## 11. Chat i komunikacija

Chat je shared feature između customera i konkretnog businessa:

- Jedinstven conversation je deterministički vezan za business i customera.
- PostgreSQL tabele `chat_conversations`, `chat_participant_state` i `chat_messages` su jedini aktivni source of truth; Flutter nema Firestore fallback i ne pristupa Supabaseu direktno.
- Tok je `Cubit → action-specific use case → ChatRepository → ChatRepositoryImpl → ChatApiDataSource → ApiClient/SseClient`.
- REST rute pod `/v1/conversations` otvaraju conversation, listaju conversatione i poruke, šalju idempotentnu poruku s client-generated UUID-em te ažuriraju read, typing i presence stanje.
- `/v1/chat/stream` šalje samo `chat_sync` i participant-scoped `chat_changed` invalidacije bez sadržaja poruke. Repository nakon invalidacije ponovo učitava autorizovani REST snapshot; reconnect dobija novi `chat_sync`.
- Otvoren chat obnavlja presence s expiry vremenom; ako je recipient trenutno u istom chatu, backend ne povećava unread count i ne kreira push outbox zapis.
- Typing indikator je transient state s kratkim expirationom.
- Seen se prikazuje samo ispod stvarne posljednje outgoing poruke koja je pročitana, ne u bubbleu i ne na starijim porukama.
- Unread counters se računaju u backendu, a streamovi za indikatore se aktiviraju samo dok je relevantan view u widget stacku, ne globalno kroz cijeli lifecycle aplikacije. SSE je primarni invalidator, foreground chat FCM odmah pokreće REST refresh, a jednokratni REST refresh se radi i kada se aplikacija vrati u foreground. Chat nema periodični polling.
- API vraća trajne Firebase Storage pathove; `ChatRepositoryImpl` ih pretvara u download URL-ove samo za prikaz.

Chat se otvara iz booking/appointment detalja kroz *Message provider/customer* i iz Messages stavke na More/Profile ekranima.

---

## 12. Notifikacije

### In-app i push podjela

- Booking i appointment događaji se zapisuju kao **in-app notification** u Supabase PostgreSQL bazu preko Go API-ja. Nakon uspješnog zapisa API šalje FCM push na registrirane uređaje.
- Chat koristi **samo push** (ako chat nije otvoren) i unread message counter; ne proizvodi dupliciranu in-app notifikaciju.
- Potvrda kreiranja booking/appointmenta ne šalje customeru suvišnu “confirmed” notifikaciju, jer confirmation ekran već potvrđuje uspjeh.

Flutter FCM lifecycle vodi `NotificationDeviceService`: nakon prijave registruje token putem `PUT /v1/notification-devices/{deviceId}`, a pri odjavi ga uklanja putem `DELETE` rute. `NotificationBellCubit` poziva `GetUnreadNotificationsCountUseCase`, ne poziva use case iz widgeta. Kada aplikacija u foregroundu primi FCM poruku, Cubit odmah osvježi `GET /v1/notifications/unread-count`; periodični refresh svakih 30 sekundi ostaje samo kao fallback. Nema WebSocket konekcije.

### Dispatch događaja

| Izvor | Efekat |
|---|---|
| Go API: booking created | Provider dobija in-app i FCM notifikaciju o novom bookingu |
| Go API: booking status changed | Customer dobija in-app i FCM notifikaciju o promjeni statusa bookinga |
| Go API: booking cancelled by customer | Provider dobija in-app i FCM notifikaciju o customer otkazivanju |
| Go API: appointment created | Provider dobija in-app i FCM notifikaciju o novom appointmentu |
| Go API: appointment status changed | Customer dobija in-app i FCM notifikaciju o promjeni statusa appointmenta |
| Go API: appointment cancelled by customer | Provider dobija in-app i FCM notifikaciju o customer otkazivanju |
| Go API: chat message committed | `chat_push_outbox` worker šalje push samo ako recipient nije aktivan u istom chatu |
| `initializeBusinessMetrics` | Callable inicijalizacija ili verzionirana obnova KPI i earnings agregata za owner business |

Migracija `000019_notifications` kreira Supabase tabele `notification_devices` i `in_app_notifications`. API je jedini klijent Supabasea; Flutter ne pristupa Supabaseu direktno. Customer ne dobija notifikaciju kada sam otkaže booking ili appointment; tada se notifikacija šalje samo provideru. Push failure ne poništava već uspješno spremljenu booking/appointment promjenu ili in-app zapis.

FCM tokeni se čuvaju po `user_id` i `device_id`; ponovna registracija istog uređaja osvježava token. API koristi idempotentne ID-jeve notifikacija, pa se isti business događaj ne upisuje duplo.

Za iOS push na stvarnom uređaju je potreban APNs token/certifikat; bez njega FCM push ne može biti pouzdano testiran na iOS-u. In-app podaci i dalje rade nezavisno od APNs-a.

---

## 13. Firebase i backend model podataka

| Spremište / putanja | Svrha |
|---|---|
| `users/{uid}` | korisnički profil, tip, selected business i grad/adresa |
| Supabase `notification_devices` | FCM tokeni uređaja, dostupni samo kroz Go API |
| Supabase `in_app_notifications` | in-app notifikacije, read status i payload, dostupni samo kroz Go API |
| Supabase `business_reviews` | recenzije i source/customer snapshoti; dostupno samo kroz Go API |
| Supabase `support_tickets` | customer support zahtjevi i statusi; dostupno samo kroz Go API |
| Supabase `recently_viewed_businesses` | nedavno otvoreni businessi, dostupni samo kroz Go API |
| Supabase business tabele | stay ili service business, detalji, mediji, lokacija i discovery polja |
| Supabase `business_promotions` | ownerov promotion konfigurisan za jedan business |
| Supabase `stay_bookings` | stay rezervacije i payment/guest snapshot |
| Supabase `service_appointments` | service termini, provider, services, payment i reschedule stanje |
| Supabase `stay_bookings` / `service_appointments` | source of truth za dashboard metrike; Go API iz njih računa indeksirani current-month snapshot i šalje live invalidacije kroz SSE |
| Supabase `chat_conversations` / `chat_participant_state` / `chat_messages` | chat metadata, participant read/typing/presence stanje i poruke; dostupno samo kroz Go API |
| Supabase `chat_push_outbox` | trajni chat push red sa retry i delivery statusom; obrađuje ga Go API worker |
| `business_metrics/{businessId}` | legacy Firebase aggregate; migrirani Flutter dashboard i Earnings ga više ne čitaju |
| `business_metrics/{businessId}/months/{YYYY-MM}` | legacy Firestore revenue/cash/online i dnevni podaci; nisu dio aktivnog Flutter toka |
| Supabase `service_staff_availability_blocks` | providerove ručne blokade vremenskih raspona, dostupne samo kroz Go API |

Storage putanje:

```text
businesses/{ownerId}/{businessId}/{fileName}
profiles/{userId}/{fileName}
```

Za Go/PostgreSQL backend Storage path je trajni podatak, dok Firebase download URL nije. PostgreSQL čuva samo path, npr. `profiles/{userId}/profile.webp`. Flutter preko Firebase Storage SDK-a iz tog patha dobija trenutni download URL samo za prikaz slike; URL se ne upisuje u PostgreSQL niti šalje nazad Go API-ju.

---

## 14. Sigurnost

Pravila su u [firestore.rules](firestore.rules) i [storage.rules](storage.rules).

- Business je čitljiv prijavljenim korisnicima, ali create/update/delete radi samo owner.
- Promotion dokument može kreirati, mijenjati ili obrisati samo owner pripadajućeg businessa; customer ga ne može mijenjati niti proizvoljno postaviti `isPromotionActive`.
- Booking i appointment mogu čitati/mijenjati samo customer ili business owner; ID-jevi customer/owner ne mogu se prepisati updateom.
- Customer može rescheduleati appointment najviše jednom; owner nema taj limit.
- Appointment slotovi izlažu samo dostupnost, a ne privatne podatke customera.
- Service availability blocks može kreirati/brisati samo business owner.
- Conversation i messages su dostupni samo učesnicima; create provjerava da business stvarno pripada navedenom owneru.
- Saved, draftovi, uređaji, notifikacije i recently viewed su scoped na vlastitog usera.
- Recenziju kreira samo customer iz vlastite završene rezervacije ili termina; baza garantuje najviše jednu recenziju po customeru i businessu, a prosjek se ažurira atomski.
- Storage dozvoljava samo vlasniku upload/update/delete slike, do 10 MB i isključivo `image/*` sadržaj.
- `google-services.json` i `GoogleService-Info.plist` su u `.gitignore`; API ključevi i konfiguracija ne idu u Git.

---

## 15. Pretraga, filtriranje i paginacija

### REST discovery put

Početni home feed, city feed, popular/trending sekcije, kategorije i kolekcije koriste paginirane Go REST endpoint-e. Flutter nema `DataCursor`, `FirestoreDataSource` ni `cloud_firestore` dependency; server kontroliše upite, autorizaciju i PostgreSQL paginaciju.

### Server-side filter put

Stay filteri koriste Go endpoint `GET /v1/stays/search`, a service filteri `GET /v1/services/search`. Oba endpointa obrađuju:

- parsiranje/validacija filtera;
- validaciju, normalizaciju i mapiranje rezultata;
- availability provjeru;
- sortiranje i cursor response.

Service endpoint prihvata datum/vrijeme, kategoriju, featured kolekciju, grad, raspon cijene, sortiranje i cursor. Vraća isti `BusinessModel` oblik koji je Flutter ranije primao od callable funkcije, uključujući ponude, providere, media URL-ove i `nextCursor`.

Service availability provjerava da li barem jedan provider ima cijeli uzastopni raspon slobodnih 30-minutnih slotova za traženo trajanje. To sprječava da se business vrati u rezultatima ako su svi radnici zauzeti u tom vremenu.

Customer stay i service detail ekrani učitavaju puni aktivni business agregat preko `GET /v1/discovery/businesses/{businessID}`. Endpoint vraća isti `BusinessModel` oblik, uključujući media, stay sobe/amenities ili service ponude/providere, pa detail ekran ne čita business dokument direktno iz Firestorea.

Backend greške se na serveru loguju i vraćaju kao standardni API error response; `ApiClient` ih pretvara u `ApiException`, pa se greška ne miješa s praznim rezultatom.

### Normalizacija

Za pouzdan search/filter gradova koriste se normalizovana polja, posebno `location.cityLowercase`. Normalizacija je usklađena između Fluttera i Functions-a (lowercase, trim i uklanjanje dijakritika). Identifikatori kategorija/kolekcija čuvaju underscore (`tattoo_piercing`, `beauty_grooming`) i ne tretiraju se kao običan tekst.

---

## 16. Optimizacija troškova i resursa

| Mjera | Zašto smanjuje trošak / resurse |
|---|---|
| Cursor paginacija | Čitaju se samo naredne stranice, ne kompletna kolekcija |
| Direktni Firestore bez filtera | Ne poziva Cloud Function za obične home/explore queryje |
| Callable samo za kompleksne filtere | Skupi kombinovani availability/filter posao ostaje server-side, bez skidanja velikih skupova na uređaj |
| Limitirani candidate batch i opaque endpoint cursor | Funkcija obrađuje kontrolisan broj dokumenata po pozivu |
| Composite indeksi | Firestore može izvršiti query bez punog skeniranja kolekcije |
| City denormalizacija | `location.cityLowercase` omogućava efikasan city query |
| Lagani promotion signal | Feed kartice čitaju samo `isPromotionActive`, a detalji promocije se učitavaju tek u checkoutu |
| Checkout revalidacija popusta | Čuva integritet cijene bez stalnog učitavanja promotion dokumenata kroz feedove |
| `appointment_slots` metadata | Dostupnost se čita bez preuzimanja privatnih appointment dokumenata |
| Indeksirani dashboard metrics query + SSE invalidacija | Dashboard čita samo relevantne PostgreSQL redove tekućeg mjeseca i dobija novi snapshot tek nakon commitane promjene |
| Precomputed Earnings metrics | Nemigrirani Earnings čita male Firestore month/provider agregate umjesto svih historijskih rezervacija |
| Debounced text search | Smanjuje broj requestova dok korisnik tipka |
| Slika: WebP, quality 42, max 1080 | Znatno manje Storage bandwidtha i vremena uploada; original se zadrži samo ako kompresija nije bolja ili plugin zakaže |
| Max 7 business fotografija | Kontrolisan Storage i payload obim |
| Nominatim reverse geocoding | Izbjegava plaćeni Google Geocoding API |
| Lazy/feature-scoped streamovi | Unread/chat stream nije globalno aktivan kroz cijelu aplikaciju |
| Centralni session stream cleanup | Sve registrirane root Firestore pretplate se otkažu prije Auth sign-outa; nema zabranjenih read pokušaja ni nepotrebnih reconnecta |
| FCM token cleanup | Ne troši push attempt na nevalidne tokena |
| Idempotent notification dispatcher | Retry ne šalje i ne broji duplikate |
| Chat bez in-app duplikata | Chat poruke koriste push samo kada chat nije otvoren |

Cloud Functions i dalje generišu usage kada se pozovu. Zato se ne smiju koristiti za svaki obični feed request; sadašnji hibridni model je namjerno postavljen upravo da ih koristi samo kada kompleksni filteri to opravdavaju.

---

## 17. Firestore indeksi

[firestore.indexes.json](firestore.indexes.json) sadrži indekse za kombinacije koje aplikacija koristi, uključujući:

- aktivne stays/services sortirane po ratingu, reviews i imenu;
- city + type + active queryje;
- city + category za services;
- category i featured collection (`array-contains`) kombinacije;
- booking date/status queryje;
- appointment business/date/status queryje;
- slot i provider availability queryje.

Prilikom Firebase deploya ne treba automatski brisati index koji CLI navede kao “defined in project but not present in file” ako je i dalje potreban aplikaciji. Prvo treba provjeriti query koji ga koristi, zatim index zadržati ili svjesno ukloniti iz koda i konfiguracije.

---

## 18. Build, lokalni razvoj i deploy

### Flutter

```bash
flutter pub get
flutter analyze
flutter run
```

Za generisane mapper/DI fajlove, nakon izmjene modela ili Injectable registracija:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Functions

```bash
cd functions
npm install
npm run build
cd ..
```

Lokalni emulator:

```bash
npm --prefix functions run serve
```

### Firebase deploy

Korisnik deploy radi ručno. Konfigurisan codebase je **`multibook`**, zato imenovani deploy mora sadržati codebase:

```bash
firebase deploy --only firestore:rules,firestore:indexes,storage
firebase deploy --only functions:multibook:searchStays,functions:multibook:searchServices
firebase deploy --only functions:multibook:initializeBusinessMetrics,functions:multibook:notifyOnBookingCreated,functions:multibook:notifyOnBookingStatusChanged,functions:multibook:notifyOnAppointmentCreated,functions:multibook:notifyOnAppointmentStatusChanged
firebase deploy --only functions
```

Ako Firebase CLI predloži brisanje postojećih indeksa, odgovoriti `N` dok se ne potvrdi da nijedan aktivni query više ne zavisi od njih.

### iOS / Android napomene

- `image_picker` zahtijeva `NSPhotoLibraryUsageDescription` i `NSCameraUsageDescription` u iOS `Info.plist`.
- Google Maps zahtijeva platformsku registraciju plugina, Maps SDK omogućen za iOS/Android i API key u nativnoj konfiguraciji. API key se ne dokumentuje niti commita u Git.
- Za Firebase Messaging na iOS stvarnom uređaju treba APNs konfiguracija. Simulator nije zamjena za end-to-end push test.
- Nakon dodavanja ili izmjene nativnog plugina često je potreban puni restart, a ne hot reload.

---

## 19. Testiranje i observability

Minimalna provjera prije predaje promjene:

```bash
flutter analyze
npm --prefix functions run build
```

Za kritične flowove treba ručno provjeriti:

1. email, Google i logout autentikaciju, uključujući direktan prelaz na sign-in bez dashboard flasha i bez `permission-denied` stream grešaka;
2. kreiranje stay/service businessa sa slikama;
3. direktni i endpoint search/filter rezultat;
4. booking i appointment create/cancel/reschedule, cash plaćanje i past-cash No-show;
5. zauzete slotove sa više providera;
6. promjenu selektovanog businessa na dashboardu, bookings i calendaru;
7. chat seen/typing, unread indikator i ponašanje kad je chat otvoren;
8. in-app/push notifikacije na stvarnom uređaju;
9. Firestore/Storage permission pravila za customer i provider account.

Repositoryji i data sourcevi koriste `dart:developer` logove za bitne Firebase i endpoint greške. Funkcije koriste `console.error`; produkcijske greške se tako mogu pronaći u Cloud Functions logovima, a mobilne `FirebaseFunctionsException` greške u Flutter konzoli.

---

## 20. Trenutna ograničenja i naredne preporuke

- Payment UI koristi mock potvrdu za karticu, Apple Pay i Google Pay; prije produkcije treba integrisati stvarni payment provider (npr. Stripe), tokenizaciju i server-side verifikaciju. Kartični podaci se ne smiju trajno spremati u Firestore.
- Search po slobodnom tekstu u Firestoreu ima prirodna ograničenja; za napredni full-text search u produkciji treba procijeniti Algolia, Typesense, Meilisearch ili namjenski indeks, uz troškovnu analizu.
- Callable endpointi trenutno služe kompleksnim filterima. Ako kasnije business transakcije trebaju strožiju server-side kontrolu, booking/appointment create može se migrirati na callable endpoint uz server-side payment verifikaciju.
- Za veći obim potrebno je dodati automatizovane unit, repository, widget i integration testove, Crashlytics/analytics strategiju, rate limiting i monitoring budžeta.

---

## 21. Referentni fajlovi

- [pubspec.yaml](pubspec.yaml) — Flutter paketi.
- [firebase.json](firebase.json) — Firebase projekat, rules, indeksi i Functions codebase.
- [firestore.rules](firestore.rules) i [storage.rules](storage.rules) — autorizacija.
- [firestore.indexes.json](firestore.indexes.json) — Firestore query indeksi.
- [lib/src/data/repositories](lib/src/data/repositories) — repository sloj.
- [lib/src/data/data_sources](lib/src/data/data_sources) — adapteri prema backendu/servisima.
- [lib/src/features](lib/src/features) — feature organizacija.
- [functions/src](functions/src) — callable endpointi i Firestore triggeri.
