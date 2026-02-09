import '../../domain/entities/user_entity.dart';
import '../../core/enums.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.role,
    super.name,
    super.phone,
    super.thanaId,
    super.unionId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email:
          json['email'] as String? ??
          '', // Email might come from auth user, not necessarily profile
      role: _parseRole(json['role'] as String?),
      name:
          json['name']
              as String?, // 'name' might not be in profile schema, maybe add it or ignore? Schema has no name, only phone/email. Let's assume email is primary for now.
      phone: json['phone'] as String?,
      thanaId: json['thana_id'] as String?,
      unionId: json['union_id'] as String?,
    );
  }

  static UserRole _parseRole(String? roleStr) {
    switch (roleStr?.toUpperCase()) {
      case 'ADMIN':
        return UserRole.admin;
      case 'MANAGER':
        return UserRole.manager;
      default:
        return UserRole.customer;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role.name.toUpperCase(),
      'phone': phone,
      'email': email,
      'thana_id': thanaId,
      'union_id': unionId,
    };
  }
}
