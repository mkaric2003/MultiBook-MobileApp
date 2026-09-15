# MultiBook — Project Documentation

## 1. Purpose of This Document

This document describes the current production-oriented direction of the MultiBook mobile application, its architecture, integrations, business flows, and development rules. The source of truth for specific package versions is `pubspec.yaml`, for mobile routes it is `lib/src/router`, and for requests sent by the client it is the corresponding API data source.

MultiBook was originally developed on the Firebase platform, including Firestore, while business data and server-side logic were later migrated to a Go REST API and PostgreSQL; Firebase was retained for Authentication, Storage, and Cloud Messaging.

This document describes only the active system. The mobile application does not access the PostgreSQL database or the Supabase platform directly.

---

## 2. Product and User Roles

MultiBook is a marketplace for two types of reservations:

- **Stays** — hotels, apartments, villas, cabins, holiday homes, resorts, and other forms of accommodation.
- **Services** — beauty, wellness, healthcare, education, home, automotive, and other services booked for a specific time slot.

The system supports two user roles:

- **Customer** searches the offering, filters results, opens details, saves a business, creates a booking or appointment, manages reservations, leaves reviews, and communicates with the provider.
- **Provider** creates and edits one or more businesses, manages offerings and availability, processes reservations, tracks metrics, and communicates with customers.

Bookings, appointments, promotions, availability, and chat are tied to a specific `businessId`. A provider may own multiple businesses, so the provider's user identity alone is not sufficient as the domain context.

### 2.1 Customer Flow

1. Onboarding is shown on the first launch and recorded locally.
2. The user registers or signs in with email and password or a Google account.
3. A new account selects a user role.
4. Customer home, with the user's permission, retrieves the location and uses the city for local ranking of offerings.
5. The customer chooses stays or services, uses discovery or search, opens details, and starts the corresponding checkout.
6. An unfinished booking or appointment can be saved as a draft.
7. The backend validates availability, prices, promotions, and reservation creation.
8. A created reservation is available in **My Bookings**, and changes to it may produce in-app and push notifications.

### 2.2 Provider Flow

1. The provider creates a stay or service business with a location, media, offering, and availability rules.
2. The active business determines the context for the dashboard, reservations, calendar, earnings, and promotions.
3. The provider can change the active business without changing the user account.
4. **Manage Stays & Services** loads the full business aggregate and uses the same editor for create and update flows.
5. The provider processes bookings or appointments and manages availability.

---

## 3. System Overview

```text
Flutter application
  ├─ Firebase Authentication ── identity and ID token
  ├─ Firebase Storage ───────── profile and business images
  ├─ Firebase Cloud Messaging ─ push delivery and notification opening
  └─ HTTPS / SSE ─────────────── Go API under /v1
```

### 3.1 Source of Truth

- The Go REST API is the only mobile boundary for profiles, businesses, offerings, availability, reservations, chat, notifications, promotions, payment-method metadata, saved items, and other business data.
- Firebase Authentication is the source of authentication identity. API requests use a Firebase ID token.
- Firebase Storage contains binary media objects, while application models use stable storage paths.
- FCM is the transport for push messages. The in-app list and read status are loaded through REST.

### 3.2 Why Firebase Remains in the System

**Authentication** was retained because it handles the security-sensitive identity layer through maintained iOS/Android SDKs, session management, token rotation, email/password flows, and Google federation. The mobile client receives a short-lived ID token for API requests without manually implementing an identity protocol.

**Storage** was retained because purpose-built object storage is better suited for image upload and delivery than sending binary content through the application API. The mobile SDK supports direct, controlled upload, Storage rules restrict access, and the client resolves a stable path into a download URL only when displaying the image.

**Cloud Messaging** was retained as the standard transport to APNs and Android push infrastructure. Push is not a source of business state: after receiving a push, the application refreshes the authorized REST snapshot.

---

## 4. Technology Stack

