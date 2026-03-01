import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/themes/app_colors.dart';
import '../widgets/phone_input_field.dart';
import '../view_models/auth_view_model.dart';
import '../../../../routing/route_names.dart';
import '../../../../utils/validators.dart';

/// Vue de connexion
///
/// Responsabilités (MVVM):
/// - Afficher l'UI de connexion
/// - Capturer les entrées utilisateur
/// - Déclencher les actions du ViewModel
/// - Réagir aux changements d'état du ViewModel
///
/// Utilise ConsumerStatefulWidget pour accéder à Riverpod et gérer l'état local
class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  // Controllers pour les champs de texte
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // Clé pour le formulaire (validation)
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Nettoyer les controllers
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Gérer la soumission du formulaire
  void _handleLogin() {
    // Valider le formulaire
    if (_formKey.currentState?.validate() ?? false) {
      // Récupérer le ViewModel depuis Riverpod
      final viewModel = ref.read(authViewModelProvider.notifier);

      // Appeler la méthode de connexion du ViewModel
      viewModel.login(
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  /// Naviguer vers la page d'inscription
  void _navigateToRegister() {
    context.push(RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    // Écouter l'état d'authentification depuis le ViewModel
    final authState = ref.watch(authViewModelProvider);

    // Afficher les messages d'erreur si nécessaire
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      body: LoadingOverlay(
        isLoading: authState.isLoading,
        message: 'Connexion en cours...',
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo ou icône de l'app
                    const Icon(
                      Icons.lock_outline,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 24),

                    // Titre
                    Text(
                      'Connexion',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Sous-titre
                    Text(
                      'Connectez-vous pour continuer',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),

                    // Champ numéro de téléphone
                    PhoneInputField(
                      controller: _phoneController,
                    ),
                    const SizedBox(height: 16),

                    // Champ mot de passe
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Mot de passe',
                      hint: 'Entrez votre mot de passe',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 32),

                    // Bouton de connexion
                    CustomButton(
                      text: 'Se connecter',
                      onPressed: authState.isLoading ? null : _handleLogin,
                      isLoading: authState.isLoading,
                    ),
                    const SizedBox(height: 16),

                    // Lien vers l'inscription
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pas encore de compte ? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: authState.isLoading ? null : _navigateToRegister,
                          child: const Text('S\'inscrire'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
