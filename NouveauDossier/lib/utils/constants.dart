/// Constantes globales de l'application
///
/// Centralise toutes les constantes réutilisables
class AppConstants {
  // Nom de l'application
  static const String appName = 'Flutter MVVM Auth';

  // Durées d'animation
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Padding/Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // Tailles d'icônes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  // Limites de validation
  static const int phoneNumberLength = 10;
  static const int minPasswordLength = 6;
  static const int minPseudoLength = 3;
  static const int maxPseudoLength = 20;

  // Timeouts
  static const Duration networkTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 5);

  // Messages d'erreur par défaut
  static const String genericErrorMessage =
      'Une erreur inattendue s\'est produite';
  static const String networkErrorMessage =
      'Erreur de connexion. Vérifiez votre connexion internet';
  static const String timeoutErrorMessage =
      'La requête a expiré. Veuillez réessayer';

  // Messages de succès
  static const String loginSuccessMessage = 'Connexion réussie !';
  static const String registerSuccessMessage = 'Compte créé avec succès !';
  static const String logoutSuccessMessage = 'Déconnexion réussie';

  // Regex patterns
  static const String phonePattern = r'^0[1-9]\d{8}$';
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String pseudoPattern = r'^[a-zA-Z0-9_-]+$';
}
