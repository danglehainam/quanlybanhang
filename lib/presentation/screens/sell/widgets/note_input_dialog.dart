import 'package:flutter/material.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../../../l10n/app_localizations.dart';

class NoteInputDialog extends StatefulWidget {
  final String? initialNote;

  const NoteInputDialog({super.key, this.initialNote});

  @override
  State<NoteInputDialog> createState() => _NoteInputDialogState();
}

class _NoteInputDialogState extends State<NoteInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppDialog(
      title: l10n.note,
      content: AppTextField(
        controller: _controller,
        labelText: l10n.enterNote,
        maxLines: 3,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: () {
          Navigator.of(context).pop(_controller.text.trim());
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text.trim());
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
