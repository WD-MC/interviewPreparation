import 'dart:async';
import '../models/auth_request.dart';
import '../models/user_dto.dart';

/// Exception personnalisée pour les erreurs d'authentification
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

/// Service d'authentification
///
/// Simule les appels API pour l'authentification
/// Dans un vrai projet, ce service ferait des appels HTTP
class AuthService {
  // Base de données simulée en mémoire
  final Map<String, _StoredUser> _users = {};

  // Simuler un délai réseau
  static const _networkDelay = Duration(milliseconds: 1000);

  /// Inscription d'un nouvel utilisateur
  ///
  /// Simule un appel POST /api/auth/register
  Future<AuthResponse> register(RegisterRequest request) async {
    await Future.delayed(_networkDelay);

    // Vérifier si le numéro de téléphone existe déjà
    if (_users.values.any((u) => u.phoneNumber == request.phoneNumber)) {
      throw AuthException('Ce numéro de téléphone est déjà utilisé');
    }

    // Vérifier si le pseudo existe déjà
    if (_users.values.any((u) => u.pseudo == request.pseudo)) {
      throw AuthException('Ce pseudo est déjà utilisé');
    }

    // Créer un nouvel utilisateur
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    final token = 'token_${DateTime.now().millisecondsSinceEpoch}';

    _users[userId] = _StoredUser(
      id: userId,
      pseudo: request.pseudo,
      phoneNumber: request.phoneNumber,
      password: request.password, // En production, hasher le mot de passe !
      createdAt: DateTime.now(),
    );

    return AuthResponse(
      userId: userId,
      token: token,
      message: 'Inscription réussie',
    );
  }

  /// Connexion d'un utilisateur
  ///
  /// Simule un appel POST /api/auth/login
  Future<AuthResponse> login(LoginRequest request) async {
    await Future.delayed(_networkDelay);

    // Trouver l'utilisateur par numéro de téléphone
    final user = _users.values.firstWhere(
      (u) => u.phoneNumber == request.phoneNumber,
      orElse: () => throw AuthException('Numéro de téléphone ou mot de passe incorrect'),
    );

    // Vérifier le mot de passe
    if (user.password != request.password) {
      throw AuthException('Numéro de téléphone ou mot de passe incorrect');
    }

    // Générer un token
    final token = 'token_${DateTime.now().millisecondsSinceEpoch}';

    return AuthResponse(
      userId: user.id,
      token: token,
      message: 'Connexion réussie',
    );
  }

  /// Récupérer les informations d'un utilisateur
  ///
  /// Simule un appel GET /api/users/{userId}
  Future<UserDto> getUserById(String userId) async {
    await Future.delayed(_networkDelay);

    final user = _users[userId];
    if (user == null) {
      throw AuthException('Utilisateur non trouvé');
    }

    return UserDto(
      id: user.id,
      pseudo: user.pseudo,
      phoneNumber: user.phoneNumber,
      createdAt: user.createdAt,
    );
  }

  /// Déconnexion (pour simulation)
  Future<void> logout() async {
    await Future.delayed(_networkDelay);
    // Dans un vrai projet, invalider le token côté serveur
  }
}

/// Classe privée pour stocker les utilisateurs en mémoire
class _StoredUser {
  final String id;
  final String pseudo;
  final String phoneNumber;
  final String password;
  final DateTime createdAt;

  _StoredUser({
    required this.id,
    required this.pseudo,
    required this.phoneNumber,
    required this.password,
    required this.createdAt,
  });
}
