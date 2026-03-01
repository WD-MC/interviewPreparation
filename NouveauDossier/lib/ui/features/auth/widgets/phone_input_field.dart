import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../../utils/validators.dart';

/// Champ de saisie spécialisé pour les numéros de téléphone
///
/// Widget personnalisé qui étend CustomTextField avec des règles spécifiques
/// pour la saisie de numéros de téléphone
class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? customValidator;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.customValidator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: 'Numéro de téléphone',
      hint: '06 12 34 56 78',
      keyboardType: TextInputType.phone,
      prefixIcon: const Icon(Icons.phone),
      // Limitation à 10 chiffres pour un numéro français
      maxLength: 10,
      // Formatters pour n'accepter que des chiffres
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      // Validation du numéro de téléphone
      validator: customValidator ?? Validators.validatePhone,
    );
  }
}
