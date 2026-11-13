import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/features/auth/domain/auth_session.dart';
import 'package:campus_care/shared/models/app_user.dart';

/// Redirect stub. Swap [AuthSession] for Firebase Auth without changing routes.
abstract final class RoleGuard {
  static const Set<String> publicRoutes = {
    RouteNames.splash,
    RouteNames.onboarding,
    RouteNames.login,
    RouteNames.register,
    RouteNames.forgotPassword,
    RouteNames.verifyEmail,
  };

  static String? redirect({
    required AuthSession session,
    required String location,
  }) {
    if (location == '/' || location.isEmpty) {
      return _entryRoute(session);
    }

    switch (session.status) {
      case AuthStatus.unknown:
        return location == RouteNames.splash ? null : RouteNames.splash;
      case AuthStatus.unauthenticated:
        return publicRoutes.contains(location) ? null : RouteNames.login;
      case AuthStatus.authenticated:
        final role = session.user?.role;
        if (role == null) {
          return RouteNames.login;
        }
        if (_isAuthEntry(location)) {
          return homeFor(role);
        }
        if (role == UserRole.student && location.startsWith('/staff')) {
          return RouteNames.studentHome;
        }
        if (role == UserRole.staff && location.startsWith('/student')) {
          return RouteNames.staffDashboard;
        }
        return null;
    }
  }

  static String homeFor(UserRole role) {
    return switch (role) {
      UserRole.student => RouteNames.studentHome,
      UserRole.staff => RouteNames.staffDashboard,
    };
  }

  static String _entryRoute(AuthSession session) {
    final user = session.user;
    if (session.status == AuthStatus.authenticated && user != null) {
      return homeFor(user.role);
    }
    if (session.status == AuthStatus.unauthenticated) {
      return RouteNames.login;
    }
    return RouteNames.splash;
  }

  static bool _isAuthEntry(String location) {
    return location == RouteNames.splash ||
        location == RouteNames.onboarding ||
        location == RouteNames.login ||
        location == RouteNames.register ||
        location == RouteNames.forgotPassword;
  }
}
