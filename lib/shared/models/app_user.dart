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

  String get firstName {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    return trimmed.split(RegExp(r'\s+')).first;
  }

  /// "Deborah Uwase" -> "Deborah U."
  String get reporterShortName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length < 2 || parts.last.isEmpty) {
      return fullName;
    }
    return '${parts.first} ${parts.last[0].toUpperCase()}.';
  }

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
