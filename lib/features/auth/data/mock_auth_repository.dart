import 'dart:async';

import 'package:campus_care/core/constants/validators.dart';
import 'package:campus_care/features/auth/data/auth_repository.dart';
import 'package:campus_care/shared/models/app_user.dart';

class MockAuthRepository implements AuthRepository {
  AppUser? _currentUser;
  final StreamController<AppUser?> _controller =
      StreamController<AppUser?>.broadcast();

  static const studentEmail = 'amina.uwase@alustudent.com';
  static const staffEmail = 'jean.habimana@alueducation.com';
  static const mockPassword = 'password';

  static const student = AppUser(
    uid: 'student-001',
    fullName: 'Amina Uwase',
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
    final normalized = email.trim().toLowerCase();
    final AppUser user;
    if (normalized == student.email) {
      user = student;
    } else if (normalized == staff.email) {
      user = staff;
    } else {
      throw StateError('No mock account for $email');
    }
    _emit(user);
    return user;
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
