import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/core/di/providers/storage_providers.dart';
import 'package:starter_app/core/domain/ports/i_secure_storage.dart';
import 'package:starter_app/core/domain/ports/i_token_storage.dart';
import 'package:starter_app/core/infrastructure/storage/secure_storage_impl.dart';
import 'package:starter_app/core/infrastructure/storage/token_storage_impl.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockHydratedStorage extends Mock implements HydratedStorage {}

void main() {
  group('Storage Providers', () {
    test('sharedPreferencesProvider throws UnimplementedError by default', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(sharedPreferencesProvider),
        throwsUnimplementedError,
      );
    });

    test('hydratedStorageProvider throws UnimplementedError by default', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(hydratedStorageProvider),
        throwsUnimplementedError,
      );
    });

    test('flutterSecureStorageProvider returns FlutterSecureStorage', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final storage = container.read(flutterSecureStorageProvider);

      expect(storage, isA<FlutterSecureStorage>());
    });

    test('secureStorageProvider returns SecureStorageImpl', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final storage = container.read(secureStorageProvider);

      expect(storage, isA<SecureStorageImpl>());
    });

    test('tokenStorageProvider returns TokenStorageImpl', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final storage = container.read(tokenStorageProvider);

      expect(storage, isA<TokenStorageImpl>());
    });
  });
}
