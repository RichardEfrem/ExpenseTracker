import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:flutter/material.dart';

/// Asks for a note; the entered text, or null when cancelled.
Future<String?> showNoteDialog(BuildContext context, {String? initial}) =>
    showDialog<String>(
      context: context,
      builder: (context) => _NoteDialog(initial: initial),
    );

/// Edits the note; owns its text controller so it outlives the closing
/// animation.
class _NoteDialog extends StatefulWidget {
  const _NoteDialog({this.initial});

  final String? initial;

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.add_note_title),
      content: TextField(
        key: const ValueKey('note-field'),
        controller: _controller,
        autofocus: true,
        maxLength: TransactionInput.maxNoteLength,
        maxLines: 3,
        minLines: 1,
        textCapitalization: TextCapitalization.sentences,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text(l10n.common_done),
        ),
      ],
    );
  }
}
