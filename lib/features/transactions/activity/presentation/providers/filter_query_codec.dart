import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';

/// [TransactionFilter] ↔ `/activity` query parameters, so any screen can
/// open a pre-filtered list (PRD SRCH-04):
/// `/activity?category=<id>,<id>&from=2026-09-01&to=2026-09-30`.
abstract final class FilterQueryCodec {
  static const _text = 'q';
  static const _type = 'type';
  static const _category = 'category';
  static const _account = 'account';
  static const _from = 'from';
  static const _to = 'to';
  static const _min = 'min';
  static const _max = 'max';

  static Map<String, String> encode(TransactionFilter filter) {
    String join(Iterable<String> values) => (values.toList()..sort()).join(',');
    return {
      if (filter.text.trim().isNotEmpty) _text: filter.text.trim(),
      if (filter.types.isNotEmpty) _type: join(filter.types.map((t) => t.name)),
      if (filter.categoryIds.isNotEmpty) _category: join(filter.categoryIds),
      if (filter.accountIds.isNotEmpty) _account: join(filter.accountIds),
      if (filter.from != null) _from: filter.from!.toIso(),
      if (filter.to != null) _to: filter.to!.toIso(),
      if (filter.minAmount != null) _min: '${filter.minAmount}',
      if (filter.maxAmount != null) _max: '${filter.maxAmount}',
    };
  }

  /// Unknown or malformed values are ignored, never fatal.
  static TransactionFilter decode(Map<String, String> query) {
    Set<String> list(String key) => {
      for (final v in (query[key] ?? '').split(','))
        if (v.trim().isNotEmpty) v.trim(),
    };
    int? amount(String key) {
      final value = int.tryParse(query[key] ?? '');
      return value != null && value >= 0 ? value : null;
    }

    return TransactionFilter(
      text: query[_text]?.trim() ?? '',
      types: {
        for (final name in list(_type))
          ...TransactionType.values.where((t) => t.name == name),
      },
      categoryIds: list(_category),
      accountIds: list(_account),
      from: LocalDate.tryParse(query[_from] ?? ''),
      to: LocalDate.tryParse(query[_to] ?? ''),
      minAmount: amount(_min),
      maxAmount: amount(_max),
    );
  }

  /// `/activity?…` for [filter].
  static String location(TransactionFilter filter) {
    final query = encode(filter);
    return Uri(
      path: AppPaths.activity,
      queryParameters: query.isEmpty ? null : query,
    ).toString();
  }
}
