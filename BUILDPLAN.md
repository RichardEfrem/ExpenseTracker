# Build Plan — Local Expense Tracker

**Sources:** CLAUDE.md (rules, binding) · PRD.md (what) · DESIGN.md (how it looks; overrides the PRD where DESIGN §11 says so)
**Target:** Flutter 3.44 / Dart 3.12, Android 8.0+ (minSdk 26) only, offline, IDR, English.

## 0. How to use this plan

- Phases run in order. Each ends with the **Phase Gate** (§1). A phase is not done until its gate is green.
- Build every slice **inside-out** (CLAUDE §1): Entity → Repository interface → UseCase → Model → DataSource → RepositoryImpl → wiring providers → Notifier → Pages/Widgets.
- Add a package only in the phase that first needs it.
- One commit per completed step; moves (`git mv`) and behaviour changes never share a commit.
- **PRD ↔ DESIGN conflicts:** DESIGN wins. Expenses show `−Rp` in default text color, income `+Rp` in green; tabs are Home · Activity · Reports · More; RPT-07 lives on the Accounts screen.

## 1. Phase Gate (run at the end of every phase)

1. `dart run build_runner build -d` — generated code is current.
2. `dart format --output=none --set-exit-if-changed lib test`
3. `flutter analyze` — zero issues (infos included).
4. `flutter test` — all green, including `architecture_test.dart` and all earlier phases' tests (regression).
5. Migration tests pass if the schema changed (`drift_dev` schema snapshots in `drift_schemas/`).
6. `flutter build apk --debug` succeeds.
7. **Manual smoke** on an Android emulator (API 26 and latest): the phase's checklist below, in light and dark mode. From Phase 1 onwards also at 200% font scale and 360 dp width.
8. Temporary tests deleted (CLAUDE §5). Only permanent tests remain.
9. Commit: `Phase N: <name>`.

**Permanent test categories** (grow every phase):
- `test/architecture_test.dart`
- Unit: pure logic (period math, money format, expression parser, recurrence, stats formulas)
- Data: repository + datasource tests on in-memory Drift (`NativeDatabase.memory()`)
- Payload: every `{Name}Input.toJson` and backup DTO, with null-vs-omitted pinned
- Parsing: backup files, `PagedResult`, error mapping
- Notifier: `ProviderContainer` with `overrides` (use-case fakes via `mocktail`)
- Widget: key flows (add, delete+undo, filter, drill-down)
- Migration: every schema version step
- Performance (tag `perf`, run with `flutter test --tags perf`): 10k and 100k seeded rows

## 2. Target structure

```text
lib/
  main.dart                       ProviderScope + runApp
  app.dart                        MaterialApp.router, theme, l10n
  core/
    database/   app_database.dart, tables/, migrations/, seed.dart, connection.dart
    error/      failure.dart (sealed, freezed), guard.dart
    pagination/ paged_result.dart
    router/     app_router.dart, app_paths.dart, app_shell.dart (NavigationBar + FAB)
    theme/      app_colors.dart, finance_colors.dart, app_theme.dart, app_text_theme.dart, motion.dart
    constants/  dimens.dart
    l10n/       app_en.arb (+ generated)
    utils/      local_date.dart, period.dart, money_format.dart, clock.dart, uuid.dart
    widgets/    money_text.dart, empty_state.dart, icon_circle.dart, amount_keypad.dart,
                app_error_page.dart, count_up_text.dart
  features/
    settings/        single slice: preferences, More page
    categories/      single slice
    accounts/        single slice (minimal in MVP, full in v1.0)
    period/          single slice: shared selected period + PeriodSelector
    transactions/    transaction/ (CRUD, add/edit, detail), activity/ (list, search, filter)
    reports/         shared/ (ReportsLocalDataSource, ReportScope, ChartStyle),
                     statistics/, category_breakdown/, trends/, daily/,
                     compare/, calendar/, category_trend/
    home/            single slice: dashboard
    backup/          backup/ (JSON export/restore/erase), csv_export/, csv_import/ (v1.x)
    recurring/       single slice (v1.0)
    app_lock/        single slice (v1.0)
    onboarding/      single slice (v1.0)
    tags/            single slice (v1.x)
test/
  architecture_test.dart
  core/…  features/<module>/<slice>/…   (mirrors lib/)
```

Every module has `<m>_routes.dart`, `<m>_domain.dart`, `<m>_data.dart`, `<m>_presentation.dart` (only `export … show …`). Cross-module imports go only through these.

