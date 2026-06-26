import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/state/app_cubit.dart';
import 'package:rchive/core/pages/error_page.dart';
import 'package:rchive/core/pages/splash_page.dart';

import 'package:rchive/core/theme/theme.dart';
import 'package:rchive/features/note/presentation/bloc/note_bloc.dart';
import 'package:rchive/features/note/presentation/pages/notes_page.dart';
import 'package:rchive/features/vault/presentation/bloc/vault_bloc.dart';
import 'package:rchive/features/vault/presentation/pages/vault_selection_page.dart';
import 'package:rchive/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppCubit>()..initialize()),
        BlocProvider(create: (_) => serviceLocator<VaultBloc>()),
        BlocProvider(create: (_) => serviceLocator<NoteBloc>()),
      ],
      child: const RchiveApp(),
    ),
  );
}

class RchiveApp extends StatelessWidget {
  const RchiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          switch (state) {
            case AppInitializing():
              return const SplashPage();

            case AppReady():
              if (state.currentVault == null) {
                return const VaultSelectionPage();
              }

              return const NotesPage();

            case AppFailure():
              return ErrorPage(message: state.message);
          }
        },
      ),
    );
  }
}
