/// Canonical route paths. Keep these in sync with [app_router.dart].
abstract final class RouteNames {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const verifyEmail = '/verify-email';

  static const studentHome = '/student/home';
  static const studentReports = '/student/reports';
  static const studentNotifications = '/student/notifications';
  static const studentProfile = '/student/profile';
  static const studentReportNew = '/student/report/new';
  static const studentReportSuccess = '/student/report/success';

  static const staffDashboard = '/staff/dashboard';
  static const staffIncidents = '/staff/incidents';
  static const staffNotifications = '/staff/notifications';
  static const staffProfile = '/staff/profile';

  static String studentReportDetails(String id) => '$studentReports/$id';

  static String staffIncidentDetails(String id) => '$staffIncidents/$id';
}
