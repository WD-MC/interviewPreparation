import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Champ de texte personnalisé réutilisable
///
/// Widget réutilisable pour standardiser l'apparence des champs de texte
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool enabled;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.enabled = true,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText && _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      onTap: widget.onTap,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _buildSuffixIcon(),
        counterText: '', // Masquer le compteur de caractères
      ),
    );
  }

  /// Construire l'icône de suffixe
  Widget? _buildSuffixIcon() {
    // Si c'est un champ de mot de passe, ajouter l'icône de visibilité
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return widget.suffixIcon;
  }
}
