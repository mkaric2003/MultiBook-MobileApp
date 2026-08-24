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

1. Provider kreira stay ili service business, unosi lokaciju, slike, ponudu i dostupnost.
2. Nakon prvog businessa početni ekran postaje dashboard; selektovani business se čuva u user profilu.
3. Provider mijenja business na dashboardu / business selectoru, pregleda njegove bookinge ili appointmente i upravlja njima.
4. Za stays vidi zauzete dane; za services vidi zauzete i blokirane 30-minutne slotove po radniku.

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
             Repository
                  │
                  ▼
          Data source adapteri
                  │
                  ▼
Firebase / HTTP / lokalni cache
```

- **Presentation** prikazuje stanje i šalje korisničke akcije Cubit/BLoC-u. Nema direktnih Firebase poziva.
- **Repository** sadrži poslovnu logiku, mapiranje modela, kombinovanje izvora podataka, logging i obradu greške.
- **Data source** je jedino mjesto koje direktno razgovara sa Firebaseom, HTTP API-jem ili pluginom uređaja.
- **Models/enums** su eksplicitni i tipizirani. Feature-specifični modeli idu u `feature/domain/models`, a zajednički persisted modeli u `src/data/models`.

### 4.2 Struktura direktorija

```text
lib/
 ├─ main.dart                         # inicijalizacija DI-ja i aplikacije
 ├─ app.dart                          # MaterialApp, router i inicijalizacija notifikacija
 ├─ src/
 │   ├─ core/                         # konfiguracija, tema, Firebase modul, DI
 │   ├─ data/
 │   │   ├─ data_sources/             # Firebase/HTTP/plugin adapteri
 │   │   ├─ repositories/             # poslovna i pristupna logika
 │   │   ├─ models/ i enums/          # shared persisted modeli
 │   │   └─ data_cursor.dart          # Firestore cursor paginacija
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
- Globalno ponovljive komponente su u `src/global_widgets`: `CustomAppBar`, `CustomButton`, `CustomTextfield`, `SearchableCityPickerSheet` i `LabeledDivider`.
- Tamna tema i boje dolaze iz `AppTheme` i `AppColors`, ne iz nasumičnih hardkodiranih boja u viewu.

---

## 5. Navigacija i ulaz u aplikaciju

`GoRouter` koristi tri zaštitna nivoa:

1. **Onboarding**: dok `has_seen_onboarding` nije postavljen u Shared Preferences, korisnik ostaje na `/onboarding`.
2. **Autentikacija**: neprijavljen korisnik ide na `/sign-in`; prijavljen ne može ostati na sign-in/sign-up ekranu.
3. **Tip korisnika i entry screen**: user profil određuje customer/provider tok. Provider entry dodatno provjerava ima li business i otvara Add Business ili dashboard.

Sve rute su centralizovane u [lib/src/router/app_routes.dart](lib/src/router/app_routes.dart) i [lib/src/router/app_pages.dart](lib/src/router/app_pages.dart).

---

## 6. Dizajn sistema

- Aplikacija koristi tamni UI: osnovna pozadina, kartice, navigation surface, muted tekst i ljubičasti accent su centralizovani u `AppColors`.
- Selektovana stanja koriste primarnu ljubičastu; statusi koriste semantičke boje (confirmed, cancelled/declined, completed).
- Customer i provider bottom navigation imaju isti vizuelni jezik, ali različite tabove.
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
- Logout briše aktivnu sesiju i vraća korisnika na sign-in.

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

Add Business feature koristi BLoC, zasebne widgete za formu, medije, stay jedinice, service ponude, osoblje i slotove. Slike se biraju iz galerije/kamere, kompresuju, uploaduju u Firebase Storage i tek onda se business trajno upisuje u Firestore.

Razvojni seed metod puni bazu realističnim stay i service podacima (različiti gradovi, kategorije, cijene, rating, slike, rooms, extras, staff i ponuda). Seed je samo za development/testiranje i ne treba biti dostupan u produkcijskom UI-ju.

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
- Ako nema filtera, čitanje ide direktno iz Firestorea. Ako su filteri aktivni, koristi se callable Cloud Function; to izbjegava preuzimanje svih kandidata na uređaj i lokalno filtriranje nepotpunog paginiranog skupa.

### Stay detail i booking

