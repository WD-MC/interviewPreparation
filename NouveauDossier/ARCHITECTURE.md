# Architecture du Projet - Flutter MVVM Auth

## Vue d'Ensemble

Ce document détaille l'architecture MVVM (Model-View-ViewModel) implémentée dans ce projet Flutter avec Riverpod.

## Diagramme d'Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        PRESENTATION LAYER                         │
│  ┌─────────────┐                           ┌─────────────────┐  │
│  │    View     │◄──────── observes ────────│   ViewModel     │  │
│  │   (UI)      │                           │    (Logic)      │  │
│  └─────────────┘                           └─────────────────┘  │
│        │                                           │             │
│        │ triggers                                  │ calls       │
│        │ actions                                   │             │
│        ▼                                           ▼             │
└────────┼───────────────────────────────────────────┼─────────────┘
         │                                           │
         │                                           │
┌────────┼───────────────────────────────────────────┼─────────────┐
│        │              DOMAIN LAYER                 │             │
│        │          ┌──────────────┐                 │             │
│        └─────────►│    Models    │◄────────────────┘             │
│                   │  (Entities)  │                               │
│                   └──────────────┘                               │
└──────────────────────────┬───────────────────────────────────────┘
                           │
                           │ uses
                           │
┌──────────────────────────┼───────────────────────────────────────┐
│                          │        DATA LAYER                     │
│                          ▼                                        │
│              ┌────────────────────┐                              │
│              │    Repository      │                              │
│              │   (Abstraction)    │                              │
│              └────────────────────┘                              │
│                          │                                        │
│                          │ orchestrates                           │
│                          ▼                                        │
│              ┌────────────────────┐                              │
│              │      Service       │                              │
│              │     (API/BDD)      │                              │
│              └────────────────────┘                              │
│                          │                                        │
│                          ▼                                        │
│              ┌────────────────────┐                              │
│              │    Data Source     │                              │
│              │   (API/Database)   │                              │
│              └────────────────────┘                              │
└───────────────────────────────────────────────────────────────────┘
```

## Couches en Détail

### 1. Presentation Layer (UI)

#### View
**Responsabilité** : Affichage et interaction utilisateur

**Caractéristiques** :
- Widgets Flutter (Stateless/Stateful/Consumer)
- Aucune logique métier
- Observe le ViewModel via Riverpod
- Déclenche les actions du ViewModel

**Exemple** :
```dart
// lib/ui/features/auth/views/login_view.dart
class LoginView extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observer l'état
    final authState = ref.watch(authViewModelProvider);

    // Déclencher une action
    onPressed: () {
      ref.read(authViewModelProvider.notifier).login(phone, password);
    }
  }
}
```

#### ViewModel
**Responsabilité** : Logique de présentation et gestion d'état

**Caractéristiques** :
- StateNotifier<State>
- Expose des méthodes publiques pour les actions
- Communique avec le Repository
- Notifie la View des changements d'état
- Transforme les données métier en données d'affichage

**Exemple** :
```dart
// lib/ui/features/auth/view_models/auth_view_model.dart
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  Future<void> login({required String phone, required String password}) async {
    state = AuthState.loading();
    try {
      final user = await _repository.login(phone: phone, password: password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
```

#### State
**Responsabilité** : Représentation de l'état UI

**Caractéristiques** :
- Immutable (avec Freezed)
- Union types pour différents états
- Pattern matching

**Exemple** :
```dart
// lib/ui/features/auth/view_models/auth_state.dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

### 2. Domain Layer (Métier)

#### Models (Entities)
**Responsabilité** : Représentation métier pure

**Caractéristiques** :
- Indépendants de toute autre couche
- Immutables (avec Freezed)
- Contiennent la logique métier (getters, méthodes)
- Pas de dépendance Flutter

**Exemple** :
```dart
// lib/domain/models/user.dart
@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String pseudo,
    required String phoneNumber,
  }) = _User;

  // Logique métier
  String get displayName => pseudo;
  String get initial => pseudo[0].toUpperCase();
}
```

### 3. Data Layer (Données)

#### Repository
**Responsabilité** : Abstraction de la source de données

**Caractéristiques** :
- Interface entre domain et data
- Orchestre les appels aux services
- Transforme DTOs en entities domain
- Gère le cache (optionnel)
- Gestion d'erreurs

**Exemple** :
```dart
// lib/data/repositories/auth_repository.dart
class AuthRepository {
  final AuthService _service;

  Future<User> login({required String phone, required String password}) async {
    final request = LoginRequest(phoneNumber: phone, password: password);
    final response = await _service.login(request);
    final userDto = await _service.getUserById(response.userId);
    return userDto.toDomain(); // DTO → Domain
  }
}
```

#### Service
**Responsabilité** : Communication avec les sources de données

**Caractéristiques** :
- Appels HTTP/API
- Requêtes base de données
- Gestion des erreurs réseau
- Dans ce projet : simulation en mémoire

**Exemple** :
```dart
// lib/data/services/auth_service.dart
class AuthService {
  Future<AuthResponse> login(LoginRequest request) async {
    // Simulation API
    await Future.delayed(Duration(seconds: 1));

    // Vérification credentials
    final user = _users.firstWhere(
      (u) => u.phoneNumber == request.phoneNumber,
      orElse: () => throw AuthException('Invalid credentials'),
    );

    return AuthResponse(userId: user.id, token: 'token_xxx');
  }
}
```

#### DTO (Data Transfer Object)
**Responsabilité** : Représentation technique des données

**Caractéristiques** :
- Modèles pour sérialisation JSON
- Transformation vers/depuis domain
- Annotations json_serializable

**Exemple** :
```dart
// lib/data/models/user_dto.dart
@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String pseudo,
    required String phoneNumber,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  // DTO → Domain
  User toDomain() => User(
    id: id,
    pseudo: pseudo,
    phoneNumber: phoneNumber,
  );
}
```

## Flux de Données

### Flux Descendant (View → Data)
```
1. User interacts with View (ex: clicks login button)
   └─→ View calls ViewModel method
       └─→ ViewModel updates state to loading
           └─→ ViewModel calls Repository method
               └─→ Repository creates request DTO
                   └─→ Repository calls Service
                       └─→ Service executes API call
                           └─→ Service returns response DTO
               └─→ Repository transforms DTO to Domain model
           └─→ ViewModel updates state with result
   └─→ View observes state change and rebuilds UI
```

### Flux Montant (Data → View)
```
1. Service returns data (DTO)
   └─→ Repository transforms DTO to Domain entity
       └─→ Repository returns entity to ViewModel
           └─→ ViewModel updates State with entity
               └─→ Riverpod notifies listeners
                   └─→ View rebuilds with new state
```

## Riverpod - Dependency Injection

### Providers Hierarchy
```
authViewModelProvider (StateNotifierProvider)
    ├─→ depends on: authRepositoryProvider
    │
authRepositoryProvider (Provider)
    ├─→ depends on: authServiceProvider
    │
authServiceProvider (Provider)
    └─→ creates: AuthService instance
```

### Code
```dart
// Service Provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthRepository(service);
});

// ViewModel Provider
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});
```

## Navigation avec Go Router

### Configuration
```dart
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    redirect: (context, state) {
      final isAuthenticated = authState.user != null;
      final isAuthRoute = state.matchedLocation.startsWith('/login');

      // Redirection logic
      if (isAuthenticated && isAuthRoute) return '/home';
      if (!isAuthenticated && !isAuthRoute) return '/login';

      return null; // No redirect
    },
    routes: [...],
  );
});
```

## Bonnes Pratiques Appliquées

### 1. Séparation des Responsabilités
- ✅ Chaque couche a un rôle distinct
- ✅ Pas de logique métier dans la View
- ✅ Pas de dépendances UI dans le Domain

### 2. Immutabilité
- ✅ États immutables avec Freezed
- ✅ copyWith pour les modifications

### 3. Injection de Dépendances
- ✅ Via Riverpod providers
- ✅ Testabilité facilitée

### 4. Transformation de Données
- ✅ DTO (data) ↔ Entity (domain)
- ✅ Séparation claire des modèles

### 5. Gestion d'Erreurs
- ✅ Exceptions métier (AuthException)
- ✅ États d'erreur dans le ViewModel
- ✅ Affichage user-friendly dans la View

## Extensibilité

### Ajouter une Nouvelle Feature

1. **Créer la structure**
   ```
   lib/ui/features/new_feature/
   ├── view_models/
   │   ├── new_feature_view_model.dart
   │   └── new_feature_state.dart
   ├── views/
   │   └── new_feature_view.dart
   └── widgets/
   ```

2. **Créer le ViewModel**
   ```dart
   class NewFeatureViewModel extends StateNotifier<NewFeatureState> {
     final NewFeatureRepository _repository;
     // ...
   }
   ```

3. **Créer le Provider**
   ```dart
   final newFeatureViewModelProvider =
     StateNotifierProvider<NewFeatureViewModel, NewFeatureState>((ref) {
       final repository = ref.watch(newFeatureRepositoryProvider);
       return NewFeatureViewModel(repository);
     });
   ```

4. **Créer la View**
   ```dart
   class NewFeatureView extends ConsumerWidget {
     @override
     Widget build(BuildContext context, WidgetRef ref) {
       final state = ref.watch(newFeatureViewModelProvider);
       // ...
     }
   }
   ```

## Testing Strategy

### Tests Unitaires
- **ViewModels** : Tester la logique métier
- **Repositories** : Tester les transformations
- **Services** : Mocker les réponses API
- **Validators** : Tester toutes les règles

### Tests d'Intégration
- Flux complets (login, register)
- Navigation
- Gestion d'erreurs

### Tests de Widgets
- Views avec états différents
- Interactions utilisateur

## Conclusion

Cette architecture MVVM avec Riverpod offre :
- ✅ **Séparation claire** des responsabilités
- ✅ **Testabilité** : chaque couche testable indépendamment
- ✅ **Maintenabilité** : code organisé et documenté
- ✅ **Scalabilité** : facile d'ajouter de nouvelles features
- ✅ **Réactivité** : state management avec Riverpod
- ✅ **Type Safety** : Dart + Freezed

---

Pour toute question sur l'architecture, consultez le code source qui est abondamment commenté.
