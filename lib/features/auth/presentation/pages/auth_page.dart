import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/comman/utils/show_snackbar.dart';
import 'package:rchive/core/comman/widgets/loader.dart';
import 'package:rchive/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rchive/features/auth/presentation/widgets/gradient_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    void onAuth() {
      context.read<AuthBloc>().add(AuthAuthenticate());
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              print(state.token);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    "Rchive",
                    style: TextStyle(fontSize: 50, fontWeight: .bold),
                  ),
                  Text("Let's start noting important things."),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AuthGradientButton(
                      onPressed: onAuth,
                      buttonText: "Continue With Google",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