| Area | Technology | Responsibility |
|---|---|---|
| Mobile application | Flutter / Dart | Shared iOS and Android client |
| State management | `flutter_bloc` | Cubit/BLoC, events, and explicit UI states |
| Local widget state | `flutter_hooks` | Short-lived state tied to a single widget |
| Navigation | `go_router` | Routes, redirects, and navigation stack |
| Bottom navigation | `persistent_bottom_nav_bar_v2` | Separate customer and provider tab stacks |
| Dependency injection | `get_it` + `injectable` | Construction and lifecycle of application dependencies |
| Models | `dart_mappable` | Typed serialization and copy operations |
| HTTP | `dio` | Authenticated JSON requests to the Go API |
| Realtime | Server-Sent Events | Targeted invalidations for chat, dashboard, and earnings |
| Identity | Firebase Authentication | Session, ID token, email/password, and Google sign-in |
| Media | Firebase Storage | Avatar and business images |
| Push | Firebase Cloud Messaging | Push transport and device token lifecycle |
| Remote API | Go REST API | Business data and server-authoritative operations |
| Location | `geolocator`, Google Maps, Nominatim | Permission, map, and reverse geocoding |
| Local storage | Shared Preferences | Onboarding, locale, and theme preference |
| UI | Material, Cupertino, Google Fonts, SVG, FL Chart | Visual system and charts |
| Images | `image_picker`, `flutter_image_compress` | Selection and optimization before upload |

---

## 5. Mobile Application Architecture

### 5.1 Layers and Dependency Direction

```text
View / Widget
      │
      ▼
Cubit or BLoC
      │
      ▼
Action-specific use case
      │
      ▼
Repository contract
      │
      ▼
Repository implementation
      │
      ▼
API / Firebase / device data source
      │
      ▼
ApiClient, SseClient, or platform SDK
```

- **Presentation** renders state and forwards user actions to a Cubit or BLoC. A View does not call the HTTP client, a data source, or a repository implementation.
- A **Use case** represents one business action through a typed `execute()` or stream method. The use case depends on the repository contract, not the transport.
- The **Repository contract** belongs to the domain layer. The implementation in the data layer coordinates concrete data sources and error mapping.
- A **Data source** knows the endpoint, HTTP payload, or platform SDK. It does not make presentation decisions.
- **Core networking** contains shared transport primitives: `ApiClient`, `SseClient`, and `SseConnection`.

This structure allows the transport or backend implementation to change without moving infrastructure details into the UI and without introducing a generic repository layer that hides domain actions.

### 5.2 REST Request

A protected request follows this flow:

1. `ApiClient` reads the active Firebase user.
2. The SDK returns a valid ID token and the client adds `Authorization: Bearer <token>`.
3. The request is sent to the corresponding `/v1` endpoint.
4. A successful JSON response is mapped into a typed Dart model.
5. An unsuccessful response goes through the standard application error mapping.

The mobile client does not send a user ID as a substitute for authentication. User-scoped calls rely on the bearer token, while `businessId` represents the domain context of the operation.

### 5.3 Errors

`ApiClient` converts a transport error into `ApiException`. `RestRepositoryExecutor` is the single place for standard mapping of HTTP results into application-level `Result<T>` and `AppFailure`:

| HTTP / cause | Application failure |
|---|---|
| `400`, `422` | `ValidationFailure` |
| `401` | `UnauthorizedFailure` |
| `403` | `ForbiddenFailure` |
| `404` | `NotFoundFailure` |
| `5xx` | `ServerFailure` |
| timeout or transport | `NetworkFailure` |
| unexpected local error | `UnknownFailure` |

The Cubit branches on `Success<T>` and `FailureResult<T>`. Technical text from the backend response is used for logging and diagnostics; user-facing text comes from the localization layer.

### 5.4 Models and Code Organization

- Every model, enum, widget, Cubit/BLoC, and use case has its own file.
- Models use `dart_mappable`; manual serialization and multiple model classes in one file are not allowed.
- Shared persisted models are located in `lib/src/data/models`.
- Feature-specific inputs, arguments, and view models are located in `domain/models` of the corresponding feature.
- Repository contracts are in `lib/src/domain/repositories`, implementations in `lib/src/data/repositories`, and adapters in `lib/src/data/data_sources`.
- Each business action has a separate use case. One broad facade for unrelated actions is not used.
- Globally reusable widgets belong in `lib/src/global_widgets`; a widget belonging to a single feature remains in that feature's `presentation/widgets` directory.
- `setState` is not used. Local UI state is managed with Hooks, while business and asynchronous state is managed by Cubit or BLoC.
- Generated `.mapper.dart` and Injectable files are not edited manually.

### 5.5 Project Structure

```text
lib/
  main.dart                         compatible DEV entrypoint
  bootstrap.dart                    shared application initialization
  entry_points/
    main_dev.dart                   MultiBook DEV
    main_prod.dart                  MultiBook production
  app.dart                          MaterialApp, theme, locale, and router
  src/
    core/                            config, DI, networking, error, and services
    domain/
      repositories/                 repository contracts
      use_cases/                     action-specific use cases
    data/
      data_sources/                  HTTP, Firebase, and device adapters
      repositories/                 contract implementations
      models/                        shared typed models
    features/
      customer-side/                 customer features
      business-side/                 provider features
      shared/                        auth, chat, theme, locale, notifications
    global_widgets/                  reusable application components
    router/                          route constants and GoRouter pages
  l10n/                              ARB localization catalogs
```

