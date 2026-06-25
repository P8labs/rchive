import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/cubits/cubit/app_user_cubit.dart';

import 'package:rchive/core/theme/theme.dart';
import 'package:rchive/features/note/presentation/pages/notes_page.dart';
import 'package:rchive/features/setup/presentation/pages/onboard_page.dart';
import 'package:rchive/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AppUserCubit>())],
      child: const RchiveApp(),
    ),
  );
}

class RchiveApp extends StatefulWidget {
  const RchiveApp({super.key});

  @override
  State<RchiveApp> createState() => _RchiveAppState();
}

class _RchiveAppState extends State<RchiveApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rchive',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserOnboarded;
        },
        builder: (context, isOnboarded) {
          if (isOnboarded) {
            return NotesPage();
          }
          return OnboardPage();
        },
      ),
    );
  }
}
