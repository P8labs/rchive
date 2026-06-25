import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rchive/core/theme/theme.dart';
import 'package:rchive/features/home/presentation/pages/home_page.dart';
import 'package:rchive/init_dependencies.dart';

import 'package:rchive/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const RchiveApp(),
    ),
  );
}

class RchiveApp extends StatelessWidget {
  const RchiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rchive',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const HomePage(),
    );
  }
}
