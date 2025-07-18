import 'package:flutter/material.dart';

class EditNoteDialog extends StatefulWidget {
  final String initialText;
  final Function(String) onEdit;

  const EditNoteDialog({
    super.key,
    required this.initialText,
    required this.onEdit,
  });

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Note'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter your note...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onEdit(_controller.text.trim());
              Navigator.of(context).pop();
            }
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}