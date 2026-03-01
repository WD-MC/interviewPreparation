import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes/app_colors.dart';
import '../../auth/view_models/auth_view_model.dart';

/// Vue d'accueil (après connexion)
///
/// Responsabilités:
/// - Afficher les informations de l'utilisateur connecté
/// - Permettre la déconnexion
/// - Page principale après authentification
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  /// Gérer la déconnexion
  void _handleLogout(WidgetRef ref) {
    final viewModel = ref.read(authViewModelProvider.notifier);
    viewModel.logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer l'état d'authentification
    final authState = ref.watch(authViewModelProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(ref),
            tooltip: 'Se déconnecter',
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Carte de profil
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Avatar
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              user.initial,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textWhite,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Pseudo
                          Text(
                            user.displayName,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 8),

                          // Numéro de téléphone
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                user.formattedPhoneNumber,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),

                          // Email si disponible
                          if (user.hasEmail) ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  user.email!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Informations du compte
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations du compte',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Divider(),
                          const SizedBox(height: 8),

                          // ID utilisateur
                          _buildInfoRow(
                            context,
                            icon: Icons.badge,
                            label: 'ID',
                            value: user.id,
                          ),
                          const SizedBox(height: 12),

                          // Date de création
                          _buildInfoRow(
                            context,
                            icon: Icons.calendar_today,
                            label: 'Membre depuis',
                            value: _formatDate(user.createdAt),
                          ),
                          const SizedBox(height: 12),

                          // Ancienneté
                          _buildInfoRow(
                            context,
                            icon: Icons.access_time,
                            label: 'Ancienneté',
                            value: '${user.accountAgeDays} jour${user.accountAgeDays > 1 ? 's' : ''}',
                          ),

                          // Badge nouveau compte
                          if (user.isNewAccount) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.success),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.new_releases,
                                    size: 16,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Nouveau membre',
                                    style: TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Message de bienvenue
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.celebration,
                          color: AppColors.textWhite,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bienvenue ${user.displayName} !',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Vous êtes connecté avec succès',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  /// Widget pour afficher une ligne d'information
  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Formater une date
  String _formatDate(DateTime date) {
    final months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
