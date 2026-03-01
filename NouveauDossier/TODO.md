# TODOs et Améliorations Futures

Ce document liste les améliorations possibles et extensions du projet.

## 🔧 Améliorations Techniques

### Priorité Haute

- [ ] **Tests Unitaires**
  - Tests pour AuthViewModel
  - Tests pour AuthRepository
  - Tests pour Validators
  - Tests pour les modèles domain

- [ ] **Tests d'Intégration**
  - Flux complet login → home
  - Flux complet register → home
  - Navigation et redirection

- [ ] **Tests de Widgets**
  - Tests pour LoginView
  - Tests pour RegisterView
  - Tests pour HomeView

### Priorité Moyenne

- [ ] **Gestion des Erreurs Améliorée**
  - Créer une classe Result<T, E> pour gérer succès/erreur
  - Implémenter un ErrorHandler global
  - Logger les erreurs (Firebase Crashlytics, Sentry)

- [ ] **Persistence Locale**
  - Sauvegarder le token avec flutter_secure_storage
  - Cache des données utilisateur
  - Auto-login si token valide

- [ ] **Backend Réel**
  - Remplacer AuthService simulé par de vrais appels HTTP
  - Utiliser Dio pour les requêtes
  - Implémenter refresh token
  - Gérer les timeouts et retry

- [ ] **Loading States**
  - Skeleton screens au lieu de simples loaders
  - Progress indicators plus détaillés
  - Shimmer effects

### Priorité Basse

- [ ] **Internationalisation (i18n)**
  - Support multilingue (FR/EN)
  - Utiliser flutter_localizations
  - Extraire tous les strings

- [ ] **Thème Sombre**
  - Implémenter un thème dark
  - Toggle dark/light mode
  - Sauvegarder la préférence

- [ ] **Animations**
  - Animations de transitions entre pages
  - Animations pour les boutons
  - Micro-interactions

## 🚀 Nouvelles Features

### Authentification

- [ ] **Mot de Passe Oublié**
  - Page de reset password
  - Envoi d'email/SMS de reset
  - Validation du code

- [ ] **Authentification Biométrique**
  - Touch ID / Face ID
  - Fallback sur PIN

- [ ] **Authentification Sociale**
  - Login avec Google
  - Login avec Apple
  - Login avec Facebook

- [ ] **Vérification Email/Téléphone**
  - Envoi de code de vérification
  - Page de saisie du code
  - Resend code

- [ ] **2FA (Two-Factor Authentication)**
  - TOTP (Google Authenticator)
  - SMS code
  - Backup codes

### Profil Utilisateur

- [ ] **Édition du Profil**
  - Modifier pseudo
  - Modifier téléphone
  - Ajouter/modifier email
  - Upload photo de profil

- [ ] **Paramètres**
  - Changer le mot de passe
  - Préférences de notifications
  - Langue
  - Thème

- [ ] **Supprimer le Compte**
  - Confirmation par mot de passe
  - Suppression définitive des données

### Sécurité

- [ ] **Validation du Mot de Passe Renforcée**
  - Minimum 8 caractères
  - Au moins une majuscule
  - Au moins un chiffre
  - Au moins un caractère spécial
  - Indicateur de force du mot de passe

- [ ] **Rate Limiting**
  - Limiter les tentatives de connexion
  - Captcha après X échecs

- [ ] **Session Management**
  - Timeout de session
  - Logout automatique
  - Multiple devices management

### UI/UX

- [ ] **Onboarding**
  - Intro slides au premier lancement
  - Tutorial interactif

- [ ] **Empty States**
  - Illustrations pour états vides
  - Messages encourageants

- [ ] **Error States**
  - Illustrations pour erreurs
  - Suggestions d'actions

- [ ] **Accessibility**
  - Support screen readers
  - Tailles de police ajustables
  - Contraste élevé

### Autres Features

- [ ] **Dashboard**
  - Statistiques utilisateur
  - Graphiques d'activité

- [ ] **Notifications**
  - Push notifications
  - In-app notifications
  - Préférences de notifications

- [ ] **Search**
  - Recherche globale
  - Filtres avancés

