```md
# Plan d’Implémentation

## Plan : Création d’un projet Flutter avec Architecture MVVM + Riverpod pour l’Authentification

---

## Contexte

L’utilisateur souhaite créer un projet Flutter pédagogique pour comprendre :

- L’architecture **MVVM**
- Le package **Riverpod**

Le projet implémente un système d’authentification avec :

- **Connexion** : numéro de téléphone + mot de passe  
- **Création de compte** : pseudo + numéro de téléphone + mot de passe  

Le but est d’avoir une structure claire et organisée selon le pattern **MVVM** avec une séparation nette entre les couches :

- UI  
- Domain  
- Data  

---

# Architecture Choisie

## Structure MVVM avec Riverpod

- **UI Layer** : Vues (Views) + ViewModels + Widgets réutilisables  
- **Domain Layer** : Modèles métier (Entities)  
- **Data Layer** : DTOs + Repositories + Services  
- **Autres** : Config, Utils, Routing  

---

## Pattern d’authentification

- Utilisation de **Riverpod** pour la gestion d’état globale  
- **Repository Pattern** pour abstraire la source de données  
- **Services** pour simuler les appels API / BDD  
- **ViewModels** comme pont entre UI et logique métier  

---

# Fichiers Critiques à Créer

## 1. Configuration de base

- `pubspec.yaml` : Dépendances (flutter_riverpod, go_router, etc.)  
- `analysis_options.yaml` : Règles de lint  
- `main.dart` : Point d’entrée principal  
- `main_development.dart` : Environnement dev  
- `main_staging.dart` : Environnement staging  

---

## 2. Configuration et Routing

- `lib/config/app_config.dart` : Configuration de l’app  
- `lib/routing/app_router.dart` : Routes avec go_router  
- `lib/routing/route_names.dart` : Constantes de routes  

---

## 3. Domain Layer

- `lib/domain/models/user.dart` : Modèle métier `User`

---

## 4. Data Layer

- `lib/data/models/user_dto.dart` : DTO pour transfert de données  
- `lib/data/models/auth_request.dart` : Modèles de requêtes (login, register)  
- `lib/data/services/auth_service.dart` : Service d’authentification (simulé)  
- `lib/data/repositories/auth_repository.dart` : Repository d’authentification  

---

## 5. UI Core

- `lib/ui/core/themes/app_theme.dart` : Thème de l’application  
- `lib/ui/core/themes/app_colors.dart` : Couleurs  
- `lib/ui/core/widgets/custom_button.dart` : Bouton personnalisé  
- `lib/ui/core/widgets/custom_text_field.dart` : Champ de texte personnalisé  
- `lib/ui/core/widgets/loading_overlay.dart` : Indicateur de chargement  

---

## 6. Feature – Authentication

- `lib/ui/features/auth/view_models/auth_view_model.dart`  
- `lib/ui/features/auth/view_models/auth_state.dart`  
- `lib/ui/features/auth/views/login_view.dart`  
- `lib/ui/features/auth/views/register_view.dart`  
- `lib/ui/features/auth/widgets/phone_input_field.dart`  

---

## 7. Feature – Home (après connexion)

- `lib/ui/features/home/views/home_view.dart`

---

## 8. Utils

- `lib/utils/validators.dart` : Validation des formulaires  
- `lib/utils/constants.dart` : Constantes globales  

---

# Étapes d’Implémentation

---

## Phase 1 : Configuration du projet

1. Créer `pubspec.yaml` avec dépendances :
   - flutter_riverpod (^2.5.0)  
   - go_router (^14.0.0)  
   - freezed + freezed_annotation  
   - json_annotation  

2. Créer les fichiers `main` avec `ProviderScope`  
3. Configurer `analysis_options.yaml`

---

## Phase 2 : Configuration et Infrastructure

1. Créer `AppConfig` avec environnements  
2. Configurer le routing avec go_router  
3. Créer le thème de l’application  

---

## Phase 3 : Data Layer

1. Créer les modèles de données (DTOs)  
2. Implémenter `AuthService` (simulation en mémoire)  
3. Implémenter `AuthRepository`  

---

## Phase 4 : Domain Layer

1. Créer le modèle `User` (entity métier)

---

## Phase 5 : UI Core

1. Créer les widgets réutilisables  
2. Configurer le thème  

---

## Phase 6 : Feature Authentication

1. Créer `AuthState` (initial, loading, success, error)  
2. Créer `AuthViewModel` avec Riverpod `StateNotifier`  
3. Créer `LoginView` avec formulaire  
4. Créer `RegisterView` avec formulaire  
5. Créer les widgets spécifiques  

---

## Phase 7 : Feature Home

1. Créer `HomeView` pour afficher l’utilisateur connecté  

---

## Phase 8 : Utils

1. Créer les validators (téléphone, mot de passe, pseudo)  
2. Ajouter les constantes  

---

# Architecture MVVM Détaillée

## Flux de données

```

