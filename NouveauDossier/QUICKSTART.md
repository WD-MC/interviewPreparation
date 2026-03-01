# Guide de Démarrage Rapide

## 🚀 Installation et Premier Lancement

### 1. Installation des Dépendances

```bash
flutter pub get
```

### 2. Génération des Fichiers Freezed

⚠️ **IMPORTANT** : Cette étape est obligatoire avant de lancer l'application.

Les modèles utilisent Freezed qui nécessite de générer du code :

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Alternative** (génération continue pendant le développement) :
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 3. Lancer l'Application

```bash
flutter run
```

Ou avec un environnement spécifique :
```bash
# Développement
flutter run -t lib/main_development.dart

# Staging
flutter run -t lib/main_staging.dart

# Production
flutter run -t lib/main.dart
```

## 📱 Premiers Pas

### Créer un Compte

1. Au lancement, vous êtes sur la page de **Connexion**
2. Cliquez sur **"S'inscrire"**
3. Remplissez le formulaire :
   - **Pseudo** : Exemple `john_doe`
   - **Téléphone** : Exemple `0612345678` (10 chiffres)
   - **Mot de passe** : Minimum 6 caractères
4. Cliquez sur **"S'inscrire"**
5. ✅ Vous êtes automatiquement connecté et redirigé vers l'accueil

### Se Connecter

1. Utilisez les identifiants créés :
   - Téléphone : `0612345678`
   - Mot de passe : celui que vous avez choisi
2. Cliquez sur **"Se connecter"**
3. ✅ Redirection vers l'accueil

### Page d'Accueil

- Affiche votre **profil** complet
- Badge "Nouveau membre" si compte < 7 jours
- Bouton **déconnexion** en haut à droite

## 🛠️ Commandes Utiles

### Développement

```bash
# Nettoyer le projet
flutter clean

# Récupérer les dépendances
flutter pub get

# Vérifier les problèmes
flutter analyze

# Formater le code
flutter format lib/

# Lancer les tests (quand implémentés)
flutter test
```

### Build Runner (Génération de Code)

```bash
# Générer une seule fois
flutter pub run build_runner build --delete-conflicting-outputs

# Mode watch (regénère automatiquement)
flutter pub run build_runner watch --delete-conflicting-outputs

# Nettoyer les fichiers générés
flutter pub run build_runner clean
```

## 📂 Structure du Code

```
lib/
├── main.dart                    # Point d'entrée production
├── main_development.dart        # Point d'entrée dev
├── main_staging.dart            # Point d'entrée staging
│
├── config/                      # Configuration
│   └── app_config.dart         # Environnements
│
├── routing/                     # Navigation
│   ├── app_router.dart         # Configuration GoRouter
│   └── route_names.dart        # Constantes des routes
│
├── domain/                      # Modèles métier
│   └── models/
│       └── user.dart           # Entité User
│
├── data/                        # Couche données
│   ├── models/                 # DTOs
│   │   ├── user_dto.dart
│   │   └── auth_request.dart
│   ├── repositories/           # Repositories
│   │   └── auth_repository.dart
│   └── services/               # Services (API simulée)
│       └── auth_service.dart
│
├── ui/                          # Interface utilisateur
│   ├── core/                   # Éléments réutilisables
│   │   ├── themes/
│   │   │   ├── app_theme.dart
│   │   │   └── app_colors.dart
│   │   └── widgets/
│   │       ├── custom_button.dart
│   │       ├── custom_text_field.dart
│   │       └── loading_overlay.dart
│   └── features/               # Features par domaine
│       ├── auth/               # Authentification
│       │   ├── view_models/
│       │   │   ├── auth_view_model.dart
│       │   │   └── auth_state.dart
│       │   ├── views/
│       │   │   ├── login_view.dart
│       │   │   └── register_view.dart
│       │   └── widgets/
│       │       └── phone_input_field.dart
│       └── home/               # Accueil
│           └── views/
│               └── home_view.dart
│
└── utils/                       # Utilitaires
    ├── validators.dart         # Validation formulaires
    └── constants.dart          # Constantes globales
```

## 🧪 Tests de Validation

### Test 1 : Inscription
- [ ] Formulaire d'inscription s'affiche
- [ ] Validation des champs fonctionne
- [ ] Inscription réussie redirige vers accueil
- [ ] Erreur si numéro déjà utilisé

### Test 2 : Connexion
- [ ] Formulaire de connexion s'affiche
- [ ] Connexion réussie avec bons identifiants
- [ ] Erreur avec mauvais identifiants
- [ ] Redirection vers accueil après connexion

### Test 3 : Navigation
- [ ] Impossible d'accéder à /home sans connexion
- [ ] Redirection automatique vers /login si non connecté
- [ ] Redirection automatique vers /home si déjà connecté
- [ ] Déconnexion ramène à /login

### Test 4 : UI
- [ ] Loading overlay s'affiche pendant les requêtes
- [ ] Messages d'erreur s'affichent en snackbar
- [ ] Champs de formulaire ont validation en temps réel
- [ ] Mot de passe masqué avec toggle visible/caché

## 🔍 Débogage

### Problème : "Target of URI doesn't exist"

**Cause** : Fichiers Freezed non générés

**Solution** :
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Problème : "Provider not found"

**Cause** : ProviderScope manquant ou provider mal déclaré

**Solution** :
1. Vérifier que `ProviderScope` enveloppe l'app dans `main.dart`
2. Vérifier l'import du provider

### Problème : Hot Reload ne fonctionne pas

**Solution** :
- Pour les changements de providers : Hot Restart (`R` dans le terminal)
- Pour les changements UI : Hot Reload (`r` dans le terminal)

## 📖 Prochaines Étapes

1. **Lire** `README.md` pour comprendre l'architecture complète
2. **Consulter** `ARCHITECTURE.md` pour les détails techniques
3. **Explorer** le code commenté dans `lib/`
4. **Modifier** et expérimenter avec le code
5. **Ajouter** de nouvelles features (voir suggestions dans README)

## 💡 Concepts Clés à Retenir

### MVVM
```
View ←→ ViewModel ←→ Repository ←→ Service
```

### Riverpod
```dart
// Écouter un provider
final state = ref.watch(authViewModelProvider);

// Appeler une méthode
ref.read(authViewModelProvider.notifier).login(...);
```

### Freezed
```dart
// États immutables avec union types
@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success() = _Success;
}
```

## 🎯 Objectifs Pédagogiques

Après avoir étudié ce projet, vous devriez comprendre :

- ✅ L'architecture MVVM et ses avantages
- ✅ La gestion d'état avec Riverpod
- ✅ Le pattern Repository
- ✅ La séparation des couches (UI/Domain/Data)
- ✅ L'injection de dépendances
- ✅ La navigation déclarative avec GoRouter
- ✅ Les modèles immutables avec Freezed

## 📞 Support

Pour toute question ou problème :
1. Consultez les commentaires dans le code
2. Lisez `ARCHITECTURE.md` pour les détails techniques
3. Vérifiez que tous les fichiers Freezed sont générés

---

**Bon apprentissage ! 🎓**