---

# MVP (P0)

## Phase 0 — Foundation and guardrails

**Goal:** a clean, Android-only, rule-enforced skeleton that builds and passes an empty gate.

1. `git init`, commit the `flutter create` output as-is.
2. Remove non-Android platforms: `git rm -r ios macos web windows linux` (own commit).
3. Android config: `minSdk 26`, app label "Expense Tracker", `applicationId`. Main `AndroidManifest.xml` has **no** `INTERNET` permission (debug/profile manifests keep it for hot reload). `android:allowBackup="false"` + `dataExtractionRules` excluding the DB (PRD §6.4).
4. Dependencies: `flutter_riverpod`, `riverpod_annotation`, `go_router`, `drift`, `drift_flutter`, `path_provider`, `freezed_annotation`, `json_annotation`, `fpdart`, `intl`, `uuid`, `flutter_localizations`. Dev: `build_runner`, `riverpod_generator`, `freezed`, `json_serializable`, `drift_dev`, `mocktail`.
5. `analysis_options.yaml`: `flutter_lints` + `always_use_package_imports`, `prefer_const_constructors`, `avoid_dynamic_calls`, `unawaited_futures`; `strict-casts`, `strict-inference`, `strict-raw-types`; exclude `*.g.dart`, `*.freezed.dart`.
6. `l10n.yaml` → `lib/core/l10n/app_en.arb`, `app_title` key only.
7. Core skeleton: `Failure` (sealed: `DatabaseFailure`, `ValidationFailure`, `NotFoundFailure`, `FileFailure`, `BackupFailure`, `UnexpectedFailure`), `guard()`, `PagedResult<T>`, `Clock` provider (injectable "now" for tests), `main.dart` / `app.dart` with `MaterialApp.router` on a placeholder route.
8. Delete `test/widget_test.dart` (counter test).
9. **`test/architecture_test.dart`** — file scan of `lib/` and `test/` enforcing CLAUDE §1 and §5:
   - placement: every file under `lib/core/**` or `lib/features/<m>/…` in an allowed layer folder (or `main.dart`/`app.dart`)
   - layer rules: `domain` imports no Flutter/Riverpod/`data`/`presentation`; `data` no `presentation`; `presentation` imports from `data` only `<slice>_providers.dart`
   - `core` imports no feature, except `core/router/app_router.dart` importing `<m>_routes.dart`
   - cross-module imports only via `<m>_{domain,data,presentation}.dart`, matching the importer's layer
   - public API files contain only `export … show …` lines
   - slice import graph is acyclic; nothing imports into `shared/` from outside its module; `shared/` imports no sibling slice
   - all imports are `package:expense_tracker/…`
   - test mirror: every test file's directory exists under `lib/` (except `architecture_test.dart`)
   - The rule functions are also unit-tested against small in-memory fake file trees, so we know each rule actually fails on a violation.

**Tests:** architecture test + its self-tests; `guard()` maps each exception type; `PagedResult` equality.
**Smoke:** app launches to a blank placeholder in airplane mode.

## Phase 1 — Design system and app shell

**Goal:** DESIGN §4–§6 tokens, shared widgets and the 4-tab shell. Screens are placeholders.

1. Bundle **Inter** variable font in `assets/fonts/` (download from the rsms/inter release, OFL) — no `google_fonts`. Add `material_symbols_icons`.
2. `core/theme/`: light/dark `ColorScheme` from DESIGN §4.1–4.2; `FinanceColors` `ThemeExtension` (income, expense, transfer, warning, category palette light/dark); text theme §4.4; shapes/radii §4.5 (FAB 20 dp, cards 16 dp with 1 dp outline, sheets 28 dp); motion constants §4.6 and a `reduceMotion(context)` helper honouring `MediaQuery.disableAnimations`.
3. `core/constants/dimens.dart`: 4 dp grid, paddings, 64 dp rows, 48 dp targets.
4. `core/utils/money_format.dart` (`MoneyFormat`): full `Rp 1.250.000`, signed with true minus `−` (U+2212), compact `Rp 12,5M`, % change `▲ 12,4%`. `local_date.dart`: date-only value type (`YYYY-MM-DD`).
5. `core/widgets/`: `MoneyText` (tabular figures, sign, semantic color, TalkBack label "minus 45 thousand rupiah", `FittedBox` for hero), `EmptyState` (§7.10), `IconCircle` (36 dp, 100% fill light / 24% tint dark), `AmountKeypad` (§7.5 layout, haptics, reused later by PIN and onboarding), `CountUpText`, `AppErrorPage`.
6. Router: `StatefulShellRoute` with Home · Activity · Reports · More (`AppPaths` constants in core). `AppShell` with `NavigationBar` + large FAB on Home/Activity. Back from a root tab → Home → exit. Modules `home`, `transactions`, `reports`, `settings` created with `<m>_routes.dart` and placeholder pages. All labels in `app_en.arb`.

