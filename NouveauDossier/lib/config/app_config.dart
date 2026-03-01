/// Environnements disponibles pour l'application
enum Environment {
  development,
  staging,
  production,
}

/// Configuration globale de l'application
///
/// Singleton qui gère la configuration selon l'environnement
class AppConfig {
  static late Environment _environment;
  static late AppConfig _instance;

  final String apiBaseUrl;
  final bool enableLogging;
  final int timeoutSeconds;

  AppConfig._({
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.timeoutSeconds,
  });

  /// Initialise la configuration selon l'environnement
  static void initialize(Environment environment) {
    _environment = environment;
    _instance = _createConfig(environment);
  }

  /// Crée la configuration selon l'environnement
  static AppConfig _createConfig(Environment environment) {
    switch (environment) {
      case Environment.development:
        return AppConfig._(
          apiBaseUrl: 'http://localhost:3000/api',
          enableLogging: true,
          timeoutSeconds: 30,
        );
      case Environment.staging:
        return AppConfig._(
          apiBaseUrl: 'https://staging.api.example.com',
          enableLogging: true,
          timeoutSeconds: 30,
        );
      case Environment.production:
        return AppConfig._(
          apiBaseUrl: 'https://api.example.com',
          enableLogging: false,
          timeoutSeconds: 15,
        );
    }
  }

  /// Accès à l'instance singleton
  static AppConfig get instance => _instance;

  /// Environnement actuel
  static Environment get environment => _environment;

  /// Vérifie si on est en développement
  static bool get isDevelopment => _environment == Environment.development;

  /// Vérifie si on est en staging
  static bool get isStaging => _environment == Environment.staging;

  /// Vérifie si on est en production
  static bool get isProduction => _environment == Environment.production;
}
