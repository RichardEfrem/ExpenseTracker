// Public presentation API of the tags module: only `export … show …` lines.
export 'package:expense_tracker/features/tags/domain/entities/tag.dart'
    show Tag;
export 'package:expense_tracker/features/tags/presentation/providers/tags_notifier.dart'
    show TagsNotifier, tagsProvider;
export 'package:expense_tracker/features/tags/presentation/widgets/tag_picker_sheet.dart'
    show showTagPicker, tagsLabel;
