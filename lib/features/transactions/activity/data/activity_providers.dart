import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/transactions/activity/data/datasources/activity_local_datasource.dart';
import 'package:expense_tracker/features/transactions/activity/data/repositories/activity_repository_impl.dart';
import 'package:expense_tracker/features/transactions/activity/domain/repositories/activity_repository.dart';
import 'package:expense_tracker/features/transactions/activity/domain/usecases/watch_activity_page.dart';
import 'package:expense_tracker/features/transactions/activity/domain/usecases/watch_filter_summary.dart';
import 'package:expense_tracker/features/transactions/transaction/data/transaction_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_providers.g.dart';

@riverpod
ActivityLocalDataSource activityLocalDataSource(Ref ref) =>
    ActivityLocalDataSource(
      ref.watch(appDatabaseProvider),
      ref.watch(transactionLocalDataSourceProvider),
    );

@riverpod
ActivityRepository activityRepository(Ref ref) =>
    ActivityRepositoryImpl(ref.watch(activityLocalDataSourceProvider));

@riverpod
WatchActivityPage watchActivityPage(Ref ref) =>
    WatchActivityPage(ref.watch(activityRepositoryProvider));

@riverpod
WatchFilterSummary watchFilterSummary(Ref ref) =>
    WatchFilterSummary(ref.watch(activityRepositoryProvider));
