import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/themes/app_colors.dart';
import '../widgets/phone_input_field.dart';
import '../view_models/auth_view_model.dart';
import '../../../../utils/validators.dart';

/// Vue d'inscription
///
/// Responsabilités (MVVM):
/// - Afficher l'UI d'inscription
/// - Capturer les entrées utilisateur (pseudo, téléphone, mot de passe)
/// - Déclencher les actions du ViewModel
/// - Réagir aux changements d'état du ViewModel
class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  // Controllers pour les champs de texte
  final _pseudoController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Clé pour le formulaire (validation)
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Nettoyer les controllers
    _pseudoController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Gérer la soumission du formulaire
  void _handleRegister() {
    // Valider le formulaire
    if (_formKey.currentState?.validate() ?? false) {
      // Récupérer le ViewModel depuis Riverpod
      final viewModel = ref.read(authViewModelProvider.notifier);

      // Appeler la méthode d'inscription du ViewModel
      viewModel.register(
        pseudo: _pseudoController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  /// Naviguer vers la page de connexion
  void _navigateToLogin() {
    context.pop();
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
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: LoadingOverlay(
        isLoading: authState.isLoading,
        message: 'Création du compte...',
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icône
                  const Icon(
                    Icons.person_add_outlined,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 24),

                  // Titre
                  Text(
                    'Créer un compte',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Sous-titre
                  Text(
                    'Remplissez les informations ci-dessous',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Champ pseudo
                  CustomTextField(
                    controller: _pseudoController,
                    label: 'Pseudo',
                    hint: 'Choisissez un pseudo',
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.person),
                    validator: Validators.validatePseudo,
                  ),
                  const SizedBox(height: 16),

                  // Champ numéro de téléphone
                  PhoneInputField(
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 16),

                  // Champ mot de passe
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Mot de passe',
                    hint: 'Minimum 6 caractères',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock),
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 16),

                  // Champ confirmation mot de passe
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirmer le mot de passe',
                    hint: 'Retapez votre mot de passe',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) =>
                        Validators.validateConfirmPassword(value, _passwordController.text),
                  ),
                  const SizedBox(height: 32),

                  // Bouton d'inscription
                  CustomButton(
                    text: 'S\'inscrire',
                    onPressed: authState.isLoading ? null : _handleRegister,
                    isLoading: authState.isLoading,
                  ),
                  const SizedBox(height: 16),

                  // Lien vers la connexion
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Déjà un compte ? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: authState.isLoading ? null : _navigateToLogin,
                        child: const Text('Se connecter'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
