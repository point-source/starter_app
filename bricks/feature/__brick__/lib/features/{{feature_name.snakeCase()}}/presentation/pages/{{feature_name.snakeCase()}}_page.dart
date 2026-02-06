import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_app/core/di/injection.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{feature_name.snakeCase()}}_bloc.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{feature_name.snakeCase()}}_event.dart';
import 'package:starter_app/features/{{feature_name.snakeCase()}}/presentation/bloc/{{feature_name.snakeCase()}}_state.dart';

/// Main page for {{feature_name.pascalCase()}} feature.
@RoutePage()
class {{feature_name.pascalCase()}}Page extends StatelessWidget {
  const {{feature_name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<{{feature_name.pascalCase()}}Bloc>()
        ..add(const {{feature_name.pascalCase()}}Started()),
      child: const _{{feature_name.pascalCase()}}View(),
    );
  }
}

class _{{feature_name.pascalCase()}}View extends StatelessWidget {
  const _{{feature_name.pascalCase()}}View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{feature_name.titleCase()}}'),
      ),
      body: BlocBuilder<{{feature_name.pascalCase()}}Bloc, {{feature_name.pascalCase()}}State>(
        builder: (context, state) {
          return switch (state) {
            {{feature_name.pascalCase()}}Initial() => const SizedBox.shrink(),
            {{feature_name.pascalCase()}}Loading() => const Center(
                child: CircularProgressIndicator(),
              ),
            {{feature_name.pascalCase()}}Loaded(:final items) => _buildContent(context, items),
            {{feature_name.pascalCase()}}Error(:final error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<{{feature_name.pascalCase()}}Bloc>()
                          .add(const {{feature_name.pascalCase()}}Started()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('No items found'),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.toString()),
          // TODO: Customize list item
        );
      },
    );
  }
}
