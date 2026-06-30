import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markdown_editor_plus/widgets/markdown_auto_preview.dart';
import 'package:rchive/features/note/presentation/bloc/note_bloc.dart';

class NewNotePage extends StatefulWidget {
  static MaterialPageRoute route({String folder = ''}) =>
      MaterialPageRoute(builder: (_) => NewNotePage(folder: folder));

  final String folder;
  const NewNotePage({super.key, required this.folder});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final _nameController = TextEditingController(text: 'Untitled.md');
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      return;
    }

    final fileName = name.endsWith('.md') ? name : '$name.md';

    context.read<NoteBloc>().add(
      CreateNoteEvent(
        path: 'notes/$fileName',
        content: _contentController.text,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'File name',
            border: InputBorder.none,
          ),
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onSubmitted: (_) => _save(),
        ),
        actions: [
          IconButton(onPressed: _save, icon: const Icon(Icons.save_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: MarkdownAutoPreview(
          controller: _contentController,
          emojiConvert: true,
          enableToolBar: true,
          toolbarBackground: Colors.black12,
          maxLines: null,
          expands: false,
          decoration: const InputDecoration(
            hintText: 'Start writing...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
