import 'package:campus_care/core/router/role_guard.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/features/auth/data/mock_auth_repository.dart';
import 'package:campus_care/features/auth/domain/auth_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const unknown = AuthSession.unknown();
  const signedOut = AuthSession.unauthenticated();
  const student = AuthSession.authenticated(MockAuthRepository.student);
  const staff = AuthSession.authenticated(MockAuthRepository.staff);

  test('unknown sessions stay on splash', () {
    expect(
      RoleGuard.redirect(session: unknown, location: RouteNames.splash),
      isNull,
    );
    expect(
      RoleGuard.redirect(session: unknown, location: RouteNames.studentHome),
      RouteNames.splash,
    );
  });

  test('signed-out users can open auth routes but not shells', () {
    expect(
      RoleGuard.redirect(session: signedOut, location: RouteNames.login),
      isNull,
    );
    expect(
      RoleGuard.redirect(session: signedOut, location: RouteNames.studentHome),
      RouteNames.login,
    );
  });

  test('students are sent home and blocked from staff routes', () {
    expect(
      RoleGuard.redirect(session: student, location: RouteNames.login),
      RouteNames.studentHome,
    );
    expect(
      RoleGuard.redirect(
        session: student,
        location: RouteNames.staffDashboard,
      ),
      RouteNames.studentHome,
    );
    expect(
      RoleGuard.redirect(session: student, location: RouteNames.studentReports),
      isNull,
    );
  });

  test('staff are sent to the dashboard and blocked from student routes', () {
    expect(
      RoleGuard.redirect(session: staff, location: RouteNames.login),
      RouteNames.staffDashboard,
    );
    expect(
      RoleGuard.redirect(session: staff, location: RouteNames.studentHome),
      RouteNames.staffDashboard,
    );
    expect(
      RoleGuard.redirect(session: staff, location: RouteNames.staffIncidents),
      isNull,
    );
  });
}
