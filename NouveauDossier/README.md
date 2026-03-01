# Flutter MVVM Auth

Projet pédagogique Flutter démontrant l'architecture **MVVM** (Model-View-ViewModel) avec **Riverpod** pour la gestion d'état.

## 📋 Description

Ce projet implémente un système d'authentification complet avec :
- **Connexion** : numéro de téléphone + mot de passe
- **Inscription** : pseudo + numéro de téléphone + mot de passe
- **Page d'accueil** : affichage du profil utilisateur après connexion

## 🏗️ Architecture MVVM

### Structure du Projet

```
lib/
├── ui/                          # Couche Présentation (View + ViewModel)
│   ├── core/
│   │   ├── themes/              # Thèmes et couleurs
│   │   └── widgets/             # Widgets réutilisables
│   └── features/
│       ├── auth/                # Feature Authentification
│       │   ├── view_models/     # ViewModels (logique présentation)
│       │   ├── views/           # Views (UI)
│       │   └── widgets/         # Widgets spécifiques
│       └── home/                # Feature Accueil
│           └── views/
├── domain/                      # Couche Métier
│   └── models/                  # Entités métier (User)
├── data/                        # Couche Données
│   ├── models/                  # DTOs (Data Transfer Objects)
│   ├── repositories/            # Repositories (abstraction)
│   └── services/                # Services (API simulée)
├── config/                      # Configuration
├── utils/                       # Utilitaires
└── routing/                     # Navigation
```

### Flux de Données

```
┌─────────┐      ┌────────────┐      ┌────────────┐      ┌─────────┐
│  View   │─────→│ ViewModel  │─────→│ Repository │─────→│ Service │
│   (UI)  │      │  (Logic)   │      │(Abstraction)      │  (API)  │
└─────────┘      └────────────┘      └────────────┘      └─────────┘
     ↑                  │
     └──────────────────┘
         State Update
```

### Responsabilités des Couches

#### 🎨 **View (UI Layer)**
- Affiche l'interface utilisateur
- Capture les événements utilisateur
- Observe les changements d'état du ViewModel
- **Aucune logique métier**

**Exemple** : `login_view.dart`
```dart
class LoginView extends ConsumerStatefulWidget {
  // Écoute l'état via ref.watch()
  // Déclenche les actions via ref.read().method()
}
```

#### 🧠 **ViewModel**
- Gère l'état de la feature
- Contient la logique de présentation
- Fait le pont entre View et Repository
- Expose des méthodes pour les actions utilisateur
- Notifie la View des changements d'état

**Exemple** : `auth_view_model.dart`
```dart
class AuthViewModel extends StateNotifier<AuthState> {
  Future<void> login({required String phoneNumber, required String password}) async {
    state = AuthState.loading();
    final user = await _repository.login(...);
    state = AuthState.authenticated(user);
  }
}
```

#### 📦 **Repository**
- Abstraction de la source de données
- Orchestre les appels aux services
- Transforme les DTOs en modèles domain
- Gère le cache (si nécessaire)

**Exemple** : `auth_repository.dart`
```dart
class AuthRepository {
  Future<User> login({required String phoneNumber, required String password}) async {
    final response = await _authService.login(...);
    return userDto.toDomain(); // DTO → Domain
  }
}
```

#### 🌐 **Service**
- Communication avec les sources de données (API, BDD)
- Dans ce projet : simulation en mémoire
- Gère les appels HTTP/Base de données

**Exemple** : `auth_service.dart`
```dart
class AuthService {
  Future<AuthResponse> login(LoginRequest request) async {
    // Simulation d'un appel API
    await Future.delayed(Duration(seconds: 1));
    return AuthResponse(...);
  }
}
```

#### 🎯 **Domain Models**
- Représentation métier pure
- Indépendants de la couche data
- Contiennent la logique métier
- Immutables (avec Freezed)

**Exemple** : `user.dart`
```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String pseudo,
    required String phoneNumber,
  }) = _User;
}
```

## 🔧 Technologies Utilisées

- **Flutter** : Framework UI
- **Riverpod** : Gestion d'état et injection de dépendances
- **go_router** : Navigation déclarative
- **Freezed** : Modèles immutables et union types
- **json_serializable** : Sérialisation JSON

## 📦 Dépendances Principales

```yaml
dependencies:
  flutter_riverpod: ^2.5.0    # State management
  go_router: ^14.0.0          # Navigation
  freezed_annotation: ^2.4.1  # Code generation
  json_annotation: ^4.8.1     # JSON serialization

dev_dependencies:
  build_runner: ^2.4.7        # Code generation
  freezed: ^2.4.6             # Freezed generator
  json_serializable: ^6.7.1   # JSON generator
```

## 🚀 Installation et Lancement

### Prérequis
- Flutter SDK (>=3.0.0)
- Dart SDK

### Installation