- Hero galerija prikazuje cover kao prvu sliku, zatim `photoUrls`; broj page indikatora odgovara stvarnom broju slika.
- Prikazani su cijena, ocjene, lokacija i mapa, rooms, amenities, extras, opis i recenzije.
- Ako customer ne odabere room type, flow koristi default jedinicu/cijenu businessa gdje je to dozvoljeno.
- Booking details bira raspon datuma (ponedjeljak je prvi dan sedmice), goste i provjerava dostupnost.
- Review stay bira extras i izračunava room subtotal, cleaning/service fee, taxes i total.
- Payment podržava karticu, Apple Pay, Google Pay i **plaćanje gotovinom**. Kartica validira format broja, expiry i 3-cifreni CVV; gotovina ne traži kartične podatke.
- Booking se kreira kao `confirmed`; mogući statusi su `confirmed`, `declined`, `cancelled`, `completed` i `noShow`.
- Customer može otkazati booking; providerovo odbijanje je `declined`, customerovo otkazivanje je `cancelled`.
- Za gotovinske rezervacije business odmah vidi očekivanu zaradu. Nakon isteka termina provider može označiti `noShow`; iznos se tada uklanja iz zarade, cash/online podjele, broja rezervacija i chart agregata.

### Service detail i appointment

- Detail prikazuje galeriju, kategoriju, ocjenu, mapu, service offeringe, cijene/trajanja, opis i staff.
- Customer može odabrati više usluga; ukupno trajanje određuje koliko susjednih 30-minutnih slotova mora ostati slobodno.
- Dostupnost se provjerava po konkretnom provideru; zauzeti ili blokirani slotovi nisu selektabilni.
- Review appointment prikazuje odabrane usluge i add-ons; special requests su namjerno izbačeni iz sadašnjeg flowa.
- Payment kreira `confirmed` appointment i atomarno zauzima njegove slotove. Dostupni su kartica, Apple Pay, Google Pay i gotovina.
- Appointment detail prikazuje business, izvođača, usluge, datum/vrijeme, cijene, payment metodu i confirmation code.
- Customer može otkazati appointment i može ga rescheduleati samo jednom; provider može rescheduleati bez tog ograničenja. Past cash appointment može biti označen kao `no_show` kada customer ne dođe.

### Draftovi

- `booking_drafts/{userId}` čuva prekinuti stay flow.
- `appointment_drafts/{userId}` čuva odabrane usluge, provider, datum, slotove, add-ons i ostale potrebne podatke service flowa.
- Pri napuštanju flowa prikazuje se odluka da se draft sačuva ili odbaci.
- Draft vraća označene datume, slotove i extras/add-ons pri nastavku.

### My Bookings, Saved, Profile i Explore

- **My bookings** razdvaja stays i services na upcoming/past, uz live osvježavanje nakon cancel akcije.
- **Saved** je vezan za usera; animirano uklanjanje iz liste, toast feedback i trenutno stanje srca na detailu.
- **Profile/Edit Profile** omogućava avatar, puno ime, telefon sa country pickerom, datum rođenja preko Cupertino pickera, adresu i grad.
- **Contact us** koristi zaseban Support Tickets feature, a ne customer-business chat. Customer kreira ticket s kategorijom, naslovom i porukom te vidi samo vlastite tickete i njihove statuse (`open`, `inProgress`, `resolved`).
- Ticketi se čuvaju u `support_tickets`; Firestore pravila dozvoljavaju customeru kreiranje i čitanje samo vlastitih zahtjeva, dok status kasnije mijenja interni support/admin alat.
- **Explore** ima odvojene stay/service prikaze, izbor grada uključujući *All cities*, browse-by-category, kolekcije, top/trending poslovanja i recently viewed.
- Recently viewed se sprema po useru i po businessu; naslov se ne prikazuje kada nema podataka.
- Rezultati kategorije/kolekcije koriste cursor paginaciju.

---

## 10. Provider featurei

### Dashboard, earnings i business management

- Dashboard prikazuje selektovani business, aktivne bookinge/appointmente, zaradu u tekućem mjesecu, prosječni rating i FL Chart trendove iz agregiranih metrika.
- Earnings prikazuje ukupnu mjesečnu zaradu, odvojeno **online** i **cash** earnings, te trend prihoda i volumena rezervacija.
- Earnings period filter podržava: current week, past week, this month, past month, this year, last year i custom raspon. Custom početni/završni datum se bira u Cupertino date pickeru.
- Kod service businessa Earnings omogućava i izbor zaposlenika. Prikazuju se **gross earnings** (ukupna vrijednost njegovih appointmenta) i **provider earnings** (njegova ugovorena provizija), uz trend prihoda i broj appointmenta za odabrani period.
- Svaki zaposlenik ima `commissionRate` (podrazumijevano 100%). Pri kreiranju appointmenta spremaju se historijski snapshoti `providerCommissionRate` i `providerEarnings`, pa kasnija promjena provizije ne mijenja ranije obračune.
- Cloud Functions održavaju owner-only agregate po zaposleniku u `business_metrics/{businessId}/providers/{providerId}/months/{YYYY-MM}`. Dnevni gross/provider iznosi omogućavaju week i custom filtere bez čitanja svih appointment dokumenata.
- Za djelimične mjesece (sedmica i custom period) agregat koristi samo dnevne vrijednosti unutar odabranog raspona, uključujući zasebne daily online i cash earnings, pa podjela ostaje tačna.
- Cash rezervacija/appointment ulazi u earnings odmah pri potvrdi kao očekivani prihod. No-show je dostupan samo provideru, samo za završeni cash termin/rezervaciju sa statusom `confirmed` ili `completed`; uz akciju se prikazuje objašnjenje o uticaju na metrike.
- `business_metrics/{businessId}` i mjesečni dokumenti su server-side agregati. Ne računaju se skeniranjem svih booking/appointment dokumenata pri svakom otvaranju dashboarda.
- `selectedBusinessId` u user dokumentu je jedini izvor aktivnog businessa i promjene se reaktivno reflektuju na dashboard i booking ekran.
- Ako provider nema businessa, dashboard prikazuje empty state i *Add new business* akciju.
- *My Businesses* lista podržava dodavanje, biranje aktivnog businessa i swipe-to-delete sa animacijom kartice bez reloadanja cijelog ekrana.

