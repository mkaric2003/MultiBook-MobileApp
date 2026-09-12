# MultiBook

Flutter marketplace application for discovering and booking stays and service appointments. Customers can search, save businesses, manage reservations, review providers, and chat, while providers manage businesses, availability, bookings, promotions, and earnings.

## Getting Started

Requirements: Flutter 3.35.4 and Dart 3.9.2.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
```

Run the development flavor:

```bash
flutter run \
  --flavor dev \
  --target lib/entry_points/main_dev.dart
```

Local Firebase and Maps credentials are required for the corresponding platform and flavor.

## Documentation

See [PROJECT_DOCUMENTATION.md](PROJECT_DOCUMENTATION.md) for the complete product, architecture, feature, configuration, and build documentation. The backend is available in the [MultiBook-Backend repository](https://github.com/mkaric2003/MultiBook-Backend).
