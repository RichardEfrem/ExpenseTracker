import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

LocalDate d(String iso) => LocalDate.parse(iso);

List<String> iso(Iterable<LocalDate> dates) => [
  for (final date in dates) date.toIso(),
];

void main() {
  RecurrenceSchedule schedule(
    RecurrenceFrequency frequency,
    String start, {
    int interval = 1,
    int? dayOfMonth,
    String? end,
  }) => RecurrenceSchedule(
    frequency: frequency,
    start: d(start),
    interval: interval,
    dayOfMonth: dayOfMonth,
    end: end == null ? null : d(end),
  );

  group('between', () {
    final cases = <String, (RecurrenceSchedule, String?, String, List<String>)>{
      'daily, inclusive of start and until': (
        schedule(RecurrenceFrequency.daily, '2026-09-27'),
        null,
        '2026-09-29',
        ['2026-09-27', '2026-09-28', '2026-09-29'],
      ),
      'daily every 3 days': (
        schedule(RecurrenceFrequency.daily, '2026-09-01', interval: 3),
        null,
        '2026-09-10',
        ['2026-09-01', '2026-09-04', '2026-09-07', '2026-09-10'],
      ),
      'weekly keeps the weekday': (
        schedule(RecurrenceFrequency.weekly, '2026-09-07'),
        null,
        '2026-09-29',
        ['2026-09-07', '2026-09-14', '2026-09-21', '2026-09-28'],
      ),
      'every 2 weeks': (
        schedule(RecurrenceFrequency.weekly, '2026-09-07', interval: 2),
        null,
        '2026-10-05',
        ['2026-09-07', '2026-09-21', '2026-10-05'],
      ),
      'monthly on 31 falls on each month end (REC-04)': (
        schedule(RecurrenceFrequency.monthly, '2026-01-31'),
        null,
        '2026-06-30',
        [
          '2026-01-31',
          '2026-02-28',
          '2026-03-31',
          '2026-04-30',
          '2026-05-31',
          '2026-06-30',
        ],
      ),
      'monthly on 31 in a leap year February': (
        schedule(RecurrenceFrequency.monthly, '2028-01-31'),
        null,
        '2028-03-31',
        ['2028-01-31', '2028-02-29', '2028-03-31'],
      ),
      'monthly on 30 never drifts after February': (
        schedule(RecurrenceFrequency.monthly, '2026-01-30'),
        null,
        '2026-04-30',
        ['2026-01-30', '2026-02-28', '2026-03-30', '2026-04-30'],
      ),
      'monthly day before the start day begins next month': (
        schedule(RecurrenceFrequency.monthly, '2026-09-29', dayOfMonth: 25),
        null,
        '2026-11-30',
        ['2026-10-25', '2026-11-25'],
      ),
      'every 3 months': (
        schedule(RecurrenceFrequency.monthly, '2026-01-15', interval: 3),
        null,
        '2026-12-31',
        ['2026-01-15', '2026-04-15', '2026-07-15', '2026-10-15'],
      ),
      'monthly across a year end': (
        schedule(RecurrenceFrequency.monthly, '2026-11-25'),
        null,
        '2027-02-25',
        ['2026-11-25', '2026-12-25', '2027-01-25', '2027-02-25'],
      ),
      'yearly on 29 Feb falls on 28 Feb in common years': (
        schedule(RecurrenceFrequency.yearly, '2028-02-29'),
        null,
        '2033-03-01',
        [
          '2028-02-29',
          '2029-02-28',
          '2030-02-28',
          '2031-02-28',
          '2032-02-29',
          '2033-02-28',
        ],
      ),
      'every 2 years': (
        schedule(RecurrenceFrequency.yearly, '2026-09-29', interval: 2),
        null,
        '2031-01-01',
        ['2026-09-29', '2028-09-29', '2030-09-29'],
      ),
      'after is exclusive': (
        schedule(RecurrenceFrequency.monthly, '2026-07-25'),
        '2026-08-25',
        '2026-10-25',
        ['2026-09-25', '2026-10-25'],
      ),
      'end date is inclusive and stops the rule': (
        schedule(RecurrenceFrequency.monthly, '2026-07-25', end: '2026-09-25'),
        null,
        '2026-12-31',
        ['2026-07-25', '2026-08-25', '2026-09-25'],
      ),
      'nothing before the start': (
        schedule(RecurrenceFrequency.daily, '2026-10-01'),
        null,
        '2026-09-29',
        [],
      ),
      // Local dates carry no time zone, so DST switches (US 8 Mar, EU
      // 29 Mar, ID none) never skip or double a day.
      'daily across the US DST change': (
        schedule(RecurrenceFrequency.daily, '2026-03-07'),
        '2026-03-07',
        '2026-03-09',
        ['2026-03-08', '2026-03-09'],
      ),
      'daily across the EU DST change': (
        schedule(RecurrenceFrequency.daily, '2026-03-28'),
        null,
        '2026-03-30',
        ['2026-03-28', '2026-03-29', '2026-03-30'],
      ),
    };
    for (final MapEntry(key: name, value: (s, after, until, want))
        in cases.entries) {
      test(name, () {
        expect(iso(s.between(after == null ? null : d(after), d(until))), want);
      });
    }

    test('long gaps: 10 years of monthly rent, each month once', () {
      final dates = schedule(
        RecurrenceFrequency.monthly,
        '2016-10-31',
      ).between(null, d('2026-09-30'));
      expect(dates, hasLength(120));
      expect(dates.toSet(), hasLength(120));
      expect(dates.every((date) => date == date.lastOfMonth), isTrue);
      for (var i = 1; i < dates.length; i++) {
        expect(dates[i] > dates[i - 1], isTrue);
      }
    });

    test('long gaps: 5 years daily', () {
      final dates = schedule(
        RecurrenceFrequency.daily,
        '2021-09-30',
      ).between(null, d('2026-09-29'));
      expect(dates, hasLength(d('2021-09-30').daysUntil(d('2026-09-29')) + 1));
    });
  });

  group('nextOnOrAfter', () {
    test('the same day when it is an occurrence', () {
      expect(
        schedule(
          RecurrenceFrequency.monthly,
          '2026-07-25',
        ).nextOnOrAfter(d('2026-09-25')),
        d('2026-09-25'),
      );
    });
    test('the next month end for day 31', () {
      expect(
        schedule(
          RecurrenceFrequency.monthly,
          '2026-01-31',
        ).nextOnOrAfter(d('2026-04-01')),
        d('2026-04-30'),
      );
    });
    test('the start when the date is earlier', () {
      expect(
        schedule(
          RecurrenceFrequency.weekly,
          '2026-10-05',
        ).nextOnOrAfter(d('2026-01-01')),
        d('2026-10-05'),
      );
    });
    test('null after the end', () {
      expect(
        schedule(
          RecurrenceFrequency.monthly,
          '2026-07-25',
          end: '2026-09-30',
        ).nextOnOrAfter(d('2026-09-26')),
        isNull,
      );
    });
  });

  group('RecurringRule.nextDate', () {
    RecurringRule rule({String? lastGenerated, String? end}) => RecurringRule(
      id: 'r',
      type: TransactionType.expense,
      amount: 3000000,
      accountId: 'cash',
      categoryId: 'housing',
      frequency: RecurrenceFrequency.monthly,
      interval: 1,
      dayOfMonth: 25,
      startDate: d('2026-07-25'),
      endDate: end == null ? null : d(end),
      autoCreate: true,
      lastGeneratedDate: lastGenerated == null ? null : d(lastGenerated),
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

    test('the start while nothing is generated', () {
      expect(rule().nextDate, d('2026-07-25'));
    });
    test('the first date after the last generated one', () {
      expect(rule(lastGenerated: '2026-09-25').nextDate, d('2026-10-25'));
      expect(rule(lastGenerated: '2026-09-29').nextDate, d('2026-10-25'));
    });
    test('null once the end has passed', () {
      expect(
        rule(lastGenerated: '2026-09-29', end: '2026-10-01').nextDate,
        isNull,
      );
    });
  });
}
