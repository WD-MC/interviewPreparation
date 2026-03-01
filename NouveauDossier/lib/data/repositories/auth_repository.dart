import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user.dart';
import '../models/auth_request.dart';
import '../services/auth_service.dart';

/// Provider pour le service d'authentification
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Provider pour le repository d'authentification
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

/// Repository d'authentification
///
/// Abstraction entre la couche UI et la couche Data
/// Responsable de:
/// - Orchestrer les appels au service
/// - Transformer les DTOs en modèles domain
/// - Gérer les erreurs métier
class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  /// Inscrire un nouvel utilisateur
  ///
  /// Convertit les données d'inscription en requête,
  /// appelle le service, puis transforme la réponse en modèle domain
  Future<User> register({
    required String pseudo,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Créer la requête
      final request = RegisterRequest(
        pseudo: pseudo,
        phoneNumber: phoneNumber,
        password: password,
      );

      // Appeler le service
      final response = await _authService.register(request);

      // Récupérer les détails de l'utilisateur
      final userDto = await _authService.getUserById(response.userId);

      // Transformer le DTO en modèle domain
      return userDto.toDomain();
    } catch (e) {
      // Propager l'exception ou la transformer si nécessaire
      rethrow;
    }
  }

  /// Connecter un utilisateur
  ///
  /// Convertit les credentials en requête,
  /// appelle le service, puis transforme la réponse en modèle domain
  Future<User> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Créer la requête
      final request = LoginRequest(
        phoneNumber: phoneNumber,
        password: password,
      );

      // Appeler le service
      final response = await _authService.login(request);

      // Récupérer les détails de l'utilisateur
      final userDto = await _authService.getUserById(response.userId);

      // Transformer le DTO en modèle domain
      return userDto.toDomain();
    } catch (e) {
      // Propager l'exception ou la transformer si nécessaire
      rethrow;
    }
  }

  /// Déconnecter l'utilisateur
  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      rethrow;
    }
  }

  /// Récupérer un utilisateur par son ID
  Future<User> getUserById(String userId) async {
    try {
      final userDto = await _authService.getUserById(userId);
      return userDto.toDomain();
    } catch (e) {
      rethrow;
    }
  }
}
