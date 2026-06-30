import 'package:flutter_saf/flutter_saf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rchive/core/comman/state/app_cubit.dart';
import 'package:rchive/core/comman/utils/show_snackbar.dart';
import 'package:rchive/core/comman/widgets/loader.dart';
import 'package:rchive/core/theme/app_pallet.dart';
import 'package:rchive/features/vault/presentation/bloc/vault_bloc.dart';

class VaultSelectionPage extends StatefulWidget {
  const VaultSelectionPage({super.key});

  @override
  State<VaultSelectionPage> createState() => _VaultSelectionPageState();
}

class _VaultSelectionPageState extends State<VaultSelectionPage> {
  final TextEditingController _vaultNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VaultBloc>().add(LoadVaultsEvent());
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

  void onNewVault() async {
    final name = _vaultNameController.text.trim();
    String? selectedDirectory = await FlutterSafChannel.pickDirectory();

    if (!mounted || selectedDirectory == null) {
      return;
    }

    context.read<VaultBloc>().add(
      CreateVaultEvent(name: name, parentPath: selectedDirectory),
    );

    await context.read<AppCubit>().initialize();
  }

  void onExistingVault() async {
    String? selectedDirectory = await FlutterSafChannel.pickDirectory();

    if (!mounted || selectedDirectory == null) {
      return;
    }
    context.read<VaultBloc>().add(OpenVaultEvent(selectedDirectory));
    await context.read<AppCubit>().initialize(); // it will fetch default again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<VaultBloc, VaultState>(
          listener: (context, state) {
            if (state.error != null) {
              showSnackBar(context, state.error!);
            }
          },
          builder: (context, state) {
            if (state.loading) {
              return Loader();
            }
            return SingleChildScrollView(
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
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
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
                            filled: true,
                            errorText:
                                _vaultNameController.text.isEmpty || isValid
                                ? null
                                : "Vault name must be 3-64 characters and cannot contain \\ / : * ? \" < > |",
                            hintText: "Enter Vault Name",
                            errorMaxLines: 2,
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppPallete.surface,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppPallete.surface,
                                width: 1,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                width: 1,
                                color: AppPallete.border,
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
                        const SizedBox(height: 12),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                          child: BlocConsumer<VaultBloc, VaultState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              final vaults = state.vaults;
                              return ListView.builder(
                                itemCount: vaults.length,
                                itemBuilder: (context, index) {
                                  final vault = vaults[index];
                                  return Card(
                                    elevation: 0,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).dividerColor.withValues(alpha: 0.2),
                                      ),
                                    ),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                      leading: const Icon(
                                        Icons.folder_outlined,
                                      ),
                                      title: Hero(
                                        tag: vault.id,
                                        child: Text(
                                          vault.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat(
                                          "MM/dd/yyyy",
                                        ).format(vault.createdAt),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      onTap: () {
                                        context.read<AppCubit>().openVault(
                                          vault,
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
