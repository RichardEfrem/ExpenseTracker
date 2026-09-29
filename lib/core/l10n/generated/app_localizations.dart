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
  /// **'This category has transactions. Archive it instead.'**
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
  /// **'\"{name}\" has transactions, so it can\'t be deleted. Archive it to hide it from pickers; it stays in reports.'**
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
  /// **'This account has transactions. Archive it instead.'**
  String get validation_account_in_use;

  /// No description provided for @validation_last_account.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one active account.'**
  String get validation_last_account;

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