1. **Cloner le projet** (ou créer les fichiers)
   ```bash
   cd flutter_mvvm_auth
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers Freezed** (pour les modèles immutables)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Lancer l'Application

**Environnement de développement** (par défaut)
```bash
flutter run
```

**Environnement de développement** (explicite)
```bash
flutter run -t lib/main_development.dart
```

**Environnement de staging**
```bash
flutter run -t lib/main_staging.dart
```

**Environnement de production**
```bash
flutter run -t lib/main.dart
```

## 📱 Utilisation

### 1. Inscription
1. Au démarrage, cliquez sur **"S'inscrire"**
2. Remplissez le formulaire :
   - **Pseudo** : 3-20 caractères (lettres, chiffres, _ et -)
   - **Téléphone** : 10 chiffres (format français, commence par 0)
   - **Mot de passe** : minimum 6 caractères
3. Confirmez le mot de passe
4. Cliquez sur **"S'inscrire"**

### 2. Connexion
1. Entrez votre numéro de téléphone
2. Entrez votre mot de passe
3. Cliquez sur **"Se connecter"**

### 3. Page d'Accueil
- Affiche votre profil (pseudo, téléphone, ancienneté)
- Permet de se déconnecter via l'icône en haut à droite

## 🎯 Concepts Pédagogiques

### Riverpod - Gestion d'État

#### Provider
```dart
// Expose une instance (singleton)
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
```

#### StateNotifierProvider
```dart
// Expose un StateNotifier pour l'état mutable
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});
```

#### Consommer un Provider
```dart
// Dans un ConsumerWidget
@override
Widget build(BuildContext context, WidgetRef ref) {
  // Écouter les changements
  final authState = ref.watch(authViewModelProvider);

  // Lire sans écouter
  final viewModel = ref.read(authViewModelProvider.notifier);

  return ...;
}
```

#### Listen (effets de bord)
```dart
// Réagir aux changements d'état
ref.listen<AuthState>(authViewModelProvider, (previous, next) {
  next.maybeWhen(
    error: (message) => showSnackBar(message),
    orElse: () {},
  );
});
```

### Freezed - Modèles Immutables

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}

// Pattern matching
authState.when(
  initial: () => ...,
  loading: () => ...,
  authenticated: (user) => ...,
  error: (message) => ...,
);
```

### Go Router - Navigation

```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) {
      // Logique de redirection basée sur l'état
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginView()),
      GoRoute(path: '/home', builder: (context, state) => HomeView()),
    ],
  );
});

// Navigation
context.push('/register');  // Naviguer
context.pop();              // Retour
context.go('/home');        // Navigation sans historique
```

## 🧪 Tests Manuels

### Scénario 1 : Inscription Réussie
1. Lancer l'app → page de connexion
2. Cliquer sur "S'inscrire"
3. Remplir : pseudo="test_user", tel="0612345678", mdp="test123"
4. ✅ Redirection automatique vers la page d'accueil
5. ✅ Affichage du profil utilisateur

### Scénario 2 : Connexion Réussie
1. Après inscription, cliquer sur "Déconnexion"
2. Entrer : tel="0612345678", mdp="test123"
3. Cliquer sur "Se connecter"
4. ✅ Redirection vers la page d'accueil

### Scénario 3 : Validation des Champs
1. Essayer de soumettre un formulaire vide
2. ✅ Messages d'erreur sous chaque champ
3. Entrer un téléphone invalide (ex: "123")
4. ✅ Message "Le numéro doit contenir 10 chiffres"

### Scénario 4 : Erreurs Métier
1. Créer un compte avec tel="0611111111"
2. Se déconnecter
3. Essayer de créer un nouveau compte avec tel="0611111111"
4. ✅ Message "Ce numéro de téléphone est déjà utilisé"

### Scénario 5 : Protection des Routes
1. Lancer l'app → page de connexion
2. Essayer d'accéder manuellement à `/home` (via URL ou code)
3. ✅ Redirection automatique vers `/login`

## 🔍 Points d'Attention

### ✅ Bonnes Pratiques Appliquées

1. **Séparation des responsabilités** : Chaque couche a un rôle précis
2. **Immutabilité** : Utilisation de Freezed pour des états immutables
3. **Injection de dépendances** : Via Riverpod providers
4. **Navigation déclarative** : Go Router avec redirection automatique
5. **Code commenté** : Explication des concepts clés
6. **Validation centralisée** : Classe Validators réutilisable
7. **Widgets réutilisables** : CustomButton, CustomTextField, etc.

### 🎓 Concepts MVVM Démontrés

- ✅ **Séparation View/ViewModel** : View = UI pure, ViewModel = logique
- ✅ **Data Binding** : Via Riverpod (ref.watch)
- ✅ **State Management** : StateNotifier pour état immutable
- ✅ **Repository Pattern** : Abstraction de la source de données
- ✅ **DTO ↔ Domain** : Transformation entre couches
- ✅ **Dependency Injection** : Providers Riverpod

## 📚 Ressources Complémentaires

### Documentation Officielle
- [Flutter](https://flutter.dev/docs)
- [Riverpod](https://riverpod.dev)
- [Go Router](https://pub.dev/packages/go_router)
- [Freezed](https://pub.dev/packages/freezed)

### Patterns Architecturaux
- [MVVM Pattern](https://fr.wikipedia.org/wiki/Mod%C3%A8le-vue-vue_mod%C3%A8le)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Repository Pattern](https://martinfowler.com/eaaCatalog/repository.html)

## 🤝 Contribution

Ce projet est pédagogique. N'hésitez pas à :
- Ajouter des features (reset password, email, etc.)
- Implémenter de vrais appels API
- Ajouter une couche de persistence (SharedPreferences, Hive, etc.)
- Écrire des tests unitaires et d'intégration

## 📝 Licence

Projet pédagogique libre d'utilisation.

## ✨ Prochaines Étapes Possibles

- [ ] Ajouter une vraie API backend
- [ ] Implémenter le stockage local (tokens, user)
- [ ] Ajouter refresh token et auto-login
- [ ] Implémenter "Mot de passe oublié"
- [ ] Ajouter des tests unitaires
- [ ] Ajouter des tests d'intégration
- [ ] Implémenter un thème sombre
- [ ] Ajouter l'internationalisation (i18n)
- [ ] Gérer les erreurs réseau plus finement
- [ ] Ajouter des animations

---

**Happy Coding! 🚀**
