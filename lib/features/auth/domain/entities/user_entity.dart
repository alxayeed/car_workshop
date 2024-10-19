import 'package:equatable/equatable.dart';
import '../../../../core/enums/user_role.dart';
import '../../data/models/user_model.dart';

class UserEntity extends Equatable {
  final String? id;
  final String email;
  final String name;
  final UserRole role;

  const UserEntity({
    this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      name: name,
      role: role,
    );
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [id, email, name, role];
}
