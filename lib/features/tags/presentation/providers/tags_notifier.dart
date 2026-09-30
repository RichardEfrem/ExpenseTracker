import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/tags/data/tags_providers.dart';
import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tags_notifier.g.dart';

/// Every tag in use, most used first.
@riverpod
class TagsNotifier extends _$TagsNotifier {
  @override
  Stream<List<Tag>> build() => ref.watch(watchTagsProvider)().unwrap();
}