### Provider bookings i appointments

- Bookings ekran učitava stavke za selektovani business, koristi filter chipove i cursor paginaciju.
- Manage Booking prikazuje customera, room, datume, goste, cijenu, završavanje i odbijanje. Kod past cash stavki nudi i No-show akciju sa hintom o uklanjanju iz earnings metrika.
- Service appointment kartice imaju Manage akciju za customer detalje, završavanje, cancel, reschedule, kontakt i No-show za past cash termine.
- Provider cancel rezultira statusom `declined`; customer cancel rezultira `cancelled`.

### Availability & Calendar

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
- `conversations/{conversationId}` čuva `businessId`, ownera, customera, participant IDs, preview zadnje poruke, read/typing/activity metadata.
- Poruke su u `conversations/{conversationId}/messages/{messageId}`.
- Otvoren chat postavlja aktivnog učesnika s expiry vremenom; ako je recipient trenutno u tom chatu, cloud trigger ne šalje ni in-app ni push notifikaciju za poruku.
- Typing indikator je transient state s kratkim expirationom.
- Seen se prikazuje samo ispod stvarne posljednje outgoing poruke koja je pročitana, ne u bubbleu i ne na starijim porukama.
- Unread counters se računaju u backendu, a streamovi za indikatore se aktiviraju samo dok je relevantan view u widget stacku, ne globalno kroz cijeli lifecycle aplikacije.

Chat se otvara iz booking/appointment detalja kroz *Message provider/customer* i iz Messages stavke na More/Profile ekranima.

---

## 12. Notifikacije

### In-app i push podjela

- Booking i appointment događaji stvaraju **in-app notification** dokument i, kada uređaj ima token, šalju push notifikaciju.
- Chat koristi **samo push** (ako chat nije otvoren) i unread message counter; ne proizvodi dupliciranu in-app notifikaciju.
- Potvrda kreiranja booking/appointmenta ne šalje customeru suvišnu “confirmed” notifikaciju, jer confirmation ekran već potvrđuje uspjeh.

### Cloud Function triggeri

| Trigger | Efekat |
|---|---|
| `notifyOnBookingCreated` | Provider dobija notifikaciju o novom bookingu |
| `notifyOnBookingStatusChanged` | Customer dobija promjenu statusa bookinga |
| `notifyOnAppointmentCreated` | Provider dobija notifikaciju o novom appointmentu |
| `notifyOnAppointmentStatusChanged` | Customer dobija promjenu statusa appointmenta |
| `notifyOnChatMessageCreated` | Push samo ako recipient nije aktivan u istom chatu |
| `initializeBusinessMetrics` | Callable inicijalizacija ili verzionirana obnova KPI i earnings agregata za owner business |

Promjene booking/appointment dokumenata istovremeno ažuriraju `business_metrics`: novi confirmed zapis dodaje prihod, a `declined`, `cancelled` ili no-show (`noShow` za booking, `no_show` za appointment) ga uklanja. Gotovina se računa pri potvrdi, ne tek pri ručnom označavanju kao completed.

`notification_dispatcher` koristi transaction claim pattern (`processing`, timeout, attempts) kako se ista notifikacija ne bi više puta brojala ili slala pri retryju. Nevalidni FCM tokeni se uklanjaju iz `users/{uid}/devices`.

Za iOS push na stvarnom uređaju je potreban APNs token/certifikat; bez njega FCM push ne može biti pouzdano testiran na iOS-u. In-app podaci i dalje rade nezavisno od APNs-a.

---

## 13. Firebase model podataka

