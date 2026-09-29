import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Opens Activity filtered to what a chart element stands for (SRCH-04).
void drillDown(BuildContext context, TransactionFilter filter) =>
    context.go(FilterQueryCodec.location(filter));

/// A filter limited to [period], plus whatever else the element adds.
TransactionFilter periodFilter(
  Period period, {
  Set<TransactionType> types = const {},
  Set<String> categoryIds = const {},
  Set<String> accountIds = const {},
}) => TransactionFilter(
  from: period.start,
  to: period.end,
  types: types,
  categoryIds: categoryIds,
  accountIds: accountIds,
);