**Tests:** `MoneyFormat` table tests (zero, negatives, 999, 1.000, 12.500.000, compact boundaries, U+2212); contrast test computing WCAG ratios for every DESIGN text pair (≥ 4.5:1) and category color vs surface (≥ 3:1) in both themes; `MoneyText` widget test (sign, color, semantics label, tnum); router test (tab switching by path, back behaviour); `AmountKeypad` emits correct key events.
**Smoke:** tabs switch, FAB visible only on Home/Activity, dark mode correct, 200% font at 360 dp has no overflow.

## Phase 2 — Database, settings, categories, default account

**Goal:** schema v1, seeding, preferences, category management (US-03, CAT-01…07).

1. `core/database/`: `AppDatabase` **schema v1** with `accounts`, `categories`, `transactions`, `settings` exactly per PRD §6.2 (include nullable `to_account_id`, `recurring_rule_id`, `receipt_path` now to avoid early ALTERs). Indexes: `transactions(date)`, `(category_id, date)`, `(account_id, date)`, `(type, date)`. UUID v4 text IDs, integer amounts, `date` as `YYYY-MM-DD` text, `created_at`/`updated_at` UTC epoch ms. `onCreate` seeds CAT-03 categories with DESIGN §4.3 icons/colors and the "Cash" account (ACC-02). `appDatabaseProvider` (`keepAlive: true`). Export schema snapshot with `drift_dev` (`drift_schemas/`) and generate the migration test harness.
2. `core/utils/period.dart` (pure Dart): `Period` (start, end inclusive), month with custom start day (e.g. 25 → `25 Aug – 24 Sep`; start day 29–31 clamps in short months), week with configurable first day, year, custom; `previous()`, `next()`, `daysElapsed(today)`, `contains()`.
3. **settings** (single slice): `AppSettings` entity (themeMode, monthStartDay, weekStart, dynamicColor, lastBackupAt); key/value datasource; use cases `WatchSettings`, `UpdateThemeMode`, `UpdateMonthStartDay`, `UpdateWeekStart`; `SettingsNotifier`; More page (DESIGN §8.6, links by path; unbuilt items disabled) and Preferences page. `app.dart` reads theme mode.
4. **categories** (single slice): `Category`, `CategoryInput`; use cases `WatchCategories(type, includeArchived)`, `CreateCategory`, `UpdateCategory`, `ReorderCategories`, `ArchiveCategory`, `UnarchiveCategory`, `DeleteCategory` (fails with `ValidationFailure` if in use → UI offers archive, CAT-05), `MergeCategory(a → b)` (reassign + delete in one DB transaction, CAT-06). Categories page (DESIGN §8.8): Expense/Income tabs, drag reorder, edit sheet with icon grid and the 10-hue palette, "Archived (n)" section. Public API exports `CategoryGrid` for the Add screen.
5. **accounts** (minimal): `Account` entity, `WatchAccounts`, `GetDefaultAccount`. No UI yet.

**Tests:** seed test (14 categories, 1 Cash account, colors/icons match DESIGN); index existence; migration test v1 schema matches snapshot; period math (start day 1/25/31, Feb in leap and non-leap years, week starts Mon/Sun, stepping across year boundary); category repo (archive in use, delete unused, merge atomic incl. rollback on failure, reorder); `CategoryInput.toJson` payload; settings persistence; `SettingsNotifier` via `ProviderContainer`.
**Smoke:** create/rename/recolor/reorder/archive/merge a category; restart app → persisted; theme switch live; change month start day.

## Phase 3 — Add, edit, delete transactions

**Goal:** US-01, 02, 07; TX-01…08 for Expense/Income.

