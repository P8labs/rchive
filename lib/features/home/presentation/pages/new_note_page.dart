import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/widgets/markdown_auto_preview.dart';

class NewNotePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const NewNotePage());
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final _titleController = TextEditingController(text: "Untitled");
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(border: InputBorder.none),
          controller: _titleController,
          onSubmitted: (value) {},
        ),
        actions: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: MarkdownAutoPreview(
            controller: _noteController,
            emojiConvert: true,
            enableToolBar: true,
            toolbarBackground: Colors.black12,
            maxLines: null,
            expands: false,
            decoration: InputDecoration(
              hintText: 'Enter your text here',
              border: .none,
            ),
          ),
        ),
      ),
    );
  }
}

        // child: TextField(
        //   controller: noteController,
        //   onTapOutside: (PointerDownEvent event) {
        //     FocusManager.instance.primaryFocus?.unfocus();
        //   },
        //   keyboardType: .multiline,
        //   maxLines: null, // Allows infinite expansion
        //   decoration: InputDecoration(
        //     hintText: 'Enter your text here',
        //     border: .none,
        //   ),
        //   textAlignVertical: .top,
        //   textAlign: .start,
        //   style: TextStyle(),
        //   expands: true,
        // ),