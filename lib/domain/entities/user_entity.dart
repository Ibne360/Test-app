import '../../core/enums.dart';

class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.role,
    this.name,
    this.phone,
    this.thanaId, // For managers
    this.unionId, // For customers/managers
  });

  final String id;
  final String email;
  final UserRole role;
  final String? name;
  final String? phone;
  final String? thanaId;
  final String? unionId;
}
