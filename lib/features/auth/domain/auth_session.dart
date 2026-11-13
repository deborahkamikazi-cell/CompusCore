import 'package:equatable/equatable.dart';

import 'package:campus_care/shared/models/app_user.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthSession extends Equatable {
  const AuthSession({required this.status, this.user});

  const AuthSession.unknown() : this(status: AuthStatus.unknown);

  const AuthSession.unauthenticated()
    : this(status: AuthStatus.unauthenticated);

  const AuthSession.authenticated(AppUser user)
    : this(status: AuthStatus.authenticated, user: user);

  final AuthStatus status;
  final AppUser? user;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && user != null;

  @override
  List<Object?> get props => [status, user];
}
