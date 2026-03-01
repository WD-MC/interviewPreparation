import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/user.dart';

part 'auth_state.freezed.dart';

/// États possibles de l'authentification
///
/// Utilise Freezed pour créer un état immutable avec pattern matching
@freezed
class AuthState with _$AuthState {
  /// État initial - Aucune action en cours
  const factory AuthState.initial() = _Initial;

  /// État de chargement - Action en cours
  const factory AuthState.loading() = _Loading;

  /// État authentifié - Utilisateur connecté
  const factory AuthState.authenticated(User user) = _Authenticated;

  /// État d'erreur - Une erreur s'est produite
  const factory AuthState.error(String message) = _Error;

  /// État déconnecté - Utilisateur déconnecté
  const factory AuthState.unauthenticated() = _Unauthenticated;
}

/// Extension pour faciliter les vérifications d'état
extension AuthStateX on AuthState {
  /// Vérifie si on est en chargement
  bool get isLoading => this is _Loading;

  /// Vérifie si on est authentifié
  bool get isAuthenticated => this is _Authenticated;

  /// Vérifie si on a une erreur
  bool get hasError => this is _Error;

  /// Récupère l'utilisateur si authentifié
  User? get user => maybeWhen(
        authenticated: (user) => user,
        orElse: () => null,
      );

  /// Récupère le message d'erreur si erreur
  String? get errorMessage => maybeWhen(
        error: (message) => message,
        orElse: () => null,
      );
}
