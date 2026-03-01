import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/services/auth_service.dart';
import 'auth_state.dart';

/// Provider pour le AuthViewModel
///
/// StateNotifierProvider qui expose le ViewModel d'authentification
/// à toute l'application via Riverpod
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthViewModel(authRepository);
});

/// ViewModel pour l'authentification
///
/// Responsabilités (pattern MVVM):
/// - Gérer l'état d'authentification
/// - Exposer des méthodes pour les actions utilisateur (login, register, logout)
/// - Communiquer avec le Repository (couche data)
/// - Notifier les Views des changements d'état
///
/// Hérite de StateNotifier pour gérer l'état de manière immutable
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  /// Constructeur
  /// Initialise l'état à initial (non authentifié)
  AuthViewModel(this._authRepository) : super(const AuthState.initial());

  /// Connexion d'un utilisateur
  ///
  /// Appelé depuis la View (LoginView)
  /// 1. Met l'état en loading
  /// 2. Appelle le repository
  /// 3. Met à jour l'état selon le résultat (authenticated ou error)
  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Mettre l'état en loading
      state = const AuthState.loading();

      // Appeler le repository
      final user = await _authRepository.login(
        phoneNumber: phoneNumber,
        password: password,
      );

      // Mettre à jour l'état avec l'utilisateur authentifié
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      // Gérer les erreurs métier
      state = AuthState.error(e.message);
    } catch (e) {
      // Gérer les erreurs inattendues
      state = AuthState.error('Une erreur inattendue s\'est produite');
    }
  }

  /// Inscription d'un nouvel utilisateur
  ///
  /// Appelé depuis la View (RegisterView)
  /// 1. Met l'état en loading
  /// 2. Appelle le repository
  /// 3. Met à jour l'état selon le résultat (authenticated ou error)
  Future<void> register({
    required String pseudo,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Mettre l'état en loading
      state = const AuthState.loading();

      // Appeler le repository
      final user = await _authRepository.register(
        pseudo: pseudo,
        phoneNumber: phoneNumber,
        password: password,
      );

      // Mettre à jour l'état avec l'utilisateur authentifié
      state = AuthState.authenticated(user);
    } on AuthException catch (e) {
      // Gérer les erreurs métier
      state = AuthState.error(e.message);
    } catch (e) {
      // Gérer les erreurs inattendues
      state = AuthState.error('Une erreur inattendue s\'est produite');
    }
  }

  /// Déconnexion de l'utilisateur
  ///
  /// Appelé depuis la View (HomeView par exemple)
  /// 1. Met l'état en loading
  /// 2. Appelle le repository
  /// 3. Met à jour l'état à unauthenticated
  Future<void> logout() async {
    try {
      // Mettre l'état en loading
      state = const AuthState.loading();

      // Appeler le repository
      await _authRepository.logout();

      // Mettre à jour l'état à déconnecté
      state = const AuthState.unauthenticated();
    } catch (e) {
      // En cas d'erreur, forcer la déconnexion quand même
      state = const AuthState.unauthenticated();
    }
  }

  /// Réinitialiser l'état (utile pour effacer les erreurs)
  void resetState() {
    state = const AuthState.initial();
  }
}
