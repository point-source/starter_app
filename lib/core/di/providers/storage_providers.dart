import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/core/domain/ports/i_secure_storage.dart';
import 'package:starter_app/core/domain/ports/i_token_storage.dart';
import 'package:starter_app/core/infrastructure/storage/secure_storage_impl.dart';
import 'package:starter_app/core/infrastructure/storage/token_storage_impl.dart';

part 'storage_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError('Initialize via overrides in main');
}

@Riverpod(keepAlive: true)
HydratedStorage hydratedStorage(HydratedStorageRef ref) {
  throw UnimplementedError('Initialize via overrides in main');
}

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(FlutterSecureStorageRef ref) {
  return const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
}

@Riverpod(keepAlive: true)
ISecureStorage secureStorage(SecureStorageRef ref) {
  final storage = ref.watch(flutterSecureStorageProvider);
  return SecureStorageImpl(storage);
}

@Riverpod(keepAlive: true)
ITokenStorage tokenStorage(TokenStorageRef ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenStorageImpl(secureStorage);
}