View → ViewModel → Repository → Service → Data Source (simulé)
↑
State Update

```

---

## Responsabilités

### View (UI)

- Affichage uniquement  
- Écoute du ViewModel via Riverpod  
- Déclenche les actions utilisateur  

### ViewModel

- Gère l’état local du feature  
- Contient la logique de présentation  
- Appelle le Repository  
- Expose des méthodes publiques pour la View  

### Repository

- Abstraction de la source de données  
- Orchestre les appels aux services  
- Transforme les DTOs en modèles Domain  

### Service

- Communication avec la source de données (API, BDD)  
- Dans ce projet : simulation en mémoire  

### Models

- **Domain** : représentation métier  
- **Data** : représentation technique (DTO)  

---

# Détails Techniques

## Riverpod Providers

- `authViewModelProvider` : StateNotifierProvider  
- `authRepositoryProvider` : Provider  
- `authServiceProvider` : Provider  

---

## Gestion d’État

- `AuthState` :
  - initial  
  - loading  
  - authenticated  
  - error  

- Utilisation de `StateNotifier` pour le ViewModel  
- `Consumer` / `ConsumerWidget` pour réagir aux changements  

---

## Routing

- GoRouter avec guards pour protéger les routes  
- Routes :
  - `/login`
  - `/register`
  - `/home`
- Redirection automatique si authentifié / non-authentifié  

---

## Validation

- Téléphone : format international ou local  
- Mot de passe : minimum 6 caractères  
- Pseudo : minimum 3 caractères, pas de caractères spéciaux  

---

# Vérification

## Tests manuels à effectuer

### 1. Inscription

- Créer un compte  
- Vérifier validation des champs  
- Vérifier navigation vers home après succès  

### 2. Connexion

- Se connecter avec téléphone + mot de passe  
- Tester les erreurs (mauvais identifiants)  
- Vérifier redirection vers home  

### 3. Navigation

- Vérifier qu’on ne peut pas accéder à `/home` sans connexion  
- Vérifier la déconnexion (si implémentée)  

### 4. Hot Reload

- Vérifier que l’état persiste pendant le développement  

---

# Structure Finale Attendue

```

lib/
│
├── ui/
│   ├── core/
│   │   ├── themes/
│   │   │   ├── app_theme.dart
│   │   │   └── app_colors.dart
│   │   └── widgets/
│   │       ├── custom_button.dart
│   │       ├── custom_text_field.dart
│   │       └── loading_overlay.dart
│   │
│   └── features/
│       ├── auth/
│       │   ├── view_models/
│       │   │   ├── auth_view_model.dart
│       │   │   └── auth_state.dart
│       │   ├── views/
│       │   │   ├── login_view.dart
│       │   │   └── register_view.dart
│       │   └── widgets/
│       │       └── phone_input_field.dart
│       │
│       └── home/
│           └── views/
│               └── home_view.dart
│
├── domain/
│   └── models/
│       └── user.dart
│
├── data/
│   ├── models/
│   │   ├── user_dto.dart
│   │   └── auth_request.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── services/
│       └── auth_service.dart
│
├── config/
│   └── app_config.dart
│
├── utils/
│   ├── validators.dart
│   └── constants.dart
│
├── routing/
│   ├── app_router.dart
│   └── route_names.dart
│
├── main.dart
├── main_development.dart
└── main_staging.dart

```

---

# Notes Importantes

- **Pédagogie** : Code commenté pour expliquer MVVM et Riverpod  
- **Simplicité** : Pas de base de données réelle (simulation en mémoire)  
- **Extensibilité** : Architecture prête pour ajouter d’autres features  
- **Best Practices** : Séparation claire des responsabilités, code testable  
```
