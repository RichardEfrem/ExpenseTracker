# Expense Tracker

An offline personal expense tracker for Android. Log income and expenses in a few taps, group them by category and account, and see where the money goes through reports and statistics.

There is no account, no server and no sync. All data stays on the phone, and it leaves only when you export a backup file yourself. The app does not request internet permission.

## Features

- Income and expense transactions with category, account, date and note
- Categories and accounts management
- Recurring transactions
- Reports and statistics: totals, trends, category breakdowns and period comparisons
- Optional app lock (PIN or biometric)
- Encrypted backup, restore and CSV export

Amounts are stored as whole rupiah (IDR).

## Built with

- **Flutter** (Dart) for the UI
- **Riverpod** (with `riverpod_generator`) for state management and dependency injection
- **Drift** (SQLite) for the local database
- **go_router** for navigation
- **fpdart** for typed error handling (`Either<Failure, T>`)
- **freezed** and **json_serializable** for immutable models and backup-file JSON
- **fl_chart** for report charts
- **local_auth** and **flutter_secure_storage** for the app lock
- **cryptography** for backup encryption
- **gen-l10n** for localization

The code is organised feature-first (`lib/features/<module>/<slice>/{data,domain,presentation}`), following clean architecture. See [CLAUDE.md](CLAUDE.md) for the architecture rules and [PRD.md](PRD.md) for the product spec.

## Running

```sh
flutter pub get
dart run build_runner build -d
flutter run
```

Run the tests with `flutter test`.
