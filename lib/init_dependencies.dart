import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rchive/core/comman/state/app_cubit.dart';
import 'package:rchive/core/database/app_database.dart';
import 'package:rchive/core/database/database_provider.dart';
import 'package:rchive/features/vault/data/datasources/vault_filesystem_datasource.dart';
import 'package:rchive/features/vault/data/datasources/vault_registry_local_datasource.dart';
import 'package:rchive/features/vault/data/datasources/vault_storage_datasource.dart';
import 'package:rchive/features/vault/data/repositories/vault_repository_impl.dart';
import 'package:rchive/features/vault/domain/repository/vault_repository.dart';
import 'package:rchive/features/vault/domain/usecases/create_vault.dart';
import 'package:rchive/features/vault/domain/usecases/delete_vault.dart';
import 'package:rchive/features/vault/domain/usecases/forget_vault.dart';
import 'package:rchive/features/vault/domain/usecases/get_vaults.dart';
import 'package:rchive/features/vault/domain/usecases/open_vault.dart';
import 'package:rchive/features/vault/presentation/bloc/vault_bloc.dart';

part 'init_dependencies.main.dart';
