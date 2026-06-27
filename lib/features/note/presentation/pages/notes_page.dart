import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/state/app_cubit.dart';
import 'package:rchive/core/comman/utils/show_snackbar.dart';
import 'package:rchive/features/note/presentation/pages/new_note_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

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
                onPressed: () =>
                    Navigator.of(context).push(NewNotePage.route()),
                icon: Icon(Icons.add_circle_outline),
              ),
              IconButton(
                onPressed: onLogout,
                icon: Icon(Icons.logout_outlined),
              ),
            ],
          ),
          body: Center(),
        );
      },
    );
  }
}