---

## 6. Application Startup, Flavors, and Navigation

### 6.1 Bootstrap

`bootstrap.dart` performs shared startup:

1. initializes Flutter binding and the active `AppFlavor`;
2. configures Injectable/GetIt dependencies, including Firebase Core;
3. locks orientation to portrait;
4. constructs the notification coordinator;
5. starts `App`;
6. after the first frame, activates the notification lifecycle when the router is ready for navigation.

`app.dart` is limited to global Bloc providers, `MaterialApp.router`, theme, locale, and the DEV banner. FCM payload handling is not part of the root widget.

### 6.2 Flavors

| Flavor | Name | Android application ID | iOS bundle ID | Entry point |
|---|---|---|---|---|
| `dev` | MultiBook DEV | `com.multibook.app.dev` | `com.multibook.app.dev` | `lib/entry_points/main_dev.dart` |
| `prod` | MultiBook | `com.multibook.app` | `com.multibook.app` | `lib/entry_points/main_prod.dart` |

Flavor configuration is generated by `flutter_flavorizr`. The DEV build shows a visible `DEV` banner. Each flavor has separate native application identification, API base URL, Firebase application, and Maps configuration.

Active Dart define values:

- `MULTIBOOK_DEV_API_BASE_URL`
- `MULTIBOOK_PROD_API_BASE_URL`
- `MULTIBOOK_PROD_GOOGLE_SERVER_CLIENT_ID`

`MULTIBOOK_API_BASE_URL` remains a compatibility fallback for DEV only. Production configuration does not inherit DEV credentials.

### 6.3 Navigation Guards

`GoRouter` centralizes routes and applies three entry rules:

1. a user who has not completed onboarding remains in the onboarding flow;
2. a user without an active Firebase session is sent to sign-in;
3. an authenticated user is routed according to their `UserType`, and a provider without a business is routed to the Add Business flow.

The router listens to `authStateChanges`, so the protected stack is removed immediately after sign-out. While the profile required to choose the customer/provider home is loading, a small Cupertino loader is used; skeletons are shown only within a known screen and follow its layout.

### 6.4 Root Tabs

Customer and provider use `PersistentTabView` with the shared `CustomBottomNavigation` view:

- floating pill without labels and a top indicator line;
- a white selection segment slides between icons;
- tab content appears without horizontal page animation;
- each tab keeps its own navigation stack and state;
- content extends below the navigation overlay;
- the bar slightly shrinks when scrolling toward the bottom and returns when scrolling toward the top;
- the end of scrollable content receives enough spacing so the last item is not covered.

---

## 7. Identity, Profile, and Session Lifecycle

### 7.1 Authentication

Supported flows:

- registration and sign-in with email and password;
- Google Sign-In;
- password reset;
- reauthentication and password change for password accounts;
- logout and deletion of an unfinished auth account when profile registration fails.

The Firebase user represents identity and credential providers. The application profile, role, phone number, date of birth, avatar path, address, city, and `selectedBusinessId` are read through `/v1/users/me`.

### 7.2 User API

| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/v1/users/me` | Load the current profile |
| `PATCH` | `/v1/users/me` | Update profile and location data |
| `PUT` | `/v1/users/me/role` | Set the customer/provider role |
| `PUT` | `/v1/users/me/selected-business` | Change the active provider business |

The API associates the profile with the authenticated session. The client does not send an arbitrary user ID for operations on its own profile.

### 7.3 Sign-Out and Active Streams

SSE and other session-scoped streams must be closed before the auth session ends:

1. The UI removes the protected navigation stack.
2. `SessionStreamRegistry.cancelAll()` cancels dashboard, earnings, and chat subscriptions.
3. The registry rejects a new subscription that a delayed async flow attempts to open during sign-out.
4. Notification device registration is removed.
5. Firebase Auth ends the session.

This order prevents authorization requests after sign-out and prevents emitting state into an already closed Cubit. After each asynchronous boundary, the code checks whether the Cubit or event handler can still emit.

### 7.4 Location

- `geolocator` requests runtime permission in the customer home flow.
- Nominatim/OpenStreetMap performs reverse geocoding from coordinates into an address and city.
- The city is normalized before discovery requests; the same city does not trigger parallel or repeated fetches.
- Business location is selected on Google Maps.
- **Open in Maps** uses `url_launcher` to open an external maps application.

---

## 8. Media Storage

Images are selected from the gallery or camera, compressed to WebP where appropriate, and uploaded to Firebase Storage. Business data references a storage path, for example:

```text
profiles/{userId}/profile.webp
businesses/{ownerId}/{businessId}/{fileName}
```

Media contract rules:

- Application data does not use a Firebase download URL as a persistent value.
- The API returns a storage path as the persistent value.
- Flutter resolves the path to the current download URL when displaying the image.
- A direct `https` URL is allowed for development seed images and is passed through without a Storage lookup.
- Before a REST create/update request, a download URL is normalized back into a storage path.
- An existing network image is not uploaded again unless it has been replaced.
- The business gallery remains limited to seven additional photos.
- Storage rules and authenticated paths restrict upload, modification, and deletion.

This contract prevents the database from being coupled to a revocable download URL token and allows the media delivery method to change without modifying business records.

---

## 9. Business Domain

`BusinessModel` is the shared application model for stay and service aggregates. It contains identity, owner, type, name, category, description, location, media references, currency, active state, rating, review count, featured collections, and an active promotion signal. Type-specific content is stored in `stayDetails` or `serviceDetails`.

### 9.1 Provider Business API

| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/v1/businesses` | Lightweight owner-only summaries for selectors and lists |
| `GET` | `/v1/businesses/{businessId}` | Full owner-only aggregate for the editor |
| `POST` | `/v1/businesses` | Create a business |
| `PUT` | `/v1/businesses/{businessId}` | Fully replace the editable aggregate |
| `DELETE` | `/v1/businesses/{businessId}` | Archive a business |

The list intentionally does not return all nested data. Before editing, the editor loads the full aggregate so an update does not unintentionally remove rooms, amenities, extras, offerings, staff, or availability data that are not part of the summary response.

Business type is immutable after creation. Items with historical booking/appointment references are deactivated or archived instead of being physically deleted.

### 9.2 Stays

A stay supports single-unit and multiple-unit inventory:

- a single-unit booking occupies the entire accommodation for the date range;
- multiple-unit availability is calculated per room type and its capacity;
- rooms contain name, price, capacity, area, quantity, and active state;
- amenities and extras belong to the business aggregate;
- an extra can be charged once, per night, or per hour.

Stay featured collections are selected explicitly by the provider because one accommodation may belong to multiple contexts, such as city break, beachfront, mountain, family, romantic, or pet-friendly.

### 9.3 Services

A service business contains:

- service offerings with a name, price, duration, and add-ons;
- one or more staff members;
- the relationship between staff and the services they can perform;
- weekly availability per staff member;
- manual availability blocks;
- a commission rate used to calculate staff earnings.

An appointment occupies consecutive 30-minute slots based on the total duration of the selected services. Availability is always checked for the specific staff member.

### 9.4 Creating and Editing

The Add Business BLoC manages validation, media selection, location, stay inventory, or service offerings. Create and edit use the same form shape and the same typed aggregate. Server UUIDs of existing nested entities preserve identity during updates, while new local draft IDs receive server IDs after saving.

Development seed actions use provider-only endpoints `/v1/development/seed/stays` and `/v1/development/seed/services`. The backend exposes them only when `APP_ENV=development`.

---

## 10. Customer Features

### 10.1 Discovery, Home, and Explore

Customer discovery uses lightweight business projections from the REST API:

| Endpoint | Purpose |
|---|---|
| `GET /v1/discovery/businesses` | Paginated popular/global stays or services |
| `GET /v1/discovery/cities` | Persistent, deduplicated city catalog |
| `GET /v1/discovery/featured-collections` | Curated stay/service collections and l10n keys |
| `GET /v1/discovery/recommended-stays` | Up to three personalized stay recommendations |
| `GET /v1/discovery/search` | Prefix search by name or city |
| `GET /v1/discovery/businesses/{businessId}` | Full active customer detail aggregate |

Popular Near You uses the normalized customer city. Recommended stays prioritize that city and fill the remainder with a global ranking based on rating and review count. Explore supports separate stay/service views, selection of all cities, categories, featured collections, trending content, and recently viewed items.

### 10.2 Search and Filters

- Text search uses debounce so typing does not generate a request for every character.
- `GET /v1/stays/search` handles stay filters, availability, sorting, and pagination.
- `GET /v1/services/search` handles service category, date, time, city, price, collection, sorting, and pagination.
- The client sends only filters activated by the user.
- Service search returns a business only if at least one matching staff member has the full required consecutive time range.
- Filters and pagination state remain in the Cubit, not in the view.

