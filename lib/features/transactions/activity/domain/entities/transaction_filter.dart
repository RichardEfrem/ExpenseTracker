import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_filter.freezed.dart';

/// Search and filters for the Activity list (PRD SRCH-01, SRCH-02). Empty
/// sets and nulls mean "any".
@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    /// Matches note, category name or tag name, case-insensitive.
    @Default('') String text,
    @Default(<TransactionType>{}) Set<TransactionType> types,
    @Default(<String>{}) Set<String> categoryIds,
    @Default(<String>{}) Set<String> accountIds,

    /// Tag names; a transaction matches when it has any of them.
    @Default(<String>{}) Set<String> tags,
    LocalDate? from,
    LocalDate? to,
    int? minAmount,
    int? maxAmount,
  }) = _TransactionFilter;

  const TransactionFilter._();

  static const none = TransactionFilter();

  /// Any search or filter set; the list then shows the result bar.
  bool get isActive =>
      this != none && (text.trim().isNotEmpty || copyWith(text: '') != none);

  bool get hasDateRange => from != null || to != null;

  bool get hasAmountRange => minAmount != null || maxAmount != null;
}
