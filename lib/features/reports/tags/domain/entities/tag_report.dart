import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_report.freezed.dart';

@freezed
abstract class TagTotal with _$TagTotal {
  const factory TagTotal({
    required String name,
    required int amount,
    required int count,
  }) = _TagTotal;
}

/// Spending or income per tag in a period (PRD RPT-08: "How much did the
/// Bali trip cost?"). Largest first. A transaction with several tags counts
/// under each, so the totals may add up to more than the period's total.
@freezed
abstract class TagReport with _$TagReport {
  const factory TagReport({
    required CategoryType type,
    required List<TagTotal> totals,
  }) = _TagReport;

  const TagReport._();

  bool get isEmpty => totals.isEmpty;

  /// The largest total, for scaling the bars; 0 when empty.
  int get largest => totals.isEmpty ? 0 : totals.first.amount;
}
