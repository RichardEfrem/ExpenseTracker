import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_result.freezed.dart';

/// One page of a paginated list. [hasMore] tells the caller whether asking
/// for the next page can return anything.
@freezed
abstract class PagedResult<T> with _$PagedResult<T> {
  const factory PagedResult({required List<T> items, required bool hasMore}) =
      _PagedResult<T>;

  static PagedResult<T> empty<T>() => PagedResult<T>(items: [], hasMore: false);
}
