import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Modèle métier User (Domain Entity)
///
/// Représentation métier de l'utilisateur dans la couche domain
/// Indépendant de la couche data et de la couche UI
/// Contient uniquement la logique métier
@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String pseudo,
    required String phoneNumber,
    String? email,
    required DateTime createdAt,
  }) = _User;

  /// Obtenir le nom d'affichage
  String get displayName => pseudo;

  /// Formater le numéro de téléphone pour l'affichage
  ///
  /// Exemple: 0612345678 -> 06 12 34 56 78
  String get formattedPhoneNumber {
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 4)} ${phoneNumber.substring(4, 6)} ${phoneNumber.substring(6, 8)} ${phoneNumber.substring(8, 10)}';
    }
    return phoneNumber;
  }

  /// Obtenir l'initiale du pseudo pour l'avatar
  String get initial => pseudo.isNotEmpty ? pseudo[0].toUpperCase() : '?';

  /// Vérifier si l'utilisateur a un email
  bool get hasEmail => email != null && email!.isNotEmpty;

  /// Calculer l'ancienneté en jours
  int get accountAgeDays => DateTime.now().difference(createdAt).inDays;

  /// Vérifier si le compte est récent (moins de 7 jours)
  bool get isNewAccount => accountAgeDays < 7;
}
