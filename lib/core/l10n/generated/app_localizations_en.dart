// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Expense Tracker';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_activity => 'Activity';

  @override
  String get nav_reports => 'Reports';

  @override
  String get nav_more => 'More';

  @override
  String get fab_add_expense => 'Add expense';

  @override
  String get common_retry => 'Retry';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_save => 'Save';

  @override
  String get common_close => 'Close';

  @override
  String get error_title => 'Something went wrong';

  @override
  String get failure_database =>
      'Your data couldn\'t be read or saved. Please try again.';

  @override
  String get failure_not_found => 'This item no longer exists.';

  @override
  String get failure_file => 'The file couldn\'t be read or written.';

  @override
  String get failure_backup_corrupt => 'This file isn\'t a valid backup.';

  @override
  String get failure_backup_version =>
      'This backup was made by a newer version of the app.';

  @override
  String get failure_unexpected =>
      'Something unexpected happened. Please try again.';

  @override
  String get validation_invalid_input => 'Please check the values you entered.';

  @override
  String get keypad_triple_zero => 'Triple zero';

  @override
  String get keypad_delete => 'Delete';

  @override
  String get keypad_clear => 'Clear';

  @override
  String get keypad_plus => 'Plus';

  @override
  String get keypad_minus => 'Minus';

  @override
  String get keypad_times => 'Times';

  @override
  String get keypad_divide => 'Divided by';

  @override
  String get keypad_hide => 'Hide keypad';

  @override
  String get keypad_show => 'Show keypad';

  @override
  String money_spoken(String words) {
    return '$words rupiah';
  }

  @override
  String money_spoken_negative(String words) {
    return 'minus $words rupiah';
  }

  @override
  String money_spoken_positive(String words) {
    return 'plus $words rupiah';
  }

  @override
  String money_scale_billion(String count) {
    return '$count billion';
  }

  @override
  String money_scale_million(String count) {
    return '$count million';
  }

  @override
  String money_scale_thousand(String count) {
    return '$count thousand';
  }

  @override
  String get seed_food => 'Food & Drinks';

  @override
  String get seed_transport => 'Transport';

  @override
  String get seed_groceries => 'Groceries';

  @override
  String get seed_bills => 'Bills & Utilities';

  @override
  String get seed_shopping => 'Shopping';

  @override
  String get seed_health => 'Health';

  @override
  String get seed_entertainment => 'Entertainment';

  @override
  String get seed_education => 'Education';

  @override
  String get seed_housing => 'Housing / Rent';

  @override
  String get seed_other => 'Other';

  @override
  String get seed_salary => 'Salary';

  @override
  String get seed_freelance => 'Freelance';

  @override
  String get seed_gift => 'Gift';

  @override
  String get seed_cash => 'Cash';

  @override
  String get common_delete => 'Delete';

  @override
  String get type_expense => 'Expense';

  @override
  String get type_income => 'Income';

  @override
  String get theme_system => 'System default';

  @override
  String get theme_light => 'Light';

  @override
  String get theme_dark => 'Dark';

  @override
  String get weekday_monday => 'Monday';

  @override
  String get weekday_tuesday => 'Tuesday';

  @override
  String get weekday_wednesday => 'Wednesday';

  @override
  String get weekday_thursday => 'Thursday';

  @override
  String get weekday_friday => 'Friday';

  @override
  String get weekday_saturday => 'Saturday';

  @override
  String get weekday_sunday => 'Sunday';

  @override
  String get validation_name_empty => 'Enter a name.';

  @override
  String get validation_name_too_long => 'Use 40 characters or fewer.';

  @override
  String get validation_category_in_use =>
      'This category is used by transactions or recurring rules. Archive it instead.';

  @override
  String get validation_category_type_mismatch =>
      'You can only merge categories of the same type.';

  @override
  String get validation_merge_into_self =>
      'Choose a different category to merge into.';

  @override
  String get validation_month_start_day => 'Choose a day from 1 to 31.';

  @override
  String get validation_week_start => 'Choose a day of the week.';

  @override
  String get more_coming_soon => 'Coming soon';

  @override
  String get more_section_money => 'Money';

  @override
  String get more_section_data => 'Data';

  @override
  String get more_section_preferences => 'Preferences';

  @override
  String get more_section_about => 'About';

  @override
  String get more_accounts => 'Accounts';

  @override
  String get more_categories => 'Categories';

  @override
  String get more_recurring => 'Recurring';

  @override
  String get more_backup => 'Backup & restore';

  @override
  String get more_export_csv => 'Export CSV';

  @override
  String get more_currency => 'Currency & format';

  @override
  String get more_month_start_day => 'Month start day';

  @override
  String get more_week_start => 'Week start';

  @override
  String get more_theme => 'Theme';

  @override
  String get more_app_lock => 'App lock';

  @override
  String get more_version => 'Version';

  @override
  String get more_erase_all => 'Erase all data';

  @override
  String get pref_title => 'Preferences';

  @override
  String get pref_section_format => 'Format';

  @override
  String get pref_section_periods => 'Periods';

  @override
  String get pref_section_appearance => 'Appearance';

  @override
  String get pref_currency_idr => 'Indonesian Rupiah (Rp)';

  @override
  String pref_month_start_value(int day) {
    return 'Day $day';
  }

  @override
  String pref_month_start_example(int day, String example) {
    return 'Day $day · e.g. $example';
  }

  @override
  String get categories_new_title => 'New category';

  @override
  String get categories_edit_title => 'Edit category';

  @override
  String get categories_new_short => 'New';

  @override
  String get categories_name => 'Name';

  @override
  String get categories_color => 'Color';

  @override
  String get categories_icon => 'Icon';

  @override
  String get categories_empty => 'No categories yet.';

  @override
  String get categories_archive => 'Archive';

  @override
  String get categories_unarchive => 'Unarchive';

  @override
  String categories_archived(int count) {
    return 'Archived ($count)';
  }

  @override
  String categories_transaction_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
      zero: 'No transactions',
    );
    return '$_temp0';
  }

  @override
  String get categories_in_use_title => 'Category in use';

  @override
  String categories_in_use_body(String name) {
    return '\"$name\" is used by transactions or recurring rules, so it can\'t be deleted. Archive it to hide it from pickers; it stays in reports.';
  }

  @override
  String get categories_merge => 'Merge';

  @override
  String get categories_merge_into => 'Merge into…';

  @override
  String categories_merge_title(String name) {
    return 'Merge \"$name\" into…';
  }

  @override
  String get categories_merge_confirm_title => 'Merge categories?';

  @override
  String categories_merge_confirm_body(String from, String into) {
    return 'All transactions in \"$from\" move to \"$into\", then \"$from\" is deleted. This can\'t be undone.';
  }

  @override
  String get categories_reorder => 'Drag to reorder';

  @override
  String get color_orange => 'Orange';

  @override
  String get color_blue => 'Blue';

  @override
  String get color_green => 'Green';

  @override
  String get color_purple => 'Purple';

  @override
  String get color_pink => 'Pink';

  @override
  String get color_teal => 'Teal';

  @override
  String get color_violet => 'Violet';

  @override
  String get color_amber => 'Amber';

  @override
  String get color_brown => 'Brown';

  @override
  String get color_emerald => 'Emerald';

  @override
  String get color_neutral => 'Gray';

  @override
  String get common_done => 'Done';

  @override
  String get common_undo => 'Undo';

  @override
  String get saved => 'Saved';

  @override
  String get date_today => 'Today';

  @override
  String get date_yesterday => 'Yesterday';

  @override
  String get type_transfer => 'Transfer';

  @override
  String get type_adjustment => 'Adjustment';

  @override
  String get add_note => 'Add note';

  @override
  String get add_note_title => 'Note';

  @override
  String get edit_transaction_title => 'Edit transaction';

  @override
  String get fab_more_types => 'Choose expense, income or transfer';

  @override
  String get home_empty =>
      'No transactions yet. Add your first expense to see your month.';

  @override
  String get detail_type => 'Type';

  @override
  String get detail_date_time => 'Date & time';

  @override
  String get detail_account => 'Account';

  @override
  String get detail_note => 'Note';

  @override
  String get detail_created => 'Created';

  @override
  String get transaction_deleted => 'Transaction deleted';

  @override
  String get transaction_duplicate => 'Duplicate';

  @override
  String get transaction_duplicated => 'Transaction added again';

  @override
  String get transaction_edit => 'Edit';

  @override
  String get transaction_recurring => 'Recurring';

  @override
  String get validation_amount_positive => 'Enter an amount greater than zero.';

  @override
  String get validation_amount_too_large => 'That amount is too large.';

  @override
  String get validation_note_too_long => 'Keep the note under 200 characters.';

  @override
  String get validation_category_required => 'Pick a category.';

  @override
  String get validation_account_required => 'Pick an account.';

  @override
  String get validation_same_account => 'Choose two different accounts.';

  @override
  String get validation_insufficient_balance =>
      'Not enough balance in this account.';

  @override
  String get activity_search_hint => 'Search notes or categories';

  @override
  String get activity_in => 'In';

  @override
  String get activity_out => 'Out';

  @override
  String activity_result_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return '$_temp0';
  }

  @override
  String get activity_no_results => 'Nothing matches these filters.';

  @override
  String get activity_clear_filters => 'Clear filters';

  @override
  String activity_empty(String period) {
    return 'No transactions in $period. Add your first expense to see it here.';
  }

  @override
  String get activity_period_empty => 'No transactions in this period.';

  @override
  String get filter_type => 'Type';

  @override
  String get filter_category => 'Category';

  @override
  String get filter_account => 'Account';

  @override
  String get filter_date => 'Date';

  @override
  String get filter_amount => 'Amount';

  @override
  String filter_value(String label, String value) {
    return '$label: $value';
  }

  @override
  String filter_remove(String label) {
    return 'Remove $label filter';
  }

  @override
  String filter_from(String date) {
    return 'from $date';
  }

  @override
  String filter_until(String date) {
    return 'until $date';
  }

  @override
  String get filter_amount_min => 'Minimum';

  @override
  String get filter_amount_max => 'Maximum';

  @override
  String get filter_apply => 'Apply';

  @override
  String get filter_clear => 'Clear';

  @override
  String get period_title => 'Period';

  @override
  String get period_week => 'Week';

  @override
  String get period_month => 'Month';

  @override
  String get period_year => 'Year';

  @override
  String get period_custom => 'Custom';

  @override
  String get period_previous => 'Previous period';

  @override
  String get period_next => 'Next period';

  @override
  String period_show_year(String year) {
    return 'Show $year';
  }

  @override
  String get period_choose_dates => 'Choose dates';

  @override
  String get period_current => 'Back to current period';

  @override
  String get home_good_morning => 'Good morning';

  @override
  String get home_good_afternoon => 'Good afternoon';

  @override
  String get home_good_evening => 'Good evening';

  @override
  String home_net(String period) {
    return 'Net · $period';
  }

  @override
  String home_vs(String change, String previous) {
    return '$change vs $previous';
  }

  @override
  String get home_previous_period => 'previous period';

  @override
  String get home_top_spending => 'Top spending';

  @override
  String get home_recent => 'Recent';

  @override
  String get home_see_all => 'See all';

  @override
  String get reports_tab_categories => 'Categories';

  @override
  String get reports_tab_trends => 'Trends';

  @override
  String get reports_tab_daily => 'Daily';

  @override
  String reports_empty(String period) {
    return 'No data for $period.';
  }

  @override
  String get reports_go_to_data => 'Go to last month with data';

  @override
  String get reports_no_data_yet => 'No earlier transactions yet.';

  @override
  String get stat_savings_rate => 'Savings rate';

  @override
  String get stat_savings_rate_definition =>
      'Income minus expense, as a share of income. Shown only when there is income.';

  @override
  String get stat_average_daily => 'Avg/day';

  @override
  String get stat_average_daily_definition =>
      'Expense divided by the days elapsed in the period (for the current period, up to today).';

  @override
  String get stat_projected => 'Projected';

  @override
  String get stat_projected_definition =>
      'Average daily spend times the days in this month: where spending ends if you keep this pace. Current month only.';

  @override
  String get stat_no_spend_days => 'No-spend days';

  @override
  String get stat_no_spend_days_definition =>
      'Days so far in this period with no expenses.';

  @override
  String stat_days(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get stat_largest_expense => 'Largest expense';

  @override
  String stat_largest_expense_definition(String category, String date) {
    return 'The single biggest expense in this period: $category, $date.';
  }

  @override
  String get stat_most_frequent => 'Most frequent';

  @override
  String stat_most_frequent_definition(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return 'The category with the most transactions in this period ($_temp0).';
  }

  @override
  String get stat_open_transaction => 'Open transaction';

  @override
  String get breakdown_title_expense => 'Spending by category';

  @override
  String get breakdown_title_income => 'Income by category';

  @override
  String get breakdown_total => 'Total';

  @override
  String breakdown_other(int count) {
    return 'Other ($count)';
  }

  @override
  String breakdown_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count txns',
      one: '1 txn',
    );
    return '$_temp0';
  }

  @override
  String get breakdown_empty => 'Nothing in this period yet.';

  @override
  String get trends_title => 'Income vs expense';

  @override
  String get trends_net => 'Net';

  @override
  String trends_months(int count) {
    return '$count mo';
  }

  @override
  String trends_summary_title(int count) {
    return 'Income vs expense, last $count months.';
  }

  @override
  String trends_summary_month(
    String month,
    String income,
    String expense,
    String net,
  ) {
    return '$month: income $income, expense $expense, net $net.';
  }

  @override
  String get daily_title => 'Daily spending';

  @override
  String daily_average(String amount) {
    return 'avg $amount';
  }

  @override
  String daily_summary(
    String period,
    String average,
    String day,
    String amount,
  ) {
    return 'Daily spending, $period. Average $average. Highest $day, $amount.';
  }

  @override
  String chart_summary_title(String title, String period) {
    return '$title, $period.';
  }

  @override
  String chart_summary_share(String name, int percent, String amount) {
    return '$name $percent percent, $amount.';
  }

  @override
  String chart_summary_empty(String title, String period) {
    return '$title, $period: no data.';
  }

  @override
  String get chart_tap_again => 'Tap again to see transactions';

  @override
  String get failure_backup_empty => 'This file is empty.';

  @override
  String get backup_never =>
      'No backup yet. Back up so you don\'t lose your data when you change phones.';

  @override
  String backup_last(String ago, String when) {
    return 'Last backup: $ago ($when)';
  }

  @override
  String backup_days_ago(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days ago',
      one: 'yesterday',
      zero: 'today',
    );
    return '$_temp0';
  }

  @override
  String get backup_export => 'Export backup';

  @override
  String get backup_save_to_device => 'Save to a folder';

  @override
  String get backup_restore => 'Restore from file';

  @override
  String get backup_hint =>
      'A backup is one .json file with all your transactions, categories, accounts and settings. Keep it somewhere safe, like Drive.';

  @override
  String get backup_exported => 'Backup exported';

  @override
  String get backup_restored => 'Backup restored';

  @override
  String get backup_restore_title => 'Restore backup';

  @override
  String backup_preview_transactions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return '$_temp0';
  }

  @override
  String backup_preview_accounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts',
      one: '1 account',
    );
    return '$_temp0';
  }

  @override
  String backup_preview_categories(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count categories',
      one: '1 category',
    );
    return '$_temp0';
  }

  @override
  String backup_preview_exported(String date) {
    return 'Exported $date';
  }

  @override
  String get backup_replace_all => 'Replace all';

  @override
  String get backup_merge => 'Merge';

  @override
  String get backup_merge_hint =>
      'Merge keeps everything on this phone and adds records from the file that aren\'t here yet.';

  @override
  String get backup_replace_confirm_title => 'Replace all data?';

  @override
  String get backup_replace_confirm_body =>
      'Everything on this phone is deleted and replaced with the backup. This can\'t be undone.';

  @override
  String get backup_erase_subtitle =>
      'Delete every transaction, category, account and setting.';

  @override
  String get backup_erase_title => 'Erase all data?';

  @override
  String get backup_erase_body =>
      'All transactions, categories, accounts and settings on this phone will be deleted. Export a backup first if you might need them.';

  @override
  String get backup_erase_continue => 'Continue';

  @override
  String get backup_erase_again_title => 'Are you sure?';

  @override
  String get backup_erase_again_body => 'This can\'t be undone.';

  @override
  String get backup_erase_confirm => 'Erase everything';

  @override
  String get backup_erased => 'All data erased';

  @override
  String get validation_account_in_use =>
      'This account is used by transactions or recurring rules. Archive it instead.';

  @override
  String get validation_last_account => 'Keep at least one active account.';

  @override
  String get validation_interval => 'Choose a repeat interval from 1 to 365.';

  @override
  String get validation_end_before_start =>
      'The end date can\'t be before the start date.';

  @override
  String get account_type_cash => 'Cash';

  @override
  String get account_type_bank => 'Bank';

  @override
  String get account_type_ewallet => 'E-wallet';

  @override
  String get account_type_other => 'Other';

  @override
  String get accounts_new => 'New account';

  @override
  String get accounts_edit => 'Edit account';

  @override
  String get accounts_opening_balance => 'Opening balance';

  @override
  String get accounts_total => 'Total balance';

  @override
  String get accounts_balance_over_time => 'Balance over time';

  @override
  String get accounts_transfer => 'Transfer between accounts';

  @override
  String get accounts_adjust => 'Adjust balance';

  @override
  String accounts_adjust_title(String name) {
    return 'Adjust $name';
  }

  @override
  String get accounts_adjust_body =>
      'Enter the real balance. The difference is recorded as an adjustment and left out of income and expense.';

  @override
  String get accounts_actual_balance => 'Actual balance';

  @override
  String get accounts_adjust_none => 'Balance already matches';

  @override
  String accounts_adjusted(String amount) {
    return 'Adjusted by $amount';
  }

  @override
  String accounts_delete_title(String name) {
    return 'Delete $name?';
  }

  @override
  String get accounts_delete_body =>
      'Only accounts without transactions can be deleted; archive the others to hide them.';

  @override
  String accounts_chart_summary(int count) {
    return 'Balance over time, last $count months. Now:';
  }

  @override
  String get transfer_from => 'From';

  @override
  String get transfer_to => 'To';

  @override
  String get transfer_needs_accounts =>
      'Add a second account to move money between accounts.';

  @override
  String get reports_all_accounts => 'All accounts ▾';

  @override
  String reports_some_accounts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts ▾',
      one: '1 account ▾',
    );
    return '$_temp0';
  }

  @override
  String get recurring_new => 'New recurring';

  @override
  String get recurring_edit => 'Edit recurring';

  @override
  String get recurring_empty =>
      'Add rent, salary or subscriptions once and they\'ll appear automatically.';

  @override
  String get recurring_pending_header => 'To confirm';

  @override
  String get recurring_rules_header => 'Rules';

  @override
  String recurring_due(String date) {
    return 'Due $date';
  }

  @override
  String get recurring_confirm => 'Confirm';

  @override
  String get recurring_skip => 'Skip';

  @override
  String get recurring_confirmed => 'Added to your transactions';

  @override
  String get recurring_skipped => 'Skipped';

  @override
  String recurring_next(String date) {
    return 'Next $date';
  }

  @override
  String get recurring_ended => 'Ended';

  @override
  String get recurring_needs_confirm => 'Asks first';

  @override
  String recurring_daily(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Every $count days',
      one: 'Daily',
    );
    return '$_temp0';
  }

  @override
  String recurring_weekly(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Every $count weeks',
      one: 'Weekly',
    );
    return '$_temp0';
  }

  @override
  String recurring_monthly(int count, int day) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Every $count months on day $day',
      one: 'Monthly on day $day',
    );
    return '$_temp0';
  }

  @override
  String recurring_yearly(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Every $count years',
      one: 'Yearly',
    );
    return '$_temp0';
  }

  @override
  String get recurring_frequency_daily => 'Daily';

  @override
  String get recurring_frequency_weekly => 'Weekly';

  @override
  String get recurring_frequency_monthly => 'Monthly';

  @override
  String get recurring_frequency_yearly => 'Yearly';

  @override
  String get recurring_repeat => 'Repeat';

  @override
  String get recurring_interval => 'Repeats';

  @override
  String get recurring_day_of_month => 'Day of the month';

  @override
  String recurring_day_value(int day) {
    return 'Day $day';
  }

  @override
  String get recurring_day_hint =>
      'In shorter months, days past the end fall on the last day.';

  @override
  String get recurring_less => 'Less';

  @override
  String get recurring_more => 'More';

  @override
  String recurring_starts(String date) {
    return 'Starts $date';
  }

  @override
  String recurring_ends(String date) {
    return 'Ends $date';
  }

  @override
  String get recurring_no_end => 'No end date';

  @override
  String get recurring_ask_first => 'Ask before adding';

  @override
  String get recurring_saved => 'Recurring saved';

  @override
  String get recurring_delete_title => 'Delete this rule?';

  @override
  String get recurring_delete_body =>
      'Transactions it already added stay. Items waiting to be confirmed are removed.';

  @override
  String get recurring_deleted => 'Rule deleted';

  @override
  String recurring_pending_banner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recurring items to confirm',
      one: '1 recurring item to confirm',
    );
    return '$_temp0';
  }

  @override
  String get recurring_review => 'Review';

  @override
  String get detail_recurring_rule => 'Recurring rule';

  @override
  String get detail_view_rule => 'View rule';

  @override
  String backup_preview_recurring(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recurring rules',
      one: '1 recurring rule',
    );
    return '$_temp0';
  }

  @override
  String get reports_tab_compare => 'Compare';

  @override
  String get reports_tab_calendar => 'Calendar';

  @override
  String get category_trend_title => 'Category trend';

  @override
  String category_trend_pick(int count) {
    return 'Pick up to $count categories.';
  }

  @override
  String category_trend_summary_title(int count) {
    return 'Category trend, last $count months.';
  }

  @override
  String category_trend_summary_series(String name, String points) {
    return '$name: $points.';
  }

  @override
  String category_trend_summary_point(String month, String amount) {
    return '$month $amount';
  }

  @override
  String get compare_title => 'Against the period before';

  @override
  String get compare_category => 'Category';

  @override
  String get compare_this => 'This';

  @override
  String get compare_previous => 'Before';

  @override
  String get compare_change => 'Change';

  @override
  String get compare_total => 'Total';

  @override
  String get compare_new => 'New';

  @override
  String compare_change_up(String percent) {
    return 'up $percent';
  }

  @override
  String compare_change_down(String percent) {
    return 'down $percent';
  }

  @override
  String get compare_change_same => 'unchanged';

  @override
  String get compare_change_new => 'new this period';

  @override
  String compare_row_label(
    String name,
    String current,
    String previous,
    String delta,
    String change,
  ) {
    return '$name: $current this period, $previous the period before. Change $delta, $change.';
  }

  @override
  String get calendar_title => 'Cash-flow calendar';

  @override
  String calendar_day_label(String date, String amount) {
    return '$date, net $amount';
  }

  @override
  String calendar_day_empty(String date) {
    return '$date, nothing recorded';
  }

  @override
  String get validation_pin => 'Use 4 to 6 digits.';

  @override
  String get lock_title => 'Unlock';

  @override
  String get lock_enter_pin => 'Enter your PIN';

  @override
  String lock_wrong_pin(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Wrong PIN. $count more tries before a short wait.',
      one: 'Wrong PIN. 1 more try before a short wait.',
      zero: 'Wrong PIN.',
    );
    return '$_temp0';
  }

  @override
  String lock_wait(int seconds) {
    return 'Too many tries. Try again in $seconds s.';
  }

  @override
  String get lock_biometric => 'Unlock with fingerprint or face';

  @override
  String get lock_biometric_reason => 'Unlock Expense Tracker';

  @override
  String get lock_forgot => 'Forgot PIN?';

  @override
  String get lock_forgot_body =>
      'The PIN can\'t be recovered: the app has no account and stores nothing online. If fingerprint or face unlock is on, use it. Otherwise, clearing the app\'s storage in Android Settings removes the lock and all data; restore a backup afterwards.';

  @override
  String lock_pin_progress(int count, int length) {
    return '$count of $length digits entered';
  }

  @override
  String get lock_switch => 'Lock with a PIN';

  @override
  String get lock_switch_hint =>
      'Asks for your PIN when you open the app. The app is hidden in recent apps and screenshots are blocked.';

  @override
  String get lock_change_pin => 'Change PIN';

  @override
  String get lock_biometric_switch => 'Unlock with fingerprint or face';

  @override
  String get lock_biometric_unavailable =>
      'Set up fingerprint or face in Android Settings first.';

  @override
  String get lock_timeout => 'Lock after';

  @override
  String get lock_timeout_immediately => 'Immediately';

  @override
  String get lock_timeout_seconds30 => '30 seconds away';

  @override
  String get lock_timeout_minute1 => '1 minute away';

  @override
  String get lock_timeout_minutes5 => '5 minutes away';

  @override
  String get lock_on => 'On';

  @override
  String get lock_off => 'Off';

  @override
  String get lock_enabled => 'App lock is on';

  @override
  String get lock_disabled => 'App lock is off';

  @override
  String get pin_new => 'Choose a PIN';

  @override
  String get pin_new_hint => '4 to 6 digits';

  @override
  String get pin_confirm => 'Enter the PIN again';

  @override
  String get pin_mismatch => 'The PINs don\'t match. Choose a PIN again.';

  @override
  String get pin_current => 'Enter your current PIN';

  @override
  String get pin_continue => 'Continue';

  @override
  String get pin_changed => 'PIN changed';

  @override
  String get failure_backup_password =>
      'Wrong password, or the file was changed after it was exported.';

  @override
  String get validation_password_short => 'Use at least 8 characters.';

  @override
  String get backup_password_mismatch => 'The passwords don\'t match.';

  @override
  String get backup_password_show => 'Show password';

  @override
  String get backup_password_hide => 'Hide password';

  @override
  String get backup_password_set_title => 'Backup password';

  @override
  String get backup_password_set_body =>
      'New backups are encrypted with this password. You\'ll need it to restore them, on this phone or another. If you forget it, those backups can\'t be opened.';

  @override
  String get backup_password_enter_title => 'Encrypted backup';

  @override
  String get backup_password_enter_body =>
      'Enter the password this backup was made with.';

  @override
  String get backup_password_label => 'Password';

  @override
  String get backup_password_again_label => 'Password again';

  @override
  String get backup_password_open => 'Open';

  @override
  String get backup_reminder_never => 'You haven\'t backed up yet';

  @override
  String backup_reminder_days(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Last backup $days days ago',
      one: 'Last backup 1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get backup_reminder_later => 'Later';

  @override
  String get backup_reminder_now => 'Back up now';

  @override
  String get backup_reminder_setting => 'Remind me if no backup for 30 days';

  @override
  String get backup_encrypt => 'Encrypt backups with a password';

  @override
  String get backup_encrypt_hint =>
      'Protects the file if someone else gets it.';

  @override
  String get backup_encrypt_hint_on =>
      'New backups need the password to restore.';

  @override
  String get backup_encrypt_on => 'Backups will be encrypted';

  @override
  String get backup_encrypt_off => 'Backups will no longer be encrypted';

  @override
  String get backup_auto => 'Weekly auto-backup to folder';

  @override
  String get backup_auto_hint =>
      'Saves a backup to a folder you choose, once a week, when you open the app.';

  @override
  String backup_auto_folder(String folder) {
    return 'To $folder';
  }

  @override
  String backup_auto_last(String folder, String date) {
    return 'To $folder · last $date';
  }

  @override
  String backup_auto_failed(String folder) {
    return 'Couldn\'t save to $folder. Choose the folder again.';
  }

  @override
  String get backup_auto_change_folder => 'Change folder';

  @override
  String get backup_auto_on => 'Auto-backup is on';

  @override
  String get csv_subtitle => 'Transactions as a spreadsheet file';

  @override
  String get csv_range => 'Date range';

  @override
  String get csv_this_month => 'This month';

  @override
  String get csv_last_month => 'Last month';

  @override
  String get csv_this_year => 'This year';

  @override
  String get csv_last_year => 'Last year';

  @override
  String get csv_all_time => 'All time';

  @override
  String get csv_custom => 'Custom…';

  @override
  String get csv_range_all => 'All transactions';

  @override
  String csv_range_between(String from, String to) {
    return '$from – $to';
  }

  @override
  String get csv_export => 'Export CSV';

  @override
  String csv_exported(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Exported $count transactions',
      one: 'Exported 1 transaction',
    );
    return '$_temp0';
  }

  @override
  String get csv_empty => 'No transactions in this date range.';

  @override
  String get csv_hint =>
      'Columns: date, time, type, amount, category, account, to account, note, tags. Amounts are whole rupiah.';

  @override
  String onboarding_step(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get onboarding_back => 'Back';

  @override
  String get onboarding_next => 'Next';

  @override
  String get onboarding_start => 'Start';

  @override
  String get onboarding_welcome_title => 'Welcome';

  @override
  String get onboarding_welcome_body =>
      'Track your money privately. Everything stays on this phone.';

  @override
  String get onboarding_currency_idr => 'Indonesian Rupiah (Rp)';

  @override
  String onboarding_currency_preview(String example) {
    return 'Amounts look like $example';
  }

  @override
  String get onboarding_currency_only => 'Rupiah is the only currency for now.';

  @override
  String get onboarding_moving => 'Moving from another phone?';

  @override
  String get onboarding_restore => 'Restore a backup';

  @override
  String get onboarding_categories_title => 'Categories';

  @override
  String get onboarding_categories_body =>
      'Untick any you won\'t use. You can add, edit and remove categories later.';

  @override
  String get onboarding_cash_title => 'Starting cash';

  @override
  String get onboarding_cash_body =>
      'How much cash do you have right now? Leave it at zero to skip.';

  @override
  String get validation_tag_too_long => 'A tag can have at most 32 characters.';

  @override
  String get validation_too_many_tags =>
      'Use at most 10 tags on one transaction.';

  @override
  String get add_tags => 'Tags';

  @override
  String get detail_tags => 'Tags';

  @override
  String get tags_title => 'Tags';

  @override
  String get tags_hint => 'Add a tag, e.g. trip-bali';

  @override
  String tags_limit(int max) {
    return 'Up to $max tags';
  }

  @override
  String get tags_add => 'Add tag';

  @override
  String tags_remove(String name) {
    return 'Remove #$name';
  }

  @override
  String get tags_suggestions => 'Your tags';

  @override
  String get filter_tag => 'Tag';

  @override
  String get reports_tab_tags => 'Tags';

  @override
  String get tag_report_title => 'By tag';

  @override
  String get tag_report_empty =>
      'No tagged transactions in this period. Add tags on the Add screen, e.g. #trip-bali.';

  @override
  String get tag_report_overlap_hint =>
      'A transaction with several tags counts under each.';

  @override
  String tag_report_count(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return '$_temp0';
  }

  @override
  String tag_report_row_label(String name, String amount, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return '$name: $amount, $_temp0';
  }
}
