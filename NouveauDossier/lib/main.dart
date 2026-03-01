import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_config.dart';
import 'routing/app_router.dart';
import 'ui/core/themes/app_theme.dart';

/// Point d'entrée principal de l'application
///
/// Enveloppe l'application avec ProviderScope pour activer Riverpod
/// dans toute l'arborescence de widgets
void main() {
  // Configuration de l'environnement de production
  AppConfig.initialize(Environment.production);

  runApp(
    // ProviderScope est requis pour utiliser Riverpod
    // Il doit envelopper toute l'application
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Widget racine de l'application
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupère le router depuis le provider
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter MVVM Auth',
      debugShowCheckedModeBanner: false,

      // Configuration du routing avec go_router
      routerConfig: router,

      // Thème personnalisé de l'application
      theme: AppTheme.lightTheme,
    );
  }
}
