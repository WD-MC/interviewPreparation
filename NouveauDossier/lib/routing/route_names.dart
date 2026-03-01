/// Constantes pour les noms de routes de l'application
///
/// Centraliser les noms de routes évite les erreurs de typage
/// et facilite la maintenance
class RouteNames {
  // Routes d'authentification
  static const String login = '/login';
  static const String register = '/register';

  // Routes principales
  static const String home = '/home';

  // Route par défaut
  static const String initial = login;
}
