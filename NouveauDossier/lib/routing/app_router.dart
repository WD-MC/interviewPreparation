import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/features/auth/views/login_view.dart';
import '../ui/features/auth/views/register_view.dart';
import '../ui/features/home/views/home_view.dart';
import '../ui/features/auth/view_models/auth_view_model.dart';
import 'route_names.dart';

/// Provider pour le router GoRouter
///
/// Utilise Riverpod pour injecter le router dans l'application
/// et permettre la réactivité sur les changements d'authentification
final routerProvider = Provider<GoRouter>((ref) {
  // Écoute les changements d'état d'authentification
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: RouteNames.initial,

    // Redirection globale pour protéger les routes
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = authState.user != null;
      final isAuthRoute = state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.register;

      // Si authentifié et sur une route auth, rediriger vers home
      if (isAuthenticated && isAuthRoute) {
        return RouteNames.home;
      }

      // Si non authentifié et pas sur une route auth, rediriger vers login
      if (!isAuthenticated && !isAuthRoute) {
        return RouteNames.login;
      }

      // Sinon, pas de redirection
      return null;
    },

    routes: [
      // Route de connexion
      GoRoute(
        path: RouteNames.login,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginView(),
        ),
      ),

      // Route d'inscription
      GoRoute(
        path: RouteNames.register,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterView(),
        ),
      ),

      // Route d'accueil (protégée)
      GoRoute(
        path: RouteNames.home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeView(),
        ),
      ),
    ],

    // Gestion des erreurs de navigation
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Erreur: ${state.error}'),
      ),
    ),
  );
});