### 10.3 Stay Booking

1. Detail shows the media gallery, location, map, rooms, amenities, extras, and reviews.
2. The customer selects check-in, check-out, guests, and, when required, a room type.
3. `GET /v1/businesses/{businessId}/stay/availability` returns only unavailable ranges without exposing other users' booking data.
4. The Review screen calculates an informational preview.
5. `POST /v1/businesses/{businessId}/stay/bookings` revalidates availability, price, extras, promotion, fee, and tax, and creates a confirmed booking.
6. The customer reads the list through `GET /v1/bookings` and cancels their own confirmed booking through `PATCH /v1/bookings/{bookingId}/cancel`.

The server is authoritative for the final total, promotion consumption, confirmation code, and payment status. A multiple-unit date is considered unavailable only when the capacity of the selected room type is fully booked.

### 10.4 Service Appointment

1. Detail shows offerings, durations, prices, staff, location, and reviews.
2. The customer selects one or more services and a staff member.
3. `GET /v1/businesses/{businessId}/service/staff/{staffId}/available-slots` returns bookable start minutes for the total selected duration.
4. During creation, the backend rechecks weekly availability, manual blocks, and existing appointments.
5. `POST /v1/businesses/{businessId}/service/appointments` atomically creates the appointment and reserves the time.
6. The customer uses `PATCH /v1/appointments/{appointmentId}/status` for cancellation and `/reschedule` to change the time.

A customer can reschedule an appointment once. The provider has separate status and rescheduling rules. During reschedule validation, the current appointment is excluded from conflict detection.

### 10.5 Drafts

For the currently signed-in customer, there can be at most one booking draft and one appointment draft:

- `GET`, `PUT`, `DELETE /v1/drafts/booking`
- `GET`, `PUT`, `DELETE /v1/drafts/appointment`

A missing draft is an expected empty state. Successful checkout removes the corresponding draft. Resuming the flow reloads the active business detail so a saved selection cannot bypass current prices and availability.

### 10.6 Saved and Recently Viewed

Saved endpoints allow listing, checking, idempotent saving, and removal of businesses under `/v1/saved-businesses`. The list always returns the current business projection. A local broadcast after a successful mutation immediately synchronizes the list and heart state across open screens.

`PUT /v1/recently-viewed/{businessId}` records a view, while `GET /v1/recently-viewed` returns up to 30 most recent active business projections. No network realtime channel is opened for these local UI invalidations.

### 10.7 Reviews

- `POST /v1/businesses/{businessId}/reviews` accepts source, type, rating, and an optional comment.
- `GET /v1/businesses/{businessId}/review-status` checks whether the customer has already submitted a review.
- `GET /v1/businesses/{businessId}/reviews` returns newest-first pages.

The API determines the customer and business from the source booking or appointment. A review is allowed only after a completed reservation and can exist at most once per customer and business.

### 10.8 Payment Methods and Checkout

Saved payment methods use `/v1/payment-methods` for listing, creation, setting the default method, and deletion. The API accepts only display metadata: brand, last four digits, expiry, and cardholder name. The full card number and CVV never leave the device and are not stored.

The current payment UI supports card, Apple Pay, Google Pay, and cash as checkout experiences, but it is not connected to a production payment processor. Server-side charging and tokenization remain required before real online payments.

### 10.9 Help Center

The customer creates and reads their own support tickets through `GET/POST /v1/support-tickets`. The client sends category, title, and message; identity, contact data, and the initial `open` status are not client-editable values. The list refreshes when opened and after the create action. Statuses are `open`, `inProgress`, and `resolved`.

---
## 11. Provider Features

### 11.1 Dashboard and Earnings

The dashboard shows active reservations, current revenue, reservation count, average rating, and daily charts. Earnings supports current/past week, current/past month, current/last year, and a custom range, while service businesses also support a staff filter.

The client receives ready-made metric snapshots and does not aggregate reservation lists locally. Money remains in integer minor units throughout the API and models; formatting into a decimal display is handled by a shared currency formatter.

Revenue rules:

- cash confirmed/completed reservations are included as expected revenue;
- an online reservation is included after `payment_status=paid`;
- `noShow` excludes revenue and the corresponding aggregates;
- the date is attributed to the reservation's `created_at` timestamp;
- a custom period uses validated `utcOffsetMinutes` for local calendar boundaries;
- an appointment stores historical `providerCommissionRate` and `providerEarnings`, so changing the commission later does not alter past results.

Dashboard and earnings have a REST snapshot endpoint and an SSE stream endpoint under `/v1/businesses/{businessId}`.

