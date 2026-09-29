import 'package:expense_tracker/features/reports/compare/data/repositories/compare_repository_impl.dart';
import 'package:expense_tracker/features/reports/compare/domain/repositories/compare_repository.dart';
import 'package:expense_tracker/features/reports/compare/domain/usecases/watch_comparison.dart';
import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'compare_providers.g.dart';

@riverpod
CompareRepository compareRepository(Ref ref) =>
    CompareRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchComparison watchComparison(Ref ref) =>
    WatchComparison(ref.watch(compareRepositoryProvider));
