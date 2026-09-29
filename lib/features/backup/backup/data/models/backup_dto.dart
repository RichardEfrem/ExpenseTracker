import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/accounts/accounts_data.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/transactions/transactions_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_dto.freezed.dart';
part 'backup_dto.g.dart';

/// Marks a file as ours, so random JSON is rejected as corrupt.
const backupFormat = 'expense_tracker_backup';

int _ms(DateTime t) => t.toUtc().millisecondsSinceEpoch;

/// The backup JSON (schema version 1). Keys are snake_case and every
/// nullable field is written as an explicit null (never omitted).
@freezed
abstract class BackupFileDto with _$BackupFileDto {
  const factory BackupFileDto({
    @Default(backupFormat) String format,
    required int schemaVersion,
    required String appVersion,

    /// ISO 8601, UTC.
    required String exportedAt,
    required List<AccountDto> accounts,
    required List<CategoryDto> categories,
    required List<TransactionDto> transactions,
    required Map<String, String> settings,
  }) = _BackupFileDto;

  factory BackupFileDto.fromJson(Map<String, dynamic> json) =>
      _$BackupFileDtoFromJson(json);
}

@freezed
abstract class AccountDto with _$AccountDto {
  const factory AccountDto({
    required String id,
    required String name,
    required String type,
    required String icon,
    required String color,
    required int openingBalance,
    required bool isArchived,
    required int sortOrder,
    required int createdAt,
    required int updatedAt,
  }) = _AccountDto;

  const AccountDto._();

  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);

  factory AccountDto.fromRow(AccountRow r) => AccountDto(
    id: r.id,
    name: r.name,
    type: r.type,
    icon: r.icon,
    color: r.color,
    openingBalance: r.openingBalance,
    isArchived: r.isArchived,
    sortOrder: r.sortOrder,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  factory AccountDto.fromEntity(Account a) => AccountDto(
    id: a.id,
    name: a.name,
    type: a.type.name,
    icon: a.icon,
    color: a.color.name,
    openingBalance: a.openingBalance,
    isArchived: a.isArchived,
    sortOrder: a.sortOrder,
    createdAt: _ms(a.createdAt),
    updatedAt: _ms(a.updatedAt),
  );

  AccountRow toRow() => AccountRow(
    id: id,
    name: name,
    type: type,
    icon: icon,
    color: color,
    openingBalance: openingBalance,
    isArchived: isArchived,
    sortOrder: sortOrder,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

@freezed
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required String name,
    required String type,
    required String icon,
    required String color,
    required bool isArchived,
    required int sortOrder,
    required int createdAt,
    required int updatedAt,
  }) = _CategoryDto;

  const CategoryDto._();

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  factory CategoryDto.fromRow(CategoryRow r) => CategoryDto(
    id: r.id,
    name: r.name,
    type: r.type,
    icon: r.icon,
    color: r.color,
    isArchived: r.isArchived,
    sortOrder: r.sortOrder,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  factory CategoryDto.fromEntity(Category c) => CategoryDto(
    id: c.id,
    name: c.name,
    type: c.type.name,
    icon: c.icon,
    color: c.color.name,
    isArchived: c.isArchived,
    sortOrder: c.sortOrder,
    createdAt: _ms(c.createdAt),
    updatedAt: _ms(c.updatedAt),
  );

  CategoryRow toRow() => CategoryRow(
    id: id,
    name: name,
    type: type,
    icon: icon,
    color: color,
    isArchived: isArchived,
    sortOrder: sortOrder,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

@freezed
abstract class TransactionDto with _$TransactionDto {
  const factory TransactionDto({
    required String id,
    required String type,
    required int amount,
    required String accountId,
    required String? toAccountId,
    required String? categoryId,

    /// Local date, `YYYY-MM-DD`.
    required String date,

    /// Local time, `HH:mm`.
    required String time,
    required String? note,
    required String? recurringRuleId,
    required String? receiptPath,
    required int createdAt,
    required int updatedAt,
  }) = _TransactionDto;

  const TransactionDto._();

  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);

  factory TransactionDto.fromRow(TransactionRow r) => TransactionDto(
    id: r.id,
    type: r.type,
    amount: r.amount,
    accountId: r.accountId,
    toAccountId: r.toAccountId,
    categoryId: r.categoryId,
    date: r.date,
    time: r.time,
    note: r.note,
    recurringRuleId: r.recurringRuleId,
    receiptPath: r.receiptPath,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  factory TransactionDto.fromEntity(Transaction t) => TransactionDto(
    id: t.id,
    type: t.type.name,
    amount: t.amount,
    accountId: t.accountId,
    toAccountId: t.toAccountId,
    categoryId: t.categoryId,
    date: t.date.toIso(),
    time: t.time.format(),
    note: t.note,
    recurringRuleId: t.recurringRuleId,
    receiptPath: t.receiptPath,
    createdAt: _ms(t.createdAt),
    updatedAt: _ms(t.updatedAt),
  );

  TransactionRow toRow() => TransactionRow(
    id: id,
    type: type,
    amount: amount,
    accountId: accountId,
    toAccountId: toAccountId,
    categoryId: categoryId,
    date: date,
    time: LocalTime.parse(time).format(),
    note: note,
    recurringRuleId: recurringRuleId,
    receiptPath: receiptPath,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
