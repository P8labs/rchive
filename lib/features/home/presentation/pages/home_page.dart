import 'package:flutter/material.dart';
import 'package:rchive/features/home/presentation/pages/new_note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rchive'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(NewNotePage.route()),
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Center(),
    );
  }
}
