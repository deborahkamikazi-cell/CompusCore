import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/features/auth/data/auth_repository.dart';
import 'package:campus_care/features/auth/data/mock_auth_repository.dart';
import 'package:campus_care/features/auth/domain/auth_session.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final repository = MockAuthRepository();
  ref.onDispose(repository.dispose);
  return repository;
});

/// Mock session used by the router until Firebase Auth is wired up.
class AuthController extends Notifier<AuthSession> {
  @override
  AuthSession build() => const AuthSession.unknown();

  void finishSplash() {
    if (state.status == AuthStatus.unknown) {
      state = const AuthSession.unauthenticated();
    }
  }

  Future<void> signInAsStudent() {
    return _signIn(MockAuthRepository.studentEmail);
  }

  Future<void> signInAsStaff() {
    return _signIn(MockAuthRepository.staffEmail);
  }

  Future<void> _signIn(String email) async {
    final user = await ref
        .read(authRepositoryProvider)
        .signInWithEmail(
          email: email,
          password: MockAuthRepository.mockPassword,
        );
    state = AuthSession.authenticated(user);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthSession.unauthenticated();
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthSession>(
  AuthController.new,
);
