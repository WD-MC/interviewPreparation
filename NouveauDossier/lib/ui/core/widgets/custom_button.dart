import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

/// Bouton personnalisé réutilisable
///
/// Widget réutilisable pour standardiser l'apparence des boutons
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // Déterminer si le bouton est désactivé
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      child: isOutlined
          ? _buildOutlinedButton(context, isDisabled)
          : _buildElevatedButton(context, isDisabled),
    );
  }

  /// Construire un bouton elevé (rempli)
  Widget _buildElevatedButton(BuildContext context, bool isDisabled) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: textColor ?? AppColors.textWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: isDisabled ? 0 : 2,
      ),
      child: _buildButtonChild(),
    );
  }

  /// Construire un bouton outlined (contour)
  Widget _buildOutlinedButton(BuildContext context, bool isDisabled) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: isDisabled ? AppColors.divider : (backgroundColor ?? AppColors.primary),
          width: 2,
        ),
      ),
      child: _buildButtonChild(),
    );
  }

  /// Construire le contenu du bouton (texte ou loader)
  Widget _buildButtonChild() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
        ),
      );
    }

    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
