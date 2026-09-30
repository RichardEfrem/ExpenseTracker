import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:expense_tracker/features/reports/tags/data/repositories/tag_report_repository_impl.dart';
import 'package:expense_tracker/features/reports/tags/domain/repositories/tag_report_repository.dart';
import 'package:expense_tracker/features/reports/tags/domain/usecases/watch_tag_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_providers.g.dart';

@riverpod
TagReportRepository tagReportRepository(Ref ref) =>
    TagReportRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchTagReport watchTagReport(Ref ref) =>
    WatchTagReport(ref.watch(tagReportRepositoryProvider));
