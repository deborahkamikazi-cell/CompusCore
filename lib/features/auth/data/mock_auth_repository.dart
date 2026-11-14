import 'dart:async';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/constants/validators.dart';
import 'package:campus_care/features/auth/data/auth_repository.dart';
import 'package:campus_care/features/auth/domain/auth_failure.dart';
import 'package:campus_care/shared/models/app_user.dart';

class MockAuthRepository implements AuthRepository {
  AppUser? _currentUser;
  final StreamController<AppUser?> _controller =
      StreamController<AppUser?>.broadcast();

  static const studentEmail = 'd.uwase@alustudent.com';
  static const staffEmail = 'jean.habimana@alueducation.com';
  static const mockPassword = 'password';
  static const deborahId = 'student-deborah';

  static const student = AppUser(
    uid: deborahId,
    fullName: 'Deborah Uwase',
    email: studentEmail,
    role: UserRole.student,
  );

  static const staff = AppUser(
    uid: 'staff-001',
    fullName: 'Jean Habimana',
    email: staffEmail,
    role: UserRole.staff,
  );

  void dispose() {
    _controller.close();
  }

  void _emit(AppUser? user) {
    _currentUser = user;
    if (!_controller.isClosed) {
      _controller.add(user);
    }
  }

  @override
  Stream<AppUser?> authStateChanges() async* {
    yield _currentUser;
    yield* _controller.stream;
  }

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final normalized = email.trim().toLowerCase();
    if (!Validators.isAluEmail(normalized) || password.trim().length < 6) {
      throw const AuthFailure(AppStrings.invalidCredentials);
    }
    final user = _userFor(normalized);
    _emit(user);
    return user;
  }

  AppUser _userFor(String email) {
    if (email == student.email) {
      return student;
    }
    if (email == staff.email) {
      return staff;
    }
    final role = email.endsWith(Validators.aluStaffDomain)
        ? UserRole.staff
        : UserRole.student;
    return AppUser(
      uid: '${role.name}-${email.hashCode.abs()}',
      fullName: _nameFromEmail(email),
      email: email,
      role: role,
    );
  }

  String _nameFromEmail(String email) {
    final local = email.split('@').first.replaceAll('.', ' ');
    return local
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map(
          (part) =>
              '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  @override
  Future<AppUser> registerWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final role = email.toLowerCase().endsWith(Validators.aluStaffDomain)
        ? UserRole.staff
        : UserRole.student;
    final user = AppUser(
      uid: 'user-${email.hashCode.abs()}',
      fullName: fullName,
      email: email.trim().toLowerCase(),
      role: role,
    );
    _emit(user);
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<void> signOut() async {
    _emit(null);
  }
}
