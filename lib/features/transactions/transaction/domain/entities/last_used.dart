import 'package:freezed_annotation/freezed_annotation.dart';

part 'last_used.freezed.dart';

/// The category and account last saved for one transaction type (TX-06).
@freezed
abstract class LastUsed with _$LastUsed {
  const factory LastUsed({String? categoryId, String? accountId}) = _LastUsed;
}
