import 'package:equatable/equatable.dart';

enum UserRole {
  student('student', 'Student'),
  staff('staff', 'Staff');

  const UserRole(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static UserRole fromWire(String? value) {
    return UserRole.values.firstWhere(
      (role) => role.wireValue == value || role.name == value,
      orElse: () => UserRole.student,
    );
  }
}

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.role,
    this.photoUrl,
  });

  final String uid;
  final String fullName;
  final String email;
  final UserRole role;
  final String? photoUrl;

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: uid,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: UserRole.fromWire(map['role'] as String?),
      photoUrl: map['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'role': role.wireValue,
      'photoUrl': photoUrl,
    };
  }

  AppUser copyWith({
    String? uid,
    String? fullName,
    String? email,
    UserRole? role,
    String? photoUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  List<Object?> get props => [uid, fullName, email, role, photoUrl];
}
