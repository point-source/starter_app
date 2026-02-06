import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/domain/ports/i_platform_info.dart';
import 'package:starter_app/core/infrastructure/platform/platform_info.dart';

part 'platform_providers.g.dart';

@Riverpod(keepAlive: true)
IPlatformInfo platformInfo(PlatformInfoRef ref) => const PlatformInfoImpl();
