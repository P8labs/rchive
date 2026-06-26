import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/features/note/presentation/pages/new_note_page.dart';
import 'package:rchive/features/setup/presentation/bloc/onboard_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onLogout() {
      // context.read<OnboardBloc>().add()
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Rchive'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(NewNotePage.route()),
            icon: Icon(Icons.add_circle_outline),
          ),
          IconButton(onPressed: onLogout, icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: Center(),
    );
  }
}
