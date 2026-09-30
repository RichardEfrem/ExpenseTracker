import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/tags/data/datasources/tag_local_datasource.dart';
import 'package:expense_tracker/features/tags/data/repositories/tag_repository_impl.dart';
import 'package:expense_tracker/features/tags/domain/repositories/tag_repository.dart';
import 'package:expense_tracker/features/tags/domain/usecases/watch_tags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_providers.g.dart';

@riverpod
TagLocalDataSource tagLocalDataSource(Ref ref) =>
    TagLocalDataSource(ref.watch(appDatabaseProvider));

@riverpod
TagRepository tagRepository(Ref ref) =>
    TagRepositoryImpl(ref.watch(tagLocalDataSourceProvider));

@riverpod
WatchTags watchTags(Ref ref) => WatchTags(ref.watch(tagRepositoryProvider));