| Putanja | Svrha |
|---|---|
| `users/{uid}` | korisnički profil, tip, selected business, grad/adresa i unread counteri |
| `users/{uid}/devices/{deviceId}` | FCM tokeni uređaja |
| `users/{uid}/notifications/{id}` | in-app notifikacije |
| `users/{uid}/recently_viewed/{businessId}` | nedavno otvoreni businessi |
| `businesses/{businessId}` | stay ili service business, detalji, mediji, lokacija i discovery polja |
| `bookings/{id}` | stay rezervacije i payment/guest snapshot |
| `appointments/{id}` | service termini, provider, services, payment i reschedule stanje |
| `business_metrics/{businessId}` | agregat aktivnih booking/appointment KPI-jeva i verzija migracije metrika |
| `business_metrics/{businessId}/months/{YYYY-MM}` | mjesečna revenue/cash/online zarada, booking count i dnevni ukupni/online/cash chart podaci |
| `appointment_slots/{id}` | javna metadata zauzetog termina po provideru i 30-min slotu |
| `service_availability_blocks/{id}` | providerova ručna blokada slobodnog slota |
| `booking_drafts/{uid}` | prekinut stay booking tok |
| `appointment_drafts/{uid}` | prekinut appointment tok |
| `saved_businesses/{uid}/items/{businessId}` | customer favorit/saved snapshot |
| `conversations/{id}` | business-customer chat metadata |
| `conversations/{id}/messages/{id}` | poruke |
| `notification_deliveries/{id}` | idempotency/delivery evidencija chat push notifikacija |

Storage putanje:

```text
businesses/{ownerId}/{businessId}/{fileName}
profiles/{userId}/{fileName}
```

---

## 14. Sigurnost

Pravila su u [firestore.rules](firestore.rules) i [storage.rules](storage.rules).

- Business je čitljiv prijavljenim korisnicima, ali create/update/delete radi samo owner.
- Booking i appointment mogu čitati/mijenjati samo customer ili business owner; ID-jevi customer/owner ne mogu se prepisati updateom.
- Customer može rescheduleati appointment najviše jednom; owner nema taj limit.
- Appointment slotovi izlažu samo dostupnost, a ne privatne podatke customera.
- Service availability blocks može kreirati/brisati samo business owner.
- Conversation i messages su dostupni samo učesnicima; create provjerava da business stvarno pripada navedenom owneru.
- Saved, draftovi, uređaji, notifikacije i recently viewed su scoped na vlastitog usera.
- Storage dozvoljava samo vlasniku upload/update/delete slike, do 10 MB i isključivo `image/*` sadržaj.
- `google-services.json` i `GoogleService-Info.plist` su u `.gitignore`; API ključevi i konfiguracija ne idu u Git.

---

## 15. Pretraga, filtriranje i paginacija

### Direktni Firestore put

Bez aktivnih kompleksnih filtera app koristi direktne, limitirane i cursor-paginirane Firestore queryje. To je idealno za početni home feed, city feed, popular/trending sekcije, kategorije i kolekcije.

`DataCursor<T>` čuva zadnji `DocumentSnapshot`, koristi `startAfterDocument`, sprječava paralelno učitavanje (`isLoading`) i prekida kada je sve učitano. Time se ne učitava cijela kolekcija unaprijed.

### Callable filter put

Za kombinovane stay/service filtere app koristi callable Functions `searchStays` i `searchServices`. Funkcije su rastavljene na manje module:

- parsiranje/validacija filtera;
- izgradnja Firestore candidate queryja;
- normalizacija i mapiranje dokumenata;
- availability provjera;
- in-memory provjera samo nad ograničenim kandidatnim batchom;
- sortiranje i opaque cursor response.

Service availability provjerava da li barem jedan provider ima cijeli uzastopni raspon slobodnih 30-minutnih slotova za traženo trajanje. To sprječava da se business vrati u rezultatima ako su svi radnici zauzeti u tom vremenu.

Endpoint greške se na serveru loguju i pretvaraju u `HttpsError`; klijentski data source hvata `FirebaseFunctionsException`, ispisuje code, poruku i stack trace u konzolu, umjesto da grešku tiho pretvori u “no results”.

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
| `appointment_slots` metadata | Dostupnost se čita bez preuzimanja privatnih appointment dokumenata |
| Precomputed business metrics | Dashboard i Earnings čitaju mali agregat umjesto svih historijskih rezervacija |
| Debounced text search | Smanjuje broj requestova dok korisnik tipka |
| Slika: WebP, quality 42, max 1080 | Znatno manje Storage bandwidtha i vremena uploada; original se zadrži samo ako kompresija nije bolja ili plugin zakaže |
| Max 7 business fotografija | Kontrolisan Storage i payload obim |
| Nominatim reverse geocoding | Izbjegava plaćeni Google Geocoding API |
| Lazy/feature-scoped streamovi | Unread/chat stream nije globalno aktivan kroz cijelu aplikaciju |
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

1. email, Google i logout autentikaciju;
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