1. **transactions/transaction** slice: `Transaction` entity (type enum incl. `transfer`/`adjustment` for later), `TransactionInput`; validation (amount > 0, note ≤ 200, category required for income/expense) → `ValidationFailure`. Use cases: `AddTransaction`, `UpdateTransaction`, `DeleteTransaction`, `RestoreTransaction` (undo re-inserts the same UUID), `DuplicateTransaction`, `WatchTransaction(id)`, `WatchRecentTransactions(n)`, `GetLastUsed(type)` / `SetLastUsed` (TX-06, stored in the `settings` table via this slice's own datasource). All writes inside DB transactions.
2. `EvaluateAmountExpression` (pure Dart, domain): `+ − × ÷` with precedence, integer-only, ÷ rounds half-up, overflow and divide-by-zero → invalid, live display `25.000 + 12.500 = Rp 37.500`.
3. Add/Edit page (DESIGN §8.2): `SegmentedButton` (Transfer disabled until Phase 7), hero amount, keypad, category grid with last-used preselected and `＋ New`, field chips (date, account hidden while one account, note), Save disabled until valid, haptic + check on save, edit mode with delete icon. FAB tap → `/add?type=expense`, long-press menu → Expense/Income. Container-transform transition (respecting reduce motion).
4. Transaction detail bottom sheet (§8.4): Edit, Duplicate (TX-08), Delete → Undo snackbar 5 s (TX-07).

**Tests:** expression evaluator table tests (precedence, `000` key, leading operator, huge numbers, ÷ rounding); `TransactionInput.toJson` payload (note null vs omitted pinned); repo tests (add/update/delete/restore same id, validation, write atomicity); `AddTransactionNotifier` with overrides; **widget test of the add flow**: open → type `45000` → Food preselected → Save → stored with today's date and Cash (PRD NFR testability); last-used remembered per type; delete + undo restores identical row.
**Smoke:** add expense in ≤ 3 taps + amount (≤ 5 s); add income via long-press; edit; delete + undo; duplicate.

## Phase 4 — Activity: list, search, filter, shared period

**Goal:** TX-09, US-08, SRCH-01…03, DESIGN §7.1, §7.3, §7.4, §7.8, §8.3.

1. **period** module: `SelectedPeriodNotifier` (`keepAlive: true` — deliberately app-lifetime, shared by Home/Activity/Reports), built from `core/utils/period.dart` + settings (via `settings_presentation.dart`). `PeriodSelector` widget + bottom sheet (Week · Month · Year · Custom, `›` disabled for future).
2. **transactions/activity** slice: `TransactionFilter` entity (text, types, categories, accounts, date range, amount range); `WatchActivityPage(filter, monthCursor)` → `PagedResult<DayGroup>` with daily net computed in SQL; `WatchFilterSummary` → count + total (SRCH-03). Text search on note + category name (`LIKE`, case-insensitive).
3. Activity page: search bar, horizontal filter chips with values and `×`, month totals line, sticky day headers (Today / Yesterday / `Mon, 28 Sep`), rows per §7.3, infinite scroll into the previous month, swipe left = delete (Undo), swipe right = duplicate, result bar, empty states.
4. `TransactionFilter` ↔ query-parameter codec so `/activity?category=…&from=…&to=…` opens a pre-filtered list (needed for SRCH-04 in Phase 5).

**Tests:** paging (month boundaries with start day 25, cursor → previous month, empty month, `hasMore`); each filter alone and combined, count/total correctness, search matches note and category; query codec round-trip; `SelectedPeriodNotifier` step/reset; widget test swipe-delete + undo; period selector disables future. **Perf:** month page and filter summary at 10k rows.
**Smoke:** scroll back several months, search, combine filters, clear filters, deep link to a filtered URL.

## Phase 5 — Reports and Home dashboard

**Goal:** US-04, 05, 06; RPT-01…03; PRD §5.1, §5.3; SRCH-04; DESIGN §7.2, §7.9, §8.1, §8.5.

1. **reports/shared**: `ReportScope` (period + account ids), `ReportsLocalDataSource` — every aggregate is a SQL `GROUP BY` (never an in-memory loop), always excluding `transfer` and `adjustment`. `ChartStyle` for `fl_chart` (add `fl_chart`): gridlines, axis text, tooltip, select-dims-others-to-40%, grow-in animation once per visit.
2. Slices (each inside-out, each with its notifier):
   - **statistics**: income, expense, net, Δ/Δ% vs previous period, savings rate (only if income > 0), avg daily spend (days elapsed for current period), projected month-end (current month only), largest expense, most frequent category, no-spend days.
   - **category_breakdown** (RPT-01): expense/income toggle, donut ≤ 6 slices (top 5 + "Other (n)"), ranked list with amount/%/count.
   - **trends** (RPT-02): grouped bars 6/12 months + net line.
   - **daily** (RPT-03): bar per day + dashed average line, today outlined.
3. Reports page: period selector, horizontally scrolling stat cards (tap → definition sheet), tabs Categories · Trends · Daily. Tap element → select + tooltip; second tap → `/activity?…` (SRCH-04). Each chart exposes a TalkBack text summary.
4. **home** module (single slice, consumes `reports_*` and `transactions_*` public APIs): greeting, period selector, hero Net card with Δ, Income/Expense half cards, Top spending (3 horizontal bars), Recent 5 + "See all", count-up totals, empty state. Semantics order = visual order. Every card tappable → filtered report/activity.

**Tests:** SQL aggregation tests on a fixed fixture set (known totals; transfers/adjustments excluded; month start day 25; leap Feb); stats formula edge cases (no income, first day of month, past vs current period); donut grouping into "Other (n)"; chart summary strings; drill-down navigation produces the right filter; Home widget test (content + semantics order, empty state). **Perf:** every report query ≤ 500 ms at 10k rows, ≤ 1.5 s at 100k.
**Smoke:** add a transaction → Home and Reports update instantly (Drift `watch()`); tap a donut slice twice → filtered Activity.

## Phase 6 — Backup, restore, erase (MVP release)

**Goal:** US-09, BAK-01, BAK-02, erase all data; MVP exit.

1. **backup/backup** slice (add `file_picker`, `share_plus`): `BackupFile` entity (schemaVersion, appVersion, exportedAt, accounts, categories, transactions, settings). DTOs with `toJson`/`fromJson`. Use cases: `ExportBackup` (JSON → share sheet / save dialog; records `lastBackupAt`), `PreviewBackup` (counts + date range; unknown version or corrupt file → `BackupFailure`), `RestoreBackup(mode: replace | merge)` (merge by UUID; all in one DB transaction), `EraseAllData` (then re-seed).
2. Backup & data page (DESIGN §8.10, MVP subset): last backup, Export, Restore → preview sheet → Replace (confirm dialog) / Merge; Erase all data with double confirmation.
3. MVP accessibility pass against DESIGN §9 checklist.

**Tests:** **round-trip** (seed random data → export → erase → restore → deep-equal, 100% of records — PRD reliability); merge keeps existing + adds new, no duplicates; replace rolls back fully on a mid-restore failure; payload tests for every DTO; parsing tests (missing fields, wrong types, future schema version, empty file).
**MVP exit:** gate + `flutter build apk --release`; confirm the release APK has no `INTERNET` permission (`apkanalyzer manifest permissions`); cold start ≤ 1.5 s on a mid-range device; sideload and use daily for 2 weeks (PRD §10).

---

# v1.0 (P1)

## Phase 7 — Accounts and transfers

**Goal:** US-10, ACC-01…05, RPT-07, TX-01 Transfer.

- Accounts CRUD (name, type, icon, color, opening balance), archive instead of delete when in use; balance SQL = opening + income − expense ± transfers + adjustments (ACC-03).
- Transfer mode in the Add screen (From → To pickers replace the grid); balance adjustment entry (ACC-05).
- Accounts page (§8.7) with total + balance-over-time line chart (RPT-07).
- Turn on multi-account UI: account chip on Add, account name in rows, Home balance line, Reports "All accounts ▾" scope, Activity account filter.

**Tests:** balance formula per account and total; transfer/adjustment never counted in any report (re-run Phase 5 fixtures with transfers added); transfer validation (from ≠ to); `TransferInput`/`AccountInput` payload; backup round-trip still 100% with transfers.

## Phase 8 — Recurring transactions

**Goal:** US-11, REC-01…04. **Schema v2.**

- Migration v1 → v2: `recurring_rules` (+ table for pending occurrences). Migration test with v1 data preserved.
- Pure-Dart recurrence engine: daily, weekly, monthly on day N (31 → last day, REC-04), yearly (Feb 29 → Feb 28), interval, end date.
- `GenerateDueOccurrences` runs on app open (no background service): auto-create or pending per rule, idempotent via `last_generated_date`, single DB transaction.
- Recurring page (§8.9), pending card on Home ("2 recurring items to confirm"), confirm/skip, `repeat` glyph on generated rows, rule link in detail.
- Backup format bumps its schema version; restore accepts v1 and v2 files.

**Tests:** recurrence table tests (month ends, leap years, DST-free local dates, long gaps); generation idempotent (run twice → no duplicates); pending confirm/skip; migration v1→v2; backup v1 file still restores.

## Phase 9 — Reports v1.0

**Goal:** US-12; RPT-04, 05, 06.

- **category_trend** (RPT-04): up to 4 categories, one line each, under the Trends tab.
- **compare** (RPT-05): table category · this · previous · Δ · Δ%, sorted by |Δ|.
- **calendar** (RPT-06): month grid tinted by daily net (5 green / 5 red steps), tap day → Activity for that day.

**Tests:** SQL tests for each with start-day-of-month variants; compare handles categories present in only one period; calendar bucket thresholds; semantics labels ("28 September, net minus 128 thousand rupiah"). **Perf:** re-run the full perf suite.

## Phase 10 — App lock

**Goal:** US-13, PRD §6.4, DESIGN §8.11.

- Add `local_auth`, `flutter_secure_storage`, `cryptography`. `MainActivity` → `FlutterFragmentActivity`; `USE_BIOMETRIC` permission.
- PIN (4–6 digits) stored as salted PBKDF2 hash; biometric via OS; lock on resume after configurable timeout (injected `Clock`); router redirect to the lock screen; lock screen reuses `AmountKeypad`.
- `FLAG_SECURE` via a small `MethodChannel` in `MainActivity`, only while lock is on.

**Tests:** hash/verify, wrong PIN, timeout logic with fake clock, router redirect when locked, notifier states. Manual: biometric on a real device, recents switcher shows blank.

## Phase 11 — CSV export, backup extras, onboarding (v1.0 release)

**Goal:** US-14, BAK-03…06, onboarding.

- **backup/csv_export** (BAK-06): date range, columns date, type, amount, category, account, note (tags added in Phase 12); RFC 4180 escaping.
- Encrypted backups (BAK-03): AES-256-GCM, PBKDF2 key, password prompt on export/restore.
- Backup reminder (BAK-04): Home `MaterialBanner` after 30 days, configurable/off.
- Weekly auto-backup to a user-chosen folder (BAK-05, Android SAF), run on app open when ≥ 7 days since last (no background service).
- **onboarding** (§8.12): currency, default categories toggle, starting cash; shown once; skippable.

**Tests:** CSV escaping (commas, quotes, newlines, unicode), CSV payload per row; encryption round-trip, wrong password → `BackupFailure`, tampered file detected; reminder logic with fake clock; onboarding shown once and writes opening balance.
**v1.0 exit:** all P1 stories done, 10k-row reports ≤ 500 ms, DESIGN §9 checklist ticked, release APK sideloaded.

---

# v1.x (P2)

Each phase still follows inside-out order and the full gate.

## Phase 12 — Tags and tag report
US-15, RPT-08. **Schema v3**: `tags`, `transaction_tags`. Tag input on Add screen, tag filter in Activity (SRCH-02), Tags tab in Reports, tags column in CSV, backup schema bump. Tests: migration v2→v3, tag totals SQL, backup v1/v2/v3 restore.

## Phase 13 — Receipt photos
US-16. Add `image_picker`; copy image into app private storage, path in `receipt_path`; thumbnail in detail; delete file with transaction (and on undo expiry). Decide then whether backups include receipts (zip) or stay JSON-only. Tests: file lifecycle, orphan cleanup.

## Phase 14 — CSV import
BAK-07. **backup/csv_import** slice: pick file → column mapping → preview → import in one DB transaction; unknown categories created or mapped. Tests: mapping, malformed rows reported, amounts with separators parsed to integers.

## Phase 15 — Home-screen quick-add widget
US-17. Add `home_widget`; native Android widget that deep-links to `/add?type=expense`. Tests: deep-link route; manual widget check on launcher.

---

## 3. Definition of done (every phase)

- [ ] Phase Gate §1 fully green
- [ ] No hardcoded user-facing strings; every new key in `app_en.arb`
- [ ] No `Map<String, dynamic>` in any domain file; writes use `{Name}Input`
- [ ] Repositories/use cases return `Either<Failure, T>` (or `Stream<Either<…>>`); nothing throws into presentation
- [ ] Notifiers call use cases only; `AsyncValue` handled for loading/error/data
- [ ] Every new list/chart has a designed empty state and screen-reader labels
- [ ] Amounts rendered only through `MoneyText` / `MoneyFormat`
- [ ] Nothing duplicated from `core/` or a module's `shared/` (CLAUDE §1.3)