### 11.2 Bookings and Appointments

The provider uses paginated `/v1/bookings` and `/v1/appointments` routes with `business_id` and status filters. Before reading or modifying data, the API verifies ownership of the active business.

- A stay booking can be `confirmed`, `declined`, `cancelled`, `completed`, or `noShow`.
- The provider can complete or decline a reservation and mark an allowed completed cash case as no-show.
- Appointment management includes customer details, status, rescheduling, contact, and no-show rules.
- Provider rejection uses `declined`, while customer cancellation uses `cancelled`.

### 11.3 Availability & Calendar

The stay calendar displays confirmed ranges while accounting for single/multiple-unit capacity. The service calendar displays weekly availability, existing appointments, and manual blocks per staff member.

Manual blocks use endpoints under:

```text
/v1/businesses/{businessId}/service/staff/{staffId}/availability-blocks
```

A block is a time range that does not contain customer data. A free slot can be blocked and later unblocked. Opening an occupied appointment may display authorized customer contact details.

### 11.4 Promotions & Discounts

Promotions are business-scoped resources under `/v1/businesses/{businessId}/promotions`. Supported types are percentage, fixed amount, and coupon code. A promotion contains a period, value, minimum amount, optional stay minimum nights, usage limit, and active state.

- The feed uses only the `isPromotionActive` signal for the badge.
- Checkout loads the active promotion or validates an entered coupon through the `/active` endpoint.
- Automatic discounts and coupons are validated on the backend.
- Booking or appointment creation applies and records the consumed promotion together with the reservation.
- The API recalculates subtotal, discount, fee, tax, total, and provider earnings; the client preview is not authoritative.
- The reservation snapshot stores the original and discounted amounts for historical consistency.

### 11.5 Business Management

**My Businesses** allows creating, selecting the active business, and archiving. **Manage Stays & Services** loads the full aggregate before editing. Changing the active business invalidates dashboard, earnings, bookings, and calendar context so each feature loads data for the same `selectedBusinessId`.

---

## 12. Chat and Realtime Behavior

A conversation is uniquely identified by a customer and a specific business. The mobile model includes conversation metadata, messages, read state, typing, and presence.

### 12.1 API

| Method | Endpoint | Purpose |
|---|---|---|
| `POST` | `/v1/conversations` | Retrieve or create a conversation |
| `GET` | `/v1/conversations` | Keyset-paginated conversation list |
| `GET` | `/v1/conversations/unread-count` | Total unread count for the participant |
| `GET` | `/v1/conversations/{id}` | Authorized conversation detail |
| `GET` | `/v1/conversations/{id}/messages` | Keyset-paginated messages |
| `POST` | `/v1/conversations/{id}/messages` | Idempotent message sending |
| `PATCH` | `/v1/conversations/{id}/read` | Advance the read boundary |
| `PUT` | `/v1/conversations/{id}/typing` | Refresh or remove the typing lease |
| `PUT` | `/v1/conversations/{id}/presence` | Refresh or remove the active-viewer lease |
| `GET` | `/v1/chat/stream` | Participant-scoped SSE invalidations |

The client generates message UUIDs, which keeps retries of the same send operation idempotent.

### 12.2 SSE Strategy

The chat stream sends `chat_sync` and `chat_changed` invalidations, not message content. After an event, the repository loads a new authorized REST snapshot. This decision:

- keeps authorization and response mapping on a single HTTP read path;
- does not transmit message content through the invalidation event;
- allows reliable reconnect with an initial `chat_sync` event;
- avoids a global WebSocket lifecycle.

Unread and conversation streams are active only while the corresponding screen uses them. Returning the application to the foreground triggers a one-time refresh, while a foreground chat FCM event can immediately invalidate the view. Periodic chat polling is not used.

### 12.3 Presence, Typing, and Push

Presence and typing are short-lived states refreshed by the active screen. If the recipient is active in the same conversation, they do not receive an unnecessary unread or push signal. The Seen indicator is displayed only next to the last outgoing message read by the recipient. Chat push does not create a duplicated in-app notification item.

---

## 13. Notifications

### 13.1 API Behavior

The mobile application uses the following notification endpoints:

| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/v1/notifications` | Paginated user list |
| `GET` | `/v1/notifications/unread-count` | Number of unread items |
| `PATCH` | `/v1/notifications/{id}/read` | Mark the user's own item as read |
| `PUT` | `/v1/notification-devices/{deviceId}` | Register or refresh an FCM token |
| `DELETE` | `/v1/notification-devices/{deviceId}` | Remove a device registration |

A booking or appointment event may produce an in-app item and an FCM push. A failed push delivery does not change an already successful business action, and a repeated event must not produce a duplicate notification item.

The provider receives events for a new reservation or a customer-cancelled reservation. The customer receives relevant provider status changes. The customer does not receive a notification for their own cancellation action.

### 13.2 Flutter Responsibilities

- `NotificationDeviceService` manages permission, the FCM token, token refresh, and device registration through REST.
- The service exposes separate streams for foreground messages and notifications used to open the application.
- `NotificationCoordinator`, started from `bootstrap.dart`, connects an opened notification event with navigation.
- `NotificationRouter` validates the payload in one place and maps the type to a GoRouter destination.
- The same router is used by both an FCM tap and a tap on the in-app notification list.
- `NotificationBellCubit` reads unread count from REST; foreground FCM triggers an immediate refresh, while the 30-second refresh remains a fallback mechanism.

The FCM payload is a signal, not a reliable business record. After navigation, the screen loads the current data through the API.

---

## 14. Mobile Application Security

- Every `/v1` route verifies the Firebase ID token.
- The mobile client does not treat a user ID from the local model as authentication proof.
- Customer and provider screens call only endpoints intended for the active role and business context.
- The availability endpoint returns free/unavailable state without exposing other users' reservation data.
- A review source must belong to the signed-in customer and the selected business.
- Prices, discounts, totals, commission, and availability are recalculated on the server.
- The full card number and CVV are not part of the REST contract or persistent storage.
- The mobile client does not contain a database service key or direct database access.
- API, Firebase, Maps, and signing credentials are not stored in Git.
- Flavor-specific `google-services.json`, `GoogleService-Info.plist`, and `Secrets-*.xcconfig` files are ignored.
- Storage rules restrict upload type, size, and ownership.

---

## 15. Performance, Reliability, and Costs

| Decision | Effect |
|---|---|
| Paginated list endpoints | Limited response size and memory footprint |
| Lightweight discovery/business projections | Nested aggregate is loaded only for detail or edit |
| Debounced search | Fewer HTTP requests while typing |
| Server-side filters and availability | Client does not download large sets for local filtering |
| SSE invalidations | Live UI without continuous short-interval polling |
| Snapshot reload after invalidation | One authorized read path and simpler reconnect |
| Feature-scoped streams | Connections exist only while the UI uses them |
| Centralized stream cleanup | No reconnects or requests after sign-out |
| Minor units for money | No floating-point calculation errors |
| Stable Storage path | Database does not depend on a temporary download token |
| WebP compression, max 1080, and limited gallery | Smaller upload, bandwidth, and Storage footprint |
| Idempotent create/send operations | Safer retry on unstable networks |
| Local broadcast for Saved/Recently Viewed | Immediate UI update without another persistent connection |

`SseConnection` uses bounded exponential backoff and reestablishes the stream after a transport interruption. The initial snapshot or sync event allows the client to recover without relying on events missed while offline.

Skeleton shimmer is used for the initial loading of content screens. An action loader remains for submit, pagination, and message sending because the existing content should stay visible in those cases.

---

## 16. Design System and Localization

### 16.1 Theme

MultiBook supports light and dark themes. `ThemeCubit` changes `MaterialApp.themeMode`, and the selection is stored in Shared Preferences.

- The light background uses a green-teal gradient through `AppBackground`.
- Cards and forms use theme surface values for readability.
- The floating navigation surface is aligned with the background.
- Foreground, muted, border, navigation, and surface colors come from `AppPalette`.
- Brand accent and semantic status colors are centralized in `AppColors`.
- Text on primary/status surfaces uses the contrasting color defined by the design system.
- Colors are not arbitrarily hardcoded in view files.

### 16.2 Shared Components

`AppBackground`, `CustomAppBar`, `CustomButton`, `CustomTextfield`, `CustomBottomNavigation`, `SkeletonShimmer`, `SearchableCityPickerSheet`, and other reusable components ensure consistent layout, feedback, and theme behavior across features.

### 16.3 Localization

Flutter `gen-l10n` generates the typed `AppLocalizations` API from:

```text
lib/l10n/app_bs.arb
lib/l10n/app_en.arb
lib/l10n/app_de.arb
lib/l10n/app_es.arb
lib/l10n/app_fr.arb
lib/l10n/app_it.arb
```

Bosnian is the initial and fallback language. `LocaleCubit` changes the locale without restarting, while `LocaleRepository` stores the selection locally. New user-facing text is added to all ARB catalogs; plural, select, and dynamic values use ICU messages.

---

## 17. Local Development and Build

### 17.1 Flutter

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
```

