import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

/// Requête de connexion
///
/// Modèle pour les données envoyées lors de la connexion
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String phoneNumber,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// Requête d'inscription
///
/// Modèle pour les données envoyées lors de l'inscription
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String pseudo,
    required String phoneNumber,
    required String password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

/// Réponse d'authentification
///
/// Modèle pour la réponse du serveur après login/register
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String userId,
    required String token,
    String? message,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
