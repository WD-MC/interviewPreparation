import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_config.dart';
import 'routing/app_router.dart';
import 'ui/core/themes/app_theme.dart';

/// Point d'entrée pour l'environnement de staging
///
/// Utilisation: flutter run -t lib/main_staging.dart
void main() {
  // Configuration de l'environnement de staging
  AppConfig.initialize(Environment.staging);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter MVVM Auth (Staging)',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
    );
  }
}
