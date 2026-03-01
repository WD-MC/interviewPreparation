/// Classe utilitaire pour la validation des formulaires
///
/// Contient toutes les fonctions de validation réutilisables
class Validators {
  /// Valider un numéro de téléphone
  ///
  /// Règles:
  /// - Requis
  /// - 10 chiffres exactement (format français)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le numéro de téléphone est requis';
    }

    // Retirer les espaces et autres caractères non numériques
    final cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedValue.length != 10) {
      return 'Le numéro doit contenir 10 chiffres';
    }

    // Vérifier que ça commence par 0
    if (!cleanedValue.startsWith('0')) {
      return 'Le numéro doit commencer par 0';
    }

    return null;
  }

  /// Valider un mot de passe
  ///
  /// Règles:
  /// - Requis
  /// - Minimum 6 caractères
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }

    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    return null;
  }

  /// Valider la confirmation du mot de passe
  ///
  /// Règles:
  /// - Requis
  /// - Doit correspondre au mot de passe original
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }

    if (value != password) {
      return 'Les mots de passe ne correspondent pas';
    }

    return null;
  }

  /// Valider un pseudo
  ///
  /// Règles:
  /// - Requis
  /// - Minimum 3 caractères
  /// - Maximum 20 caractères
  /// - Seulement lettres, chiffres, underscore et tiret
  static String? validatePseudo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le pseudo est requis';
    }

    if (value.length < 3) {
      return 'Le pseudo doit contenir au moins 3 caractères';
    }

    if (value.length > 20) {
      return 'Le pseudo ne peut pas dépasser 20 caractères';
    }

    // Vérifier que le pseudo ne contient que des caractères autorisés
    final validPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!validPattern.hasMatch(value)) {
      return 'Le pseudo ne peut contenir que des lettres, chiffres, _ et -';
    }

    return null;
  }

  /// Valider une adresse email (optionnel)
  ///
  /// Règles:
  /// - Format email valide si renseigné
  static String? validateEmail(String? value) {
    // Email optionnel
    if (value == null || value.isEmpty) {
      return null;
    }

    // Format email basique
    final emailPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailPattern.hasMatch(value)) {
      return 'Adresse email invalide';
    }

    return null;
  }

  /// Valider un champ requis générique
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  /// Valider une longueur minimum
  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName est requis';
    }

    if (value.length < minLength) {
      return '$fieldName doit contenir au moins $minLength caractères';
    }

    return null;
  }

  /// Valider une longueur maximum
  static String? validateMaxLength(
    String? value,
    int maxLength,
    String fieldName,
  ) {
    if (value != null && value.length > maxLength) {
      return '$fieldName ne peut pas dépasser $maxLength caractères';
    }

    return null;
  }
}
