import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rchive/core/theme/app_pallet.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final TextEditingController _vaultNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vaultNameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _vaultNameController.dispose();
    super.dispose();
  }

  bool get isValid {
    final name = _vaultNameController.text.trim();

    if (name.isEmpty) return false;
    if (name.length < 3) return false;
    if (name.length > 64) return false;

    final invalidChars = RegExp(r'[<>:"/\\|?*\x00-\x1F]');
    if (invalidChars.hasMatch(name)) return false;

    return true;
  }

  void onNewVault() {
    // context.read();
  }
  void onExistingVault() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Rchive",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your private knowledge vault.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: _vaultNameController,
                    decoration: InputDecoration(
                      errorText: _vaultNameController.text.isEmpty || isValid
                          ? null
                          : "Vault name must be 3-64 characters and cannot contain \\ / : * ? \" < > |",
                      hintText: "Enter Vault Name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: AppPallete.accent,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: isValid ? onNewVault : null,
                    child: const Text("Create New Vault"),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: onExistingVault,
                    child: const Text("Open Existing Vault"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
