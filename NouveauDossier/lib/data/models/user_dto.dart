import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// Data Transfer Object pour l'entité User
///
/// Représentation technique de l'utilisateur côté données
/// Utilisé pour la sérialisation JSON et communication avec l'API
@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String pseudo,
    required String phoneNumber,
    String? email,
    DateTime? createdAt,
  }) = _UserDto;

  /// Convertir depuis JSON
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  /// Convertir vers le modèle domain
  ///
  /// Transformation du DTO (couche data) vers l'entité métier (couche domain)
  User toDomain() {
    return User(
      id: id,
      pseudo: pseudo,
      phoneNumber: phoneNumber,
      email: email,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  /// Créer un DTO depuis un modèle domain
  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id,
      pseudo: user.pseudo,
      phoneNumber: user.phoneNumber,
      email: user.email,
      createdAt: user.createdAt,
    );
  }
}
