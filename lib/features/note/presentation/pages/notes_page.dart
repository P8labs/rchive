import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/state/app_cubit.dart';
import 'package:rchive/core/comman/utils/show_snackbar.dart';
import 'package:rchive/features/note/presentation/bloc/note_bloc.dart';
import 'package:rchive/features/note/presentation/pages/new_note_page.dart';
import 'package:rchive/features/note/presentation/widgets/note_tree_view.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(LoadNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppCubit>().state;

    void onLogout() {
      if (appState is! AppReady || appState.currentVault == null) {
        showSnackBar(context, "No vault is opened");
        return;
      }

      context.read<AppCubit>().closeVault();
    }

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is! AppReady || state.currentVault == null) {
          return const SizedBox.shrink();
        }

        final currentVault = state.currentVault!;
        return Scaffold(
          appBar: AppBar(
            title: Hero(tag: currentVault.id, child: Text(currentVault.name)),
            actions: [
              IconButton(
                onPressed: () async {
                  await context.read<AppCubit>().syncVault();
                  if (!context.mounted) return;
                  context.read<NoteBloc>().add(LoadNotesEvent());
                },
                icon: Icon(Icons.sync),
              ),
              IconButton(
                onPressed: onLogout,
                icon: Icon(Icons.logout_outlined),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, NewNotePage.route(folder: ''));
            },
            child: const Icon(Icons.add),
          ),
          body: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is! NotesLoaded) {
                return const SizedBox.shrink();
              }

              final tree = buildNoteTree(state.notes);

              return NoteTreeView(
                root: tree,
                onOpenNote: (note) {
                  context.read<NoteBloc>().add(OpenNoteEvent(note.path));
                },
                onCreateNote: (folder) {
                  // Navigator.push(
                  //   context,
                  //   NewNotePage.route(folder: folder.path),
                  // );
                },
                onCreateFolder: (folder) {
                  // TODO: Show create folder dialog.
                },
              );
            },
          ),
        );
      },
    );
  }
}