Running DEV:

```bash
flutter run \
  --flavor dev \
  --target lib/entry_points/main_dev.dart \
  --dart-define=MULTIBOOK_DEV_API_BASE_URL=http://localhost:8080
```

A PROD build must receive separate production values:

```bash
flutter build appbundle \
  --flavor prod \
  --target lib/entry_points/main_prod.dart \
  --dart-define=MULTIBOOK_PROD_API_BASE_URL=https://api.example.com \
  --dart-define=MULTIBOOK_PROD_GOOGLE_SERVER_CLIENT_ID=<client-id>
```

Native flavor configuration is regenerated with:

```bash
dart run flutter_flavorizr
```

### 17.2 Local Credentials

| Platform | DEV | PROD |
|---|---|---|
| Android Firebase | `android/app/src/dev/google-services.json` | expected `android/app/src/prod/google-services.json` |
| iOS Firebase | `ios/Runner/dev/GoogleService-Info.plist` | expected `ios/Runner/prod/GoogleService-Info.plist` |
| Android Maps | `MULTIBOOK_DEV_GOOGLE_MAPS_API_KEY` in `android/local.properties` | `MULTIBOOK_PROD_GOOGLE_MAPS_API_KEY` |
| iOS Maps | `ios/Flutter/Secrets-dev.xcconfig` | `ios/Flutter/Secrets-prod.xcconfig` |

Credential files remain local or are delivered through a secure CI secret mechanism. DEV Firebase and Maps credentials are currently installed. Before a production build, separate PROD files must be added and the iOS copy script must be adjusted to use the prod plist; the existing script intentionally stops the PROD build until that configuration is completed.

### 17.3 Platform Notes

- iOS requires camera/photo usage descriptions for `image_picker`.
- Google Maps SDK and its key must be configured separately per platform and flavor.
- FCM on a physical iOS device requires a valid APNs configuration.
- A full rebuild is required after changing a native plugin or flavor configuration.
- `lib/main.dart` exists only as a compatible DEV entrypoint; standard run/build commands should specify the flavor and target.

---

## 18. Verification and Observability

Minimum mobile verification before delivery:

```bash
flutter analyze
```

Critical manual scenarios:

1. email and Google authentication, role change, and logout;
2. create/edit/archive stay and service businesses with media;
3. discovery, text search, and combined filters;
4. booking and appointment create, cancel, status, and reschedule;
5. multiple-unit capacity and service slot conflicts with multiple staff members;
6. promotion preview and server-authoritative checkout;
7. changing the active business across dashboard, earnings, bookings, and calendar;
8. chat pagination, typing, presence, seen, unread, and reconnect;
9. in-app notification list, unread indicator, and FCM opening;
10. light/dark theme, localization, and both flavor builds.

The mobile networking and repository layers use `dart:developer` logs for diagnostics. In debug builds, `ApiClient` logs method, URI, status, and response without requiring the presentation layer to log transport details.

---

## 19. Known Limitations

- Card, Apple Pay, and Google Pay currently represent a checkout UI flow, not production charging. A PCI-compliant payment provider, tokenization, webhook verification, and server-authoritative payment status are required.
- Production still requires a defined Crashlytics/analytics policy, alerting, centralized metrics, log retention, and budget thresholds.
- Production Firebase, Maps, API URL, signing, and APNs credentials must be separated from the DEV environment and delivered through a secure release process.
- Android release currently uses debug signing configuration; before distribution, a production keystore must be connected through secure CI or local signing setup.

---

## 20. Reference Files

- [pubspec.yaml](pubspec.yaml) — Flutter dependencies and asset configuration.
- [flavorizr.yaml](flavorizr.yaml) — DEV/PROD flavor definition.
- [lib/bootstrap.dart](lib/bootstrap.dart) — shared startup.
- [lib/app.dart](lib/app.dart) — global widget, theme, locale, and router.
- [lib/src/core/networking](lib/src/core/networking) — REST and SSE transport.
- [lib/src/domain](lib/src/domain) — repository contracts and use cases.
- [lib/src/data](lib/src/data) — models, adapters, and repository implementations.
- [lib/src/features](lib/src/features) — customer, provider, and shared features.
- [lib/src/router](lib/src/router) — application routes.
- [storage.rules](storage.rules) — Firebase Storage authorization rules.
- [../MultiBook-Backend/README.md](../MultiBook-Backend/README.md) — separate backend architecture and operational documentation.
- [../MultiBook-Backend/api/openapi](../MultiBook-Backend/api/openapi) — available machine-readable API descriptions.
