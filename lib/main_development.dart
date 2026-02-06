import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_app/app/view/app.dart';
import 'package:starter_app/bootstrap.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/di/providers/storage_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();
  final hydratedStorage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  await bootstrap(
    environment: AppEnvironment.development,
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      hydratedStorageProvider.overrideWithValue(hydratedStorage),
    ],
    builder: () => const App(),
  );
}
