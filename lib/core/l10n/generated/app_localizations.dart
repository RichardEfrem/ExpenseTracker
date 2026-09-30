import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
/// import 'generated/app_localizations.dart';
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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// App name shown in the task switcher and title bar.
  ///
  /// In en, this message translates to:
  /// **'Expense Tracker'**
  String get app_title;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get nav_activity;

  /// No description provided for @nav_reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get nav_reports;

  /// No description provided for @nav_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get nav_more;

  /// No description provided for @fab_add_expense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get fab_add_expense;

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get common_close;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_title;

  /// No description provided for @failure_database.
  ///
  /// In en, this message translates to:
  /// **'Your data couldn\'t be read or saved. Please try again.'**
  String get failure_database;

  /// No description provided for @failure_not_found.
  ///
  /// In en, this message translates to:
  /// **'This item no longer exists.'**
  String get failure_not_found;

  /// No description provided for @failure_file.
  ///
  /// In en, this message translates to:
  /// **'The file couldn\'t be read or written.'**
  String get failure_file;

  /// No description provided for @failure_backup_corrupt.
  ///
  /// In en, this message translates to:
  /// **'This file isn\'t a valid backup.'**
  String get failure_backup_corrupt;

  /// No description provided for @failure_backup_version.
  ///
  /// In en, this message translates to:
  /// **'This backup was made by a newer version of the app.'**
  String get failure_backup_version;

  /// No description provided for @failure_unexpected.
  ///
  /// In en, this message translates to:
  /// **'Something unexpected happened. Please try again.'**
  String get failure_unexpected;

  /// No description provided for @validation_invalid_input.
  ///
  /// In en, this message translates to:
  /// **'Please check the values you entered.'**
  String get validation_invalid_input;

  /// No description provided for @keypad_triple_zero.
  ///
  /// In en, this message translates to:
  /// **'Triple zero'**
  String get keypad_triple_zero;

  /// No description provided for @keypad_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get keypad_delete;

  /// No description provided for @keypad_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get keypad_clear;

  /// No description provided for @keypad_plus.
  ///
  /// In en, this message translates to:
  /// **'Plus'**
  String get keypad_plus;

  /// No description provided for @keypad_minus.
  ///
  /// In en, this message translates to:
  /// **'Minus'**
  String get keypad_minus;

  /// No description provided for @keypad_times.
  ///
  /// In en, this message translates to:
  /// **'Times'**
  String get keypad_times;

  /// No description provided for @keypad_divide.
  ///
  /// In en, this message translates to:
  /// **'Divided by'**
  String get keypad_divide;

  /// Screen-reader text for an amount.
  ///
  /// In en, this message translates to:
  /// **'{words} rupiah'**
  String money_spoken(String words);

  /// No description provided for @money_spoken_negative.
  ///
  /// In en, this message translates to:
  /// **'minus {words} rupiah'**
  String money_spoken_negative(String words);

  /// No description provided for @money_spoken_positive.
  ///
  /// In en, this message translates to:
  /// **'plus {words} rupiah'**
  String money_spoken_positive(String words);

  /// No description provided for @money_scale_billion.
  ///
  /// In en, this message translates to:
  /// **'{count} billion'**
  String money_scale_billion(String count);

  /// No description provided for @money_scale_million.
  ///
  /// In en, this message translates to:
  /// **'{count} million'**
  String money_scale_million(String count);

  /// No description provided for @money_scale_thousand.
  ///
  /// In en, this message translates to:
  /// **'{count} thousand'**
  String money_scale_thousand(String count);

  /// No description provided for @seed_food.
  ///
  /// In en, this message translates to:
  /// **'Food & Drinks'**
  String get seed_food;

  /// No description provided for @seed_transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get seed_transport;

  /// No description provided for @seed_groceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get seed_groceries;

  /// No description provided for @seed_bills.
  ///
  /// In en, this message translates to:
  /// **'Bills & Utilities'**
  String get seed_bills;

  /// No description provided for @seed_shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get seed_shopping;

  /// No description provided for @seed_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get seed_health;

  /// No description provided for @seed_entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get seed_entertainment;

  /// No description provided for @seed_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get seed_education;

  /// No description provided for @seed_housing.
  ///
  /// In en, this message translates to:
  /// **'Housing / Rent'**
  String get seed_housing;

  /// No description provided for @seed_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get seed_other;

  /// No description provided for @seed_salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get seed_salary;

  /// No description provided for @seed_freelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get seed_freelance;

  /// No description provided for @seed_gift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get seed_gift;

  /// No description provided for @seed_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get seed_cash;

  /// No description provided for @common_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get common_delete;

  /// No description provided for @type_expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get type_expense;

  /// No description provided for @type_income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get type_income;

  /// No description provided for @theme_system.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get theme_system;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// No description provided for @weekday_monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekday_monday;

  /// No description provided for @weekday_tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekday_tuesday;

  /// No description provided for @weekday_wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekday_wednesday;

  /// No description provided for @weekday_thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekday_thursday;

  /// No description provided for @weekday_friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekday_friday;

  /// No description provided for @weekday_saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekday_saturday;

  /// No description provided for @weekday_sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekday_sunday;

  /// No description provided for @validation_name_empty.
  ///
  /// In en, this message translates to:
  /// **'Enter a name.'**
  String get validation_name_empty;

  /// No description provided for @validation_name_too_long.
  ///
  /// In en, this message translates to:
  /// **'Use 40 characters or fewer.'**
  String get validation_name_too_long;

  /// No description provided for @validation_category_in_use.
  ///
  /// In en, this message translates to:
  /// **'This category is used by transactions or recurring rules. Archive it instead.'**
  String get validation_category_in_use;

  /// No description provided for @validation_category_type_mismatch.
  ///
  /// In en, this message translates to:
  /// **'You can only merge categories of the same type.'**
  String get validation_category_type_mismatch;

  /// No description provided for @validation_merge_into_self.
  ///
  /// In en, this message translates to:
  /// **'Choose a different category to merge into.'**
  String get validation_merge_into_self;

  /// No description provided for @validation_month_start_day.
  ///
  /// In en, this message translates to:
  /// **'Choose a day from 1 to 31.'**
  String get validation_month_start_day;

  /// No description provided for @validation_week_start.
  ///
  /// In en, this message translates to:
  /// **'Choose a day of the week.'**
  String get validation_week_start;

  /// No description provided for @more_coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get more_coming_soon;

  /// No description provided for @more_section_money.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get more_section_money;

  /// No description provided for @more_section_data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get more_section_data;

  /// No description provided for @more_section_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get more_section_preferences;

  /// No description provided for @more_section_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get more_section_about;

  /// No description provided for @more_accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get more_accounts;

  /// No description provided for @more_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get more_categories;

  /// No description provided for @more_recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get more_recurring;

  /// No description provided for @more_backup.
  ///
  /// In en, this message translates to:
  /// **'Backup & restore'**
  String get more_backup;

  /// No description provided for @more_export_csv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get more_export_csv;

  /// No description provided for @more_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency & format'**
  String get more_currency;

  /// No description provided for @more_month_start_day.
  ///
  /// In en, this message translates to:
  /// **'Month start day'**
  String get more_month_start_day;

  /// No description provided for @more_week_start.
  ///
  /// In en, this message translates to:
  /// **'Week start'**
  String get more_week_start;

  /// No description provided for @more_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get more_theme;

  /// No description provided for @more_app_lock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get more_app_lock;

  /// No description provided for @more_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get more_version;

  /// No description provided for @more_erase_all.
  ///
  /// In en, this message translates to:
  /// **'Erase all data'**
  String get more_erase_all;

  /// No description provided for @pref_title.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get pref_title;

  /// No description provided for @pref_section_format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get pref_section_format;

  /// No description provided for @pref_section_periods.
  ///
  /// In en, this message translates to:
  /// **'Periods'**
  String get pref_section_periods;

  /// No description provided for @pref_section_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get pref_section_appearance;

  /// No description provided for @pref_currency_idr.
  ///
  /// In en, this message translates to:
  /// **'Indonesian Rupiah (Rp)'**
  String get pref_currency_idr;

  /// No description provided for @pref_month_start_value.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String pref_month_start_value(int day);

  /// No description provided for @pref_month_start_example.
  ///
  /// In en, this message translates to:
  /// **'Day {day} · e.g. {example}'**
  String pref_month_start_example(int day, String example);

  /// No description provided for @categories_new_title.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get categories_new_title;

  /// No description provided for @categories_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get categories_edit_title;

  /// No description provided for @categories_new_short.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get categories_new_short;

  /// No description provided for @categories_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get categories_name;

  /// No description provided for @categories_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get categories_color;

  /// No description provided for @categories_icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get categories_icon;

  /// No description provided for @categories_empty.
  ///
  /// In en, this message translates to:
  /// **'No categories yet.'**
  String get categories_empty;

  /// No description provided for @categories_archive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get categories_archive;

  /// No description provided for @categories_unarchive.
  ///
  /// In en, this message translates to:
  /// **'Unarchive'**
  String get categories_unarchive;

  /// No description provided for @categories_archived.
  ///
  /// In en, this message translates to:
  /// **'Archived ({count})'**
  String categories_archived(int count);

  /// No description provided for @categories_transaction_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No transactions} =1{1 transaction} other{{count} transactions}}'**
  String categories_transaction_count(int count);

  /// No description provided for @categories_in_use_title.
  ///
  /// In en, this message translates to:
  /// **'Category in use'**
  String get categories_in_use_title;

  /// No description provided for @categories_in_use_body.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" is used by transactions or recurring rules, so it can\'t be deleted. Archive it to hide it from pickers; it stays in reports.'**
  String categories_in_use_body(String name);

  /// No description provided for @categories_merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get categories_merge;

  /// No description provided for @categories_merge_into.
  ///
  /// In en, this message translates to:
  /// **'Merge into…'**
  String get categories_merge_into;

  /// No description provided for @categories_merge_title.
  ///
  /// In en, this message translates to:
  /// **'Merge \"{name}\" into…'**
  String categories_merge_title(String name);

  /// No description provided for @categories_merge_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Merge categories?'**
  String get categories_merge_confirm_title;

  /// No description provided for @categories_merge_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'All transactions in \"{from}\" move to \"{into}\", then \"{from}\" is deleted. This can\'t be undone.'**
  String categories_merge_confirm_body(String from, String into);

  /// No description provided for @categories_reorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get categories_reorder;

  /// No description provided for @color_orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get color_orange;

  /// No description provided for @color_blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get color_blue;

  /// No description provided for @color_green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get color_green;

  /// No description provided for @color_purple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get color_purple;

  /// No description provided for @color_pink.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get color_pink;

  /// No description provided for @color_teal.
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get color_teal;

  /// No description provided for @color_violet.
  ///
  /// In en, this message translates to:
  /// **'Violet'**
  String get color_violet;

  /// No description provided for @color_amber.
  ///
  /// In en, this message translates to:
  /// **'Amber'**
  String get color_amber;

  /// No description provided for @color_brown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get color_brown;

  /// No description provided for @color_emerald.
  ///
  /// In en, this message translates to:
  /// **'Emerald'**
  String get color_emerald;

  /// No description provided for @color_neutral.
  ///
  /// In en, this message translates to:
  /// **'Gray'**
  String get color_neutral;

  /// No description provided for @common_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_done;

  /// No description provided for @common_undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get common_undo;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @date_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get date_today;

  /// No description provided for @date_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get date_yesterday;

  /// No description provided for @type_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get type_transfer;

  /// No description provided for @type_adjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get type_adjustment;

  /// No description provided for @add_note.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get add_note;

  /// No description provided for @add_note_title.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get add_note_title;

  /// No description provided for @edit_transaction_title.
  ///
  /// In en, this message translates to:
  /// **'Edit transaction'**
  String get edit_transaction_title;

  /// No description provided for @fab_more_types.
  ///
  /// In en, this message translates to:
  /// **'Choose expense, income or transfer'**
  String get fab_more_types;

  /// No description provided for @home_empty.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet. Add your first expense to see your month.'**
  String get home_empty;

  /// No description provided for @detail_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get detail_type;

  /// No description provided for @detail_date_time.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get detail_date_time;

  /// No description provided for @detail_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get detail_account;

  /// No description provided for @detail_note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get detail_note;

  /// No description provided for @detail_created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get detail_created;

  /// No description provided for @transaction_deleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get transaction_deleted;

  /// No description provided for @transaction_duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get transaction_duplicate;

  /// No description provided for @transaction_duplicated.
  ///
  /// In en, this message translates to:
  /// **'Transaction added again'**
  String get transaction_duplicated;

  /// No description provided for @transaction_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get transaction_edit;

  /// No description provided for @transaction_recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get transaction_recurring;

  /// No description provided for @validation_amount_positive.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount greater than zero.'**
  String get validation_amount_positive;

  /// No description provided for @validation_amount_too_large.
  ///
  /// In en, this message translates to:
  /// **'That amount is too large.'**
  String get validation_amount_too_large;

  /// No description provided for @validation_note_too_long.
  ///
  /// In en, this message translates to:
  /// **'Keep the note under 200 characters.'**
  String get validation_note_too_long;

  /// No description provided for @validation_category_required.
  ///
  /// In en, this message translates to:
  /// **'Pick a category.'**
  String get validation_category_required;

  /// No description provided for @validation_account_required.
  ///
  /// In en, this message translates to:
  /// **'Pick an account.'**
  String get validation_account_required;

  /// No description provided for @validation_same_account.
  ///
  /// In en, this message translates to:
  /// **'Choose two different accounts.'**
  String get validation_same_account;

  /// No description provided for @activity_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search notes or categories'**
  String get activity_search_hint;

  /// No description provided for @activity_in.
  ///
  /// In en, this message translates to:
  /// **'In'**
  String get activity_in;

  /// No description provided for @activity_out.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get activity_out;

  /// No description provided for @activity_result_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction} other{{count} transactions}}'**
  String activity_result_count(int count);

  /// No description provided for @activity_no_results.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches these filters.'**
  String get activity_no_results;

  /// No description provided for @activity_clear_filters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get activity_clear_filters;

  /// No description provided for @activity_empty.
  ///
  /// In en, this message translates to:
  /// **'No transactions in {period}. Add your first expense to see it here.'**
  String activity_empty(String period);

  /// No description provided for @activity_period_empty.
  ///
  /// In en, this message translates to:
  /// **'No transactions in this period.'**
  String get activity_period_empty;

  /// No description provided for @filter_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get filter_type;

  /// No description provided for @filter_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get filter_category;

  /// No description provided for @filter_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get filter_account;

  /// No description provided for @filter_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get filter_date;

  /// No description provided for @filter_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get filter_amount;

  /// No description provided for @filter_value.
  ///
  /// In en, this message translates to:
  /// **'{label}: {value}'**
  String filter_value(String label, String value);

  /// No description provided for @filter_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove {label} filter'**
  String filter_remove(String label);

  /// No description provided for @filter_from.
  ///
  /// In en, this message translates to:
  /// **'from {date}'**
  String filter_from(String date);

  /// No description provided for @filter_until.
  ///
  /// In en, this message translates to:
  /// **'until {date}'**
  String filter_until(String date);

  /// No description provided for @filter_amount_min.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get filter_amount_min;

  /// No description provided for @filter_amount_max.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get filter_amount_max;

  /// No description provided for @filter_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get filter_apply;

  /// No description provided for @filter_clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get filter_clear;

  /// No description provided for @period_title.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period_title;

  /// No description provided for @period_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get period_week;

  /// No description provided for @period_month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get period_month;

  /// No description provided for @period_year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get period_year;

  /// No description provided for @period_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get period_custom;

  /// No description provided for @period_previous.
  ///
  /// In en, this message translates to:
  /// **'Previous period'**
  String get period_previous;

  /// No description provided for @period_next.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get period_next;

  /// No description provided for @period_show_year.
  ///
  /// In en, this message translates to:
  /// **'Show {year}'**
  String period_show_year(String year);

  /// No description provided for @period_choose_dates.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get period_choose_dates;

  /// No description provided for @period_current.
  ///
  /// In en, this message translates to:
  /// **'Back to current period'**
  String get period_current;

  /// No description provided for @home_good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get home_good_morning;

  /// No description provided for @home_good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get home_good_afternoon;

  /// No description provided for @home_good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get home_good_evening;

  /// No description provided for @home_net.
  ///
  /// In en, this message translates to:
  /// **'Net · {period}'**
  String home_net(String period);

  /// No description provided for @home_vs.
  ///
  /// In en, this message translates to:
  /// **'{change} vs {previous}'**
  String home_vs(String change, String previous);

  /// No description provided for @home_previous_period.
  ///
  /// In en, this message translates to:
  /// **'previous period'**
  String get home_previous_period;

  /// No description provided for @home_top_spending.
  ///
  /// In en, this message translates to:
  /// **'Top spending'**
  String get home_top_spending;

  /// No description provided for @home_recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get home_recent;

  /// No description provided for @home_see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get home_see_all;

  /// No description provided for @reports_tab_categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get reports_tab_categories;

  /// No description provided for @reports_tab_trends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get reports_tab_trends;

  /// No description provided for @reports_tab_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get reports_tab_daily;

  /// No description provided for @reports_empty.
  ///
  /// In en, this message translates to:
  /// **'No data for {period}.'**
  String reports_empty(String period);

  /// No description provided for @reports_go_to_data.
  ///
  /// In en, this message translates to:
  /// **'Go to last month with data'**
  String get reports_go_to_data;

  /// No description provided for @reports_no_data_yet.
  ///
  /// In en, this message translates to:
  /// **'No earlier transactions yet.'**
  String get reports_no_data_yet;

  /// No description provided for @stat_savings_rate.
  ///
  /// In en, this message translates to:
  /// **'Savings rate'**
  String get stat_savings_rate;

  /// No description provided for @stat_savings_rate_definition.
  ///
  /// In en, this message translates to:
  /// **'Income minus expense, as a share of income. Shown only when there is income.'**
  String get stat_savings_rate_definition;

  /// No description provided for @stat_average_daily.
  ///
  /// In en, this message translates to:
  /// **'Avg/day'**
  String get stat_average_daily;

  /// No description provided for @stat_average_daily_definition.
  ///
  /// In en, this message translates to:
  /// **'Expense divided by the days elapsed in the period (for the current period, up to today).'**
  String get stat_average_daily_definition;

  /// No description provided for @stat_projected.
  ///
  /// In en, this message translates to:
  /// **'Projected'**
  String get stat_projected;

  /// No description provided for @stat_projected_definition.
  ///
  /// In en, this message translates to:
  /// **'Average daily spend times the days in this month: where spending ends if you keep this pace. Current month only.'**
  String get stat_projected_definition;

  /// No description provided for @stat_no_spend_days.
  ///
  /// In en, this message translates to:
  /// **'No-spend days'**
  String get stat_no_spend_days;

  /// No description provided for @stat_no_spend_days_definition.
  ///
  /// In en, this message translates to:
  /// **'Days so far in this period with no expenses.'**
  String get stat_no_spend_days_definition;

  /// No description provided for @stat_days.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String stat_days(int count);

  /// No description provided for @stat_largest_expense.
  ///
  /// In en, this message translates to:
  /// **'Largest expense'**
  String get stat_largest_expense;

  /// No description provided for @stat_largest_expense_definition.
  ///
  /// In en, this message translates to:
  /// **'The single biggest expense in this period: {category}, {date}.'**
  String stat_largest_expense_definition(String category, String date);

  /// No description provided for @stat_most_frequent.
  ///
  /// In en, this message translates to:
  /// **'Most frequent'**
  String get stat_most_frequent;

  /// No description provided for @stat_most_frequent_definition.
  ///
  /// In en, this message translates to:
  /// **'The category with the most transactions in this period ({count, plural, =1{1 transaction} other{{count} transactions}}).'**
  String stat_most_frequent_definition(int count);

  /// No description provided for @stat_open_transaction.
  ///
  /// In en, this message translates to:
  /// **'Open transaction'**
  String get stat_open_transaction;

  /// No description provided for @breakdown_title_expense.
  ///
  /// In en, this message translates to:
  /// **'Spending by category'**
  String get breakdown_title_expense;

  /// No description provided for @breakdown_title_income.
  ///
  /// In en, this message translates to:
  /// **'Income by category'**
  String get breakdown_title_income;

  /// No description provided for @breakdown_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get breakdown_total;

  /// No description provided for @breakdown_other.
  ///
  /// In en, this message translates to:
  /// **'Other ({count})'**
  String breakdown_other(int count);

  /// No description provided for @breakdown_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 txn} other{{count} txns}}'**
  String breakdown_count(int count);

  /// No description provided for @breakdown_empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this period yet.'**
  String get breakdown_empty;

  /// No description provided for @trends_title.
  ///
  /// In en, this message translates to:
  /// **'Income vs expense'**
  String get trends_title;

  /// No description provided for @trends_net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get trends_net;

  /// No description provided for @trends_months.
  ///
  /// In en, this message translates to:
  /// **'{count} mo'**
  String trends_months(int count);

  /// No description provided for @trends_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Income vs expense, last {count} months.'**
  String trends_summary_title(int count);

  /// No description provided for @trends_summary_month.
  ///
  /// In en, this message translates to:
  /// **'{month}: income {income}, expense {expense}, net {net}.'**
  String trends_summary_month(
    String month,
    String income,
    String expense,
    String net,
  );

  /// No description provided for @daily_title.
  ///
  /// In en, this message translates to:
  /// **'Daily spending'**
  String get daily_title;

  /// No description provided for @daily_average.
  ///
  /// In en, this message translates to:
  /// **'avg {amount}'**
  String daily_average(String amount);

  /// No description provided for @daily_summary.
  ///
  /// In en, this message translates to:
  /// **'Daily spending, {period}. Average {average}. Highest {day}, {amount}.'**
  String daily_summary(
    String period,
    String average,
    String day,
    String amount,
  );

  /// No description provided for @chart_summary_title.
  ///
  /// In en, this message translates to:
  /// **'{title}, {period}.'**
  String chart_summary_title(String title, String period);

  /// No description provided for @chart_summary_share.
  ///
  /// In en, this message translates to:
  /// **'{name} {percent} percent, {amount}.'**
  String chart_summary_share(String name, int percent, String amount);

  /// No description provided for @chart_summary_empty.
  ///
  /// In en, this message translates to:
  /// **'{title}, {period}: no data.'**
  String chart_summary_empty(String title, String period);

  /// No description provided for @chart_tap_again.
  ///
  /// In en, this message translates to:
  /// **'Tap again to see transactions'**
  String get chart_tap_again;

  /// No description provided for @failure_backup_empty.
  ///
  /// In en, this message translates to:
  /// **'This file is empty.'**
  String get failure_backup_empty;

  /// No description provided for @backup_never.
  ///
  /// In en, this message translates to:
  /// **'No backup yet. Back up so you don\'t lose your data when you change phones.'**
  String get backup_never;

  /// No description provided for @backup_last.
  ///
  /// In en, this message translates to:
  /// **'Last backup: {ago} ({when})'**
  String backup_last(String ago, String when);

  /// No description provided for @backup_days_ago.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{today} =1{yesterday} other{{days} days ago}}'**
  String backup_days_ago(int days);

  /// No description provided for @backup_export.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get backup_export;

  /// No description provided for @backup_save_to_device.
  ///
  /// In en, this message translates to:
  /// **'Save to a folder'**
  String get backup_save_to_device;

  /// No description provided for @backup_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore from file'**
  String get backup_restore;

  /// No description provided for @backup_hint.
  ///
  /// In en, this message translates to:
  /// **'A backup is one .json file with all your transactions, categories, accounts and settings. Keep it somewhere safe, like Drive.'**
  String get backup_hint;

  /// No description provided for @backup_exported.
  ///
  /// In en, this message translates to:
  /// **'Backup exported'**
  String get backup_exported;

  /// No description provided for @backup_restored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored'**
  String get backup_restored;

  /// No description provided for @backup_restore_title.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get backup_restore_title;

  /// No description provided for @backup_preview_transactions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction} other{{count} transactions}}'**
  String backup_preview_transactions(int count);

  /// No description provided for @backup_preview_accounts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account} other{{count} accounts}}'**
  String backup_preview_accounts(int count);

  /// No description provided for @backup_preview_categories.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 category} other{{count} categories}}'**
  String backup_preview_categories(int count);

  /// No description provided for @backup_preview_exported.
  ///
  /// In en, this message translates to:
  /// **'Exported {date}'**
  String backup_preview_exported(String date);

  /// No description provided for @backup_replace_all.
  ///
  /// In en, this message translates to:
  /// **'Replace all'**
  String get backup_replace_all;

  /// No description provided for @backup_merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get backup_merge;

  /// No description provided for @backup_merge_hint.
  ///
  /// In en, this message translates to:
  /// **'Merge keeps everything on this phone and adds records from the file that aren\'t here yet.'**
  String get backup_merge_hint;

  /// No description provided for @backup_replace_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Replace all data?'**
  String get backup_replace_confirm_title;

  /// No description provided for @backup_replace_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'Everything on this phone is deleted and replaced with the backup. This can\'t be undone.'**
  String get backup_replace_confirm_body;

  /// No description provided for @backup_erase_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete every transaction, category, account and setting.'**
  String get backup_erase_subtitle;

  /// No description provided for @backup_erase_title.
  ///
  /// In en, this message translates to:
  /// **'Erase all data?'**
  String get backup_erase_title;

  /// No description provided for @backup_erase_body.
  ///
  /// In en, this message translates to:
  /// **'All transactions, categories, accounts and settings on this phone will be deleted. Export a backup first if you might need them.'**
  String get backup_erase_body;

  /// No description provided for @backup_erase_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get backup_erase_continue;

  /// No description provided for @backup_erase_again_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get backup_erase_again_title;

  /// No description provided for @backup_erase_again_body.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get backup_erase_again_body;

  /// No description provided for @backup_erase_confirm.
  ///
  /// In en, this message translates to:
  /// **'Erase everything'**
  String get backup_erase_confirm;

  /// No description provided for @backup_erased.
  ///
  /// In en, this message translates to:
  /// **'All data erased'**
  String get backup_erased;

  /// No description provided for @validation_account_in_use.
  ///
  /// In en, this message translates to:
  /// **'This account is used by transactions or recurring rules. Archive it instead.'**
  String get validation_account_in_use;

  /// No description provided for @validation_last_account.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one active account.'**
  String get validation_last_account;

  /// No description provided for @validation_interval.
  ///
  /// In en, this message translates to:
  /// **'Choose a repeat interval from 1 to 365.'**
  String get validation_interval;

  /// No description provided for @validation_end_before_start.
  ///
  /// In en, this message translates to:
  /// **'The end date can\'t be before the start date.'**
  String get validation_end_before_start;

  /// No description provided for @account_type_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get account_type_cash;

  /// No description provided for @account_type_bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get account_type_bank;

  /// No description provided for @account_type_ewallet.
  ///
  /// In en, this message translates to:
  /// **'E-wallet'**
  String get account_type_ewallet;

  /// No description provided for @account_type_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get account_type_other;

  /// No description provided for @accounts_new.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get accounts_new;

  /// No description provided for @accounts_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit account'**
  String get accounts_edit;

  /// No description provided for @accounts_opening_balance.
  ///
  /// In en, this message translates to:
  /// **'Opening balance'**
  String get accounts_opening_balance;

  /// No description provided for @accounts_total.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get accounts_total;

  /// No description provided for @accounts_balance_over_time.
  ///
  /// In en, this message translates to:
  /// **'Balance over time'**
  String get accounts_balance_over_time;

  /// No description provided for @accounts_transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer between accounts'**
  String get accounts_transfer;

  /// No description provided for @accounts_adjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust balance'**
  String get accounts_adjust;

  /// No description provided for @accounts_adjust_title.
  ///
  /// In en, this message translates to:
  /// **'Adjust {name}'**
  String accounts_adjust_title(String name);

  /// No description provided for @accounts_adjust_body.
  ///
  /// In en, this message translates to:
  /// **'Enter the real balance. The difference is recorded as an adjustment and left out of income and expense.'**
  String get accounts_adjust_body;

  /// No description provided for @accounts_actual_balance.
  ///
  /// In en, this message translates to:
  /// **'Actual balance'**
  String get accounts_actual_balance;

  /// No description provided for @accounts_adjust_none.
  ///
  /// In en, this message translates to:
  /// **'Balance already matches'**
  String get accounts_adjust_none;

  /// No description provided for @accounts_adjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted by {amount}'**
  String accounts_adjusted(String amount);

  /// No description provided for @accounts_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String accounts_delete_title(String name);

  /// No description provided for @accounts_delete_body.
  ///
  /// In en, this message translates to:
  /// **'Only accounts without transactions can be deleted; archive the others to hide them.'**
  String get accounts_delete_body;

  /// No description provided for @accounts_chart_summary.
  ///
  /// In en, this message translates to:
  /// **'Balance over time, last {count} months. Now:'**
  String accounts_chart_summary(int count);

  /// No description provided for @transfer_from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get transfer_from;

  /// No description provided for @transfer_to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get transfer_to;

  /// No description provided for @transfer_needs_accounts.
  ///
  /// In en, this message translates to:
  /// **'Add a second account to move money between accounts.'**
  String get transfer_needs_accounts;

  /// No description provided for @home_balance_all.
  ///
  /// In en, this message translates to:
  /// **'Balance (all accounts)'**
  String get home_balance_all;

  /// No description provided for @reports_all_accounts.
  ///
  /// In en, this message translates to:
  /// **'All accounts ▾'**
  String get reports_all_accounts;

  /// No description provided for @reports_some_accounts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account ▾} other{{count} accounts ▾}}'**
  String reports_some_accounts(int count);

  /// No description provided for @recurring_new.
  ///
  /// In en, this message translates to:
  /// **'New recurring'**
  String get recurring_new;

  /// No description provided for @recurring_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit recurring'**
  String get recurring_edit;

  /// No description provided for @recurring_empty.
  ///
  /// In en, this message translates to:
  /// **'Add rent, salary or subscriptions once and they\'ll appear automatically.'**
  String get recurring_empty;

  /// No description provided for @recurring_pending_header.
  ///
  /// In en, this message translates to:
  /// **'To confirm'**
  String get recurring_pending_header;

  /// No description provided for @recurring_rules_header.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get recurring_rules_header;

  /// No description provided for @recurring_due.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String recurring_due(String date);

  /// No description provided for @recurring_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get recurring_confirm;

  /// No description provided for @recurring_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get recurring_skip;

  /// No description provided for @recurring_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Added to your transactions'**
  String get recurring_confirmed;

  /// No description provided for @recurring_skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get recurring_skipped;

  /// No description provided for @recurring_next.
  ///
  /// In en, this message translates to:
  /// **'Next {date}'**
  String recurring_next(String date);

  /// No description provided for @recurring_ended.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get recurring_ended;

  /// No description provided for @recurring_needs_confirm.
  ///
  /// In en, this message translates to:
  /// **'Asks first'**
  String get recurring_needs_confirm;

  /// No description provided for @recurring_daily.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Daily} other{Every {count} days}}'**
  String recurring_daily(int count);

  /// No description provided for @recurring_weekly.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Weekly} other{Every {count} weeks}}'**
  String recurring_weekly(int count);

  /// No description provided for @recurring_monthly.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Monthly on day {day}} other{Every {count} months on day {day}}}'**
  String recurring_monthly(int count, int day);

  /// No description provided for @recurring_yearly.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Yearly} other{Every {count} years}}'**
  String recurring_yearly(int count);

  /// No description provided for @recurring_frequency_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get recurring_frequency_daily;

  /// No description provided for @recurring_frequency_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get recurring_frequency_weekly;

  /// No description provided for @recurring_frequency_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get recurring_frequency_monthly;

  /// No description provided for @recurring_frequency_yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get recurring_frequency_yearly;

  /// No description provided for @recurring_repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get recurring_repeat;

  /// No description provided for @recurring_interval.
  ///
  /// In en, this message translates to:
  /// **'Repeats'**
  String get recurring_interval;

  /// No description provided for @recurring_day_of_month.
  ///
  /// In en, this message translates to:
  /// **'Day of the month'**
  String get recurring_day_of_month;

  /// No description provided for @recurring_day_value.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String recurring_day_value(int day);

  /// No description provided for @recurring_day_hint.
  ///
  /// In en, this message translates to:
  /// **'In shorter months, days past the end fall on the last day.'**
  String get recurring_day_hint;

  /// No description provided for @recurring_less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get recurring_less;

  /// No description provided for @recurring_more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get recurring_more;

  /// No description provided for @recurring_starts.
  ///
  /// In en, this message translates to:
  /// **'Starts {date}'**
  String recurring_starts(String date);

  /// No description provided for @recurring_ends.
  ///
  /// In en, this message translates to:
  /// **'Ends {date}'**
  String recurring_ends(String date);

  /// No description provided for @recurring_no_end.
  ///
  /// In en, this message translates to:
  /// **'No end date'**
  String get recurring_no_end;

  /// No description provided for @recurring_ask_first.
  ///
  /// In en, this message translates to:
  /// **'Ask before adding'**
  String get recurring_ask_first;

  /// No description provided for @recurring_saved.
  ///
  /// In en, this message translates to:
  /// **'Recurring saved'**
  String get recurring_saved;

  /// No description provided for @recurring_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete this rule?'**
  String get recurring_delete_title;

  /// No description provided for @recurring_delete_body.
  ///
  /// In en, this message translates to:
  /// **'Transactions it already added stay. Items waiting to be confirmed are removed.'**
  String get recurring_delete_body;

  /// No description provided for @recurring_deleted.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted'**
  String get recurring_deleted;

  /// No description provided for @recurring_pending_banner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 recurring item to confirm} other{{count} recurring items to confirm}}'**
  String recurring_pending_banner(int count);

  /// No description provided for @recurring_review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get recurring_review;

  /// No description provided for @detail_recurring_rule.
  ///
  /// In en, this message translates to:
  /// **'Recurring rule'**
  String get detail_recurring_rule;

  /// No description provided for @detail_view_rule.
  ///
  /// In en, this message translates to:
  /// **'View rule'**
  String get detail_view_rule;

  /// No description provided for @backup_preview_recurring.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 recurring rule} other{{count} recurring rules}}'**
  String backup_preview_recurring(int count);

  /// No description provided for @reports_tab_compare.
  ///
  /// In en, this message translates to:
  /// **'Compare'**
  String get reports_tab_compare;

  /// No description provided for @reports_tab_calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get reports_tab_calendar;

  /// No description provided for @category_trend_title.
  ///
  /// In en, this message translates to:
  /// **'Category trend'**
  String get category_trend_title;

  /// No description provided for @category_trend_pick.
  ///
  /// In en, this message translates to:
  /// **'Pick up to {count} categories.'**
  String category_trend_pick(int count);

  /// No description provided for @category_trend_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Category trend, last {count} months.'**
  String category_trend_summary_title(int count);

  /// No description provided for @category_trend_summary_series.
  ///
  /// In en, this message translates to:
  /// **'{name}: {points}.'**
  String category_trend_summary_series(String name, String points);

  /// No description provided for @category_trend_summary_point.
  ///
  /// In en, this message translates to:
  /// **'{month} {amount}'**
  String category_trend_summary_point(String month, String amount);

  /// No description provided for @compare_title.
  ///
  /// In en, this message translates to:
  /// **'Against the period before'**
  String get compare_title;

  /// No description provided for @compare_category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get compare_category;

  /// No description provided for @compare_this.
  ///
  /// In en, this message translates to:
  /// **'This'**
  String get compare_this;

  /// No description provided for @compare_previous.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get compare_previous;

  /// No description provided for @compare_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get compare_change;

  /// No description provided for @compare_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get compare_total;

  /// No description provided for @compare_new.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get compare_new;

  /// No description provided for @compare_change_up.
  ///
  /// In en, this message translates to:
  /// **'up {percent}'**
  String compare_change_up(String percent);

  /// No description provided for @compare_change_down.
  ///
  /// In en, this message translates to:
  /// **'down {percent}'**
  String compare_change_down(String percent);

  /// No description provided for @compare_change_same.
  ///
  /// In en, this message translates to:
  /// **'unchanged'**
  String get compare_change_same;

  /// No description provided for @compare_change_new.
  ///
  /// In en, this message translates to:
  /// **'new this period'**
  String get compare_change_new;

  /// No description provided for @compare_row_label.
  ///
  /// In en, this message translates to:
  /// **'{name}: {current} this period, {previous} the period before. Change {delta}, {change}.'**
  String compare_row_label(
    String name,
    String current,
    String previous,
    String delta,
    String change,
  );

  /// No description provided for @calendar_title.
  ///
  /// In en, this message translates to:
  /// **'Cash-flow calendar'**
  String get calendar_title;

  /// No description provided for @calendar_day_label.
  ///
  /// In en, this message translates to:
  /// **'{date}, net {amount}'**
  String calendar_day_label(String date, String amount);

  /// No description provided for @calendar_day_empty.
  ///
  /// In en, this message translates to:
  /// **'{date}, nothing recorded'**
  String calendar_day_empty(String date);

  /// No description provided for @validation_pin.
  ///
  /// In en, this message translates to:
  /// **'Use 4 to 6 digits.'**
  String get validation_pin;

  /// No description provided for @lock_title.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lock_title;

  /// No description provided for @lock_enter_pin.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get lock_enter_pin;

  /// No description provided for @lock_wrong_pin.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Wrong PIN.} =1{Wrong PIN. 1 more try before a short wait.} other{Wrong PIN. {count} more tries before a short wait.}}'**
  String lock_wrong_pin(int count);

  /// No description provided for @lock_wait.
  ///
  /// In en, this message translates to:
  /// **'Too many tries. Try again in {seconds} s.'**
  String lock_wait(int seconds);

  /// No description provided for @lock_biometric.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint or face'**
  String get lock_biometric;

  /// No description provided for @lock_biometric_reason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Expense Tracker'**
  String get lock_biometric_reason;

  /// No description provided for @lock_forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot PIN?'**
  String get lock_forgot;

  /// No description provided for @lock_forgot_body.
  ///
  /// In en, this message translates to:
  /// **'The PIN can\'t be recovered: the app has no account and stores nothing online. If fingerprint or face unlock is on, use it. Otherwise, clearing the app\'s storage in Android Settings removes the lock and all data; restore a backup afterwards.'**
  String get lock_forgot_body;

  /// No description provided for @lock_pin_progress.
  ///
  /// In en, this message translates to:
  /// **'{count} of {length} digits entered'**
  String lock_pin_progress(int count, int length);

  /// No description provided for @lock_switch.
  ///
  /// In en, this message translates to:
  /// **'Lock with a PIN'**
  String get lock_switch;

  /// No description provided for @lock_switch_hint.
  ///
  /// In en, this message translates to:
  /// **'Asks for your PIN when you open the app. The app is hidden in recent apps and screenshots are blocked.'**
  String get lock_switch_hint;

  /// No description provided for @lock_change_pin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get lock_change_pin;

  /// No description provided for @lock_biometric_switch.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint or face'**
  String get lock_biometric_switch;

  /// No description provided for @lock_biometric_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Set up fingerprint or face in Android Settings first.'**
  String get lock_biometric_unavailable;

  /// No description provided for @lock_timeout.
  ///
  /// In en, this message translates to:
  /// **'Lock after'**
  String get lock_timeout;

  /// No description provided for @lock_timeout_immediately.
  ///
  /// In en, this message translates to:
  /// **'Immediately'**
  String get lock_timeout_immediately;

  /// No description provided for @lock_timeout_seconds30.
  ///
  /// In en, this message translates to:
  /// **'30 seconds away'**
  String get lock_timeout_seconds30;

  /// No description provided for @lock_timeout_minute1.
  ///
  /// In en, this message translates to:
  /// **'1 minute away'**
  String get lock_timeout_minute1;

  /// No description provided for @lock_timeout_minutes5.
  ///
  /// In en, this message translates to:
  /// **'5 minutes away'**
  String get lock_timeout_minutes5;

  /// No description provided for @lock_on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get lock_on;

  /// No description provided for @lock_off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get lock_off;

  /// No description provided for @lock_enabled.
  ///
  /// In en, this message translates to:
  /// **'App lock is on'**
  String get lock_enabled;

  /// No description provided for @lock_disabled.
  ///
  /// In en, this message translates to:
  /// **'App lock is off'**
  String get lock_disabled;

  /// No description provided for @pin_new.
  ///
  /// In en, this message translates to:
  /// **'Choose a PIN'**
  String get pin_new;

  /// No description provided for @pin_new_hint.
  ///
  /// In en, this message translates to:
  /// **'4 to 6 digits'**
  String get pin_new_hint;

  /// No description provided for @pin_confirm.
  ///
  /// In en, this message translates to:
  /// **'Enter the PIN again'**
  String get pin_confirm;

  /// No description provided for @pin_mismatch.
  ///
  /// In en, this message translates to:
  /// **'The PINs don\'t match. Choose a PIN again.'**
  String get pin_mismatch;

  /// No description provided for @pin_current.
  ///
  /// In en, this message translates to:
  /// **'Enter your current PIN'**
  String get pin_current;

  /// No description provided for @pin_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get pin_continue;

  /// No description provided for @pin_changed.
  ///
  /// In en, this message translates to:
  /// **'PIN changed'**
  String get pin_changed;

  /// No description provided for @failure_backup_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong password, or the file was changed after it was exported.'**
  String get failure_backup_password;

  /// No description provided for @validation_password_short.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters.'**
  String get validation_password_short;

  /// No description provided for @backup_password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords don\'t match.'**
  String get backup_password_mismatch;

  /// No description provided for @backup_password_show.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get backup_password_show;

  /// No description provided for @backup_password_hide.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get backup_password_hide;

  /// No description provided for @backup_password_set_title.
  ///
  /// In en, this message translates to:
  /// **'Backup password'**
  String get backup_password_set_title;

  /// No description provided for @backup_password_set_body.
  ///
  /// In en, this message translates to:
  /// **'New backups are encrypted with this password. You\'ll need it to restore them, on this phone or another. If you forget it, those backups can\'t be opened.'**
  String get backup_password_set_body;

  /// No description provided for @backup_password_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup'**
  String get backup_password_enter_title;

  /// No description provided for @backup_password_enter_body.
  ///
  /// In en, this message translates to:
  /// **'Enter the password this backup was made with.'**
  String get backup_password_enter_body;

  /// No description provided for @backup_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get backup_password_label;

  /// No description provided for @backup_password_again_label.
  ///
  /// In en, this message translates to:
  /// **'Password again'**
  String get backup_password_again_label;

  /// No description provided for @backup_password_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get backup_password_open;

  /// No description provided for @backup_reminder_never.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t backed up yet'**
  String get backup_reminder_never;

  /// No description provided for @backup_reminder_days.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Last backup 1 day ago} other{Last backup {days} days ago}}'**
  String backup_reminder_days(int days);

  /// No description provided for @backup_reminder_later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get backup_reminder_later;

  /// No description provided for @backup_reminder_now.
  ///
  /// In en, this message translates to:
  /// **'Back up now'**
  String get backup_reminder_now;

  /// No description provided for @backup_reminder_setting.
  ///
  /// In en, this message translates to:
  /// **'Remind me if no backup for 30 days'**
  String get backup_reminder_setting;

  /// No description provided for @backup_encrypt.
  ///
  /// In en, this message translates to:
  /// **'Encrypt backups with a password'**
  String get backup_encrypt;

  /// No description provided for @backup_encrypt_hint.
  ///
  /// In en, this message translates to:
  /// **'Protects the file if someone else gets it.'**
  String get backup_encrypt_hint;

  /// No description provided for @backup_encrypt_hint_on.
  ///
  /// In en, this message translates to:
  /// **'New backups need the password to restore.'**
  String get backup_encrypt_hint_on;

  /// No description provided for @backup_encrypt_on.
  ///
  /// In en, this message translates to:
  /// **'Backups will be encrypted'**
  String get backup_encrypt_on;

  /// No description provided for @backup_encrypt_off.
  ///
  /// In en, this message translates to:
  /// **'Backups will no longer be encrypted'**
  String get backup_encrypt_off;

  /// No description provided for @backup_auto.
  ///
  /// In en, this message translates to:
  /// **'Weekly auto-backup to folder'**
  String get backup_auto;

  /// No description provided for @backup_auto_hint.
  ///
  /// In en, this message translates to:
  /// **'Saves a backup to a folder you choose, once a week, when you open the app.'**
  String get backup_auto_hint;

  /// No description provided for @backup_auto_folder.
  ///
  /// In en, this message translates to:
  /// **'To {folder}'**
  String backup_auto_folder(String folder);

  /// No description provided for @backup_auto_last.
  ///
  /// In en, this message translates to:
  /// **'To {folder} · last {date}'**
  String backup_auto_last(String folder, String date);

  /// No description provided for @backup_auto_failed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save to {folder}. Choose the folder again.'**
  String backup_auto_failed(String folder);

  /// No description provided for @backup_auto_change_folder.
  ///
  /// In en, this message translates to:
  /// **'Change folder'**
  String get backup_auto_change_folder;

  /// No description provided for @backup_auto_on.
  ///
  /// In en, this message translates to:
  /// **'Auto-backup is on'**
  String get backup_auto_on;

  /// No description provided for @csv_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions as a spreadsheet file'**
  String get csv_subtitle;

  /// No description provided for @csv_range.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get csv_range;

  /// No description provided for @csv_this_month.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get csv_this_month;

  /// No description provided for @csv_last_month.
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get csv_last_month;

  /// No description provided for @csv_this_year.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get csv_this_year;

  /// No description provided for @csv_last_year.
  ///
  /// In en, this message translates to:
  /// **'Last year'**
  String get csv_last_year;

  /// No description provided for @csv_all_time.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get csv_all_time;

  /// No description provided for @csv_custom.
  ///
  /// In en, this message translates to:
  /// **'Custom…'**
  String get csv_custom;

  /// No description provided for @csv_range_all.
  ///
  /// In en, this message translates to:
  /// **'All transactions'**
  String get csv_range_all;

  /// No description provided for @csv_range_between.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String csv_range_between(String from, String to);

  /// No description provided for @csv_export.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get csv_export;

  /// No description provided for @csv_exported.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Exported 1 transaction} other{Exported {count} transactions}}'**
  String csv_exported(int count);

  /// No description provided for @csv_empty.
  ///
  /// In en, this message translates to:
  /// **'No transactions in this date range.'**
  String get csv_empty;

  /// No description provided for @csv_hint.
  ///
  /// In en, this message translates to:
  /// **'Columns: date, time, type, amount, category, account, to account, note, tags. Amounts are whole rupiah.'**
  String get csv_hint;

  /// No description provided for @onboarding_step.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String onboarding_step(int step, int total);

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_back;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @onboarding_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboarding_start;

  /// No description provided for @onboarding_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboarding_welcome_title;

  /// No description provided for @onboarding_welcome_body.
  ///
  /// In en, this message translates to:
  /// **'Track your money privately. Everything stays on this phone.'**
  String get onboarding_welcome_body;

  /// No description provided for @onboarding_currency_idr.
  ///
  /// In en, this message translates to:
  /// **'Indonesian Rupiah (Rp)'**
  String get onboarding_currency_idr;

  /// No description provided for @onboarding_currency_preview.
  ///
  /// In en, this message translates to:
  /// **'Amounts look like {example}'**
  String onboarding_currency_preview(String example);

  /// No description provided for @onboarding_currency_only.
  ///
  /// In en, this message translates to:
  /// **'Rupiah is the only currency for now.'**
  String get onboarding_currency_only;

  /// No description provided for @onboarding_moving.
  ///
  /// In en, this message translates to:
  /// **'Moving from another phone?'**
  String get onboarding_moving;

  /// No description provided for @onboarding_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore a backup'**
  String get onboarding_restore;

  /// No description provided for @onboarding_categories_title.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get onboarding_categories_title;

  /// No description provided for @onboarding_categories_body.
  ///
  /// In en, this message translates to:
  /// **'Untick any you won\'t use. You can add, edit and remove categories later.'**
  String get onboarding_categories_body;

  /// No description provided for @onboarding_cash_title.
  ///
  /// In en, this message translates to:
  /// **'Starting cash'**
  String get onboarding_cash_title;

  /// No description provided for @onboarding_cash_body.
  ///
  /// In en, this message translates to:
  /// **'How much cash do you have right now? Leave it at zero to skip.'**
  String get onboarding_cash_body;

  /// No description provided for @validation_tag_too_long.
  ///
  /// In en, this message translates to:
  /// **'A tag can have at most 32 characters.'**
  String get validation_tag_too_long;

  /// No description provided for @validation_too_many_tags.
  ///
  /// In en, this message translates to:
  /// **'Use at most 10 tags on one transaction.'**
  String get validation_too_many_tags;

  /// No description provided for @add_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get add_tags;

  /// No description provided for @detail_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get detail_tags;

  /// No description provided for @tags_title.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags_title;

  /// No description provided for @tags_hint.
  ///
  /// In en, this message translates to:
  /// **'Add a tag, e.g. trip-bali'**
  String get tags_hint;

  /// No description provided for @tags_limit.
  ///
  /// In en, this message translates to:
  /// **'Up to {max} tags'**
  String tags_limit(int max);

  /// No description provided for @tags_add.
  ///
  /// In en, this message translates to:
  /// **'Add tag'**
  String get tags_add;

  /// No description provided for @tags_remove.
  ///
  /// In en, this message translates to:
  /// **'Remove #{name}'**
  String tags_remove(String name);

  /// No description provided for @tags_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Your tags'**
  String get tags_suggestions;

  /// No description provided for @filter_tag.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get filter_tag;

  /// No description provided for @reports_tab_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get reports_tab_tags;

  /// No description provided for @tag_report_title.
  ///
  /// In en, this message translates to:
  /// **'By tag'**
  String get tag_report_title;

  /// No description provided for @tag_report_empty.
  ///
  /// In en, this message translates to:
  /// **'No tagged transactions in this period. Add tags on the Add screen, e.g. #trip-bali.'**
  String get tag_report_empty;

  /// No description provided for @tag_report_overlap_hint.
  ///
  /// In en, this message translates to:
  /// **'A transaction with several tags counts under each.'**
  String get tag_report_overlap_hint;

  /// No description provided for @tag_report_count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction} other{{count} transactions}}'**
  String tag_report_count(int count);

  /// No description provided for @tag_report_row_label.
  ///
  /// In en, this message translates to:
  /// **'{name}: {amount}, {count, plural, =1{1 transaction} other{{count} transactions}}'**
  String tag_report_row_label(String name, String amount, int count);
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
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
