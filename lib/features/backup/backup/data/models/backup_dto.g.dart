// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupFileDto _$BackupFileDtoFromJson(Map<String, dynamic> json) =>
    _BackupFileDto(
      format: json['format'] as String? ?? backupFormat,
      schemaVersion: (json['schema_version'] as num).toInt(),
      appVersion: json['app_version'] as String,
      exportedAt: json['exported_at'] as String,
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      recurringRules:
          (json['recurring_rules'] as List<dynamic>?)
              ?.map((e) => RecurringRuleDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pendingOccurrences:
          (json['pending_occurrences'] as List<dynamic>?)
              ?.map(
                (e) => PendingOccurrenceDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      settings: Map<String, String>.from(json['settings'] as Map),
    );

Map<String, dynamic> _$BackupFileDtoToJson(
  _BackupFileDto instance,
) => <String, dynamic>{
  'format': instance.format,
  'schema_version': instance.schemaVersion,
  'app_version': instance.appVersion,
  'exported_at': instance.exportedAt,
  'accounts': instance.accounts.map((e) => e.toJson()).toList(),
  'categories': instance.categories.map((e) => e.toJson()).toList(),
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
  'recurring_rules': instance.recurringRules.map((e) => e.toJson()).toList(),
  'pending_occurrences': instance.pendingOccurrences
      .map((e) => e.toJson())
      .toList(),
  'settings': instance.settings,
};

_AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => _AccountDto(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  color: json['color'] as String,
  openingBalance: (json['opening_balance'] as num).toInt(),
  isArchived: json['is_archived'] as bool,
  sortOrder: (json['sort_order'] as num).toInt(),
  createdAt: (json['created_at'] as num).toInt(),
  updatedAt: (json['updated_at'] as num).toInt(),
);

Map<String, dynamic> _$AccountDtoToJson(_AccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'icon': instance.icon,
      'color': instance.color,
      'opening_balance': instance.openingBalance,
      'is_archived': instance.isArchived,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => _CategoryDto(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  icon: json['icon'] as String,
  color: json['color'] as String,
  isArchived: json['is_archived'] as bool,
  sortOrder: (json['sort_order'] as num).toInt(),
  createdAt: (json['created_at'] as num).toInt(),
  updatedAt: (json['updated_at'] as num).toInt(),
);

Map<String, dynamic> _$CategoryDtoToJson(_CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'icon': instance.icon,
      'color': instance.color,
      'is_archived': instance.isArchived,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    _TransactionDto(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toInt(),
      accountId: json['account_id'] as String,
      toAccountId: json['to_account_id'] as String?,
      categoryId: json['category_id'] as String?,
      date: json['date'] as String,
      time: json['time'] as String,
      note: json['note'] as String?,
      recurringRuleId: json['recurring_rule_id'] as String?,
      receiptPath: json['receipt_path'] as String?,
      createdAt: (json['created_at'] as num).toInt(),
      updatedAt: (json['updated_at'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionDtoToJson(_TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'account_id': instance.accountId,
      'to_account_id': instance.toAccountId,
      'category_id': instance.categoryId,
      'date': instance.date,
      'time': instance.time,
      'note': instance.note,
      'recurring_rule_id': instance.recurringRuleId,
      'receipt_path': instance.receiptPath,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_RecurringRuleDto _$RecurringRuleDtoFromJson(Map<String, dynamic> json) =>
    _RecurringRuleDto(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toInt(),
      accountId: json['account_id'] as String,
      toAccountId: json['to_account_id'] as String?,
      categoryId: json['category_id'] as String?,
      note: json['note'] as String?,
      frequency: json['frequency'] as String,
      interval: (json['interval'] as num).toInt(),
      dayOfMonth: (json['day_of_month'] as num?)?.toInt(),
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String?,
      autoCreate: json['auto_create'] as bool,
      lastGeneratedDate: json['last_generated_date'] as String?,
      createdAt: (json['created_at'] as num).toInt(),
      updatedAt: (json['updated_at'] as num).toInt(),
    );

Map<String, dynamic> _$RecurringRuleDtoToJson(_RecurringRuleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'account_id': instance.accountId,
      'to_account_id': instance.toAccountId,
      'category_id': instance.categoryId,
      'note': instance.note,
      'frequency': instance.frequency,
      'interval': instance.interval,
      'day_of_month': instance.dayOfMonth,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'auto_create': instance.autoCreate,
      'last_generated_date': instance.lastGeneratedDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_PendingOccurrenceDto _$PendingOccurrenceDtoFromJson(
  Map<String, dynamic> json,
) => _PendingOccurrenceDto(
  id: json['id'] as String,
  ruleId: json['rule_id'] as String,
  date: json['date'] as String,
  createdAt: (json['created_at'] as num).toInt(),
);

Map<String, dynamic> _$PendingOccurrenceDtoToJson(
  _PendingOccurrenceDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'rule_id': instance.ruleId,
  'date': instance.date,
  'created_at': instance.createdAt,
};
