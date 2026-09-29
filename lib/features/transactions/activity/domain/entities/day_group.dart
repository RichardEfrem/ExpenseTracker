import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'day_group.freezed.dart';

/// One day in the Activity list with its net subtotal (PRD TX-09).
@Freezed(copyWith: false)
abstract class DayGroup with _$DayGroup {
  const factory DayGroup({
    required LocalDate date,

    /// Income − expense of the listed transactions; transfers count zero.
    required int net,

    /// Newest first.
    required List<TransactionView> items,
  }) = _DayGroup;
}
