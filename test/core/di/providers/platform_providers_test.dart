import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/di/providers/platform_providers.dart';
import 'package:starter_app/core/domain/ports/i_platform_info.dart';
import 'package:starter_app/core/infrastructure/platform/platform_info.dart';

void main() {
  group('Platform Providers', () {
    test('platformInfoProvider returns PlatformInfoImpl', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final platformInfo = container.read(platformInfoProvider);

      expect(platformInfo, isA<PlatformInfoImpl>());
    });
  });
}