## 📊 Monitoring et Analytics

- [ ] **Firebase Analytics**
  - Tracking des événements
  - User properties
  - Conversion funnels

- [ ] **Crashlytics**
  - Rapports de crash
  - Error tracking

- [ ] **Performance Monitoring**
  - App startup time
  - Screen rendering times
  - Network requests latency

## 🏗️ Architecture

- [ ] **Use Cases / Interactors**
  - Ajouter une couche Use Cases entre ViewModel et Repository
  - Isoler la logique métier complexe

- [ ] **Cache Layer**
  - Implémenter un cache strategy
  - Offline-first approach

- [ ] **Event Bus**
  - Communication entre features
  - Events globaux

## 📱 CI/CD

- [ ] **GitHub Actions**
  - Build automatique
  - Tests automatiques
  - Linting

- [ ] **Fastlane**
  - Automatisation du déploiement
  - Beta distribution (TestFlight, Firebase App Distribution)

- [ ] **Code Coverage**
  - Objectif: > 80%
  - Rapports automatiques

## 📚 Documentation

- [ ] **API Documentation**
  - Documenter les endpoints (quand API réelle)
  - Postman collection

- [ ] **Code Documentation**
  - DartDoc pour toutes les classes publiques
  - Générer la documentation

- [ ] **Video Tutorials**
  - Screen recordings des features
  - Explications de l'architecture

## 🔍 Code Quality

- [ ] **Linting Rules**
  - Rules plus strictes
  - Custom lints

- [ ] **Code Review Checklist**
  - Guidelines de PR
  - Template de PR

- [ ] **Refactoring**
  - Identifier et éliminer le code dupliqué
  - Améliorer la lisibilité

## 🌐 Backend (si développé)

- [ ] **API REST**
  - Node.js / Express
  - Python / FastAPI
  - Go / Gin

- [ ] **Base de Données**
  - PostgreSQL / MySQL
  - MongoDB
  - Firebase Firestore

- [ ] **Authentication**
  - JWT tokens
  - Refresh tokens
  - Rate limiting

## 📦 Packages Utiles à Considérer

### State Management Avancé
- `riverpod_generator` : Code generation pour Riverpod
- `state_notifier` : Base classes pour state management

### Network
- `dio` : Client HTTP avancé
- `retrofit` : Type-safe REST client
- `connectivity_plus` : Vérifier la connexion

### Storage
- `shared_preferences` : Stockage simple
- `flutter_secure_storage` : Stockage sécurisé
- `hive` : Base de données NoSQL rapide

### UI/UX
- `shimmer` : Loading placeholders
- `lottie` : Animations JSON
- `flutter_svg` : Support SVG

### Utils
- `intl` : Internationalisation
- `logger` : Logging avancé
- `equatable` : Value equality

### Testing
- `mocktail` : Mocking
- `golden_toolkit` : Golden tests
- `integration_test` : Tests d'intégration

## 💡 Idées Créatives

- [ ] Gamification (badges, achievements)
- [ ] Mode hors-ligne complet
- [ ] Support tablette avec layout adaptatif
- [ ] Version web progressive (PWA)
- [ ] Support desktop (Windows, macOS, Linux)
- [ ] Widget pour écran d'accueil
- [ ] Shortcuts clavier (desktop)
- [ ] Drag & drop (desktop/tablette)

---

**Note** : Cette liste est volontairement ambitieuse. Choisissez les items selon vos besoins et votre niveau de compétence.

## 🎯 Roadmap Suggérée

### Phase 1 : Fondations Solides (semaine 1-2)
1. Tests unitaires pour core features
2. Backend réel avec API REST
3. Persistence locale des tokens

### Phase 2 : UX/UI (semaine 3-4)
1. Thème sombre
2. Animations
3. Onboarding

### Phase 3 : Features Avancées (semaine 5-6)
1. Mot de passe oublié
2. Édition de profil
3. Notifications push

### Phase 4 : Production Ready (semaine 7-8)
1. CI/CD
2. Monitoring
3. Documentation complète

---

**Contribuez !** Ce projet est pédagogique, n'hésitez pas à implémenter ces features et partager votre code.
