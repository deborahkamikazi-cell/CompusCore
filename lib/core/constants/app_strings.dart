/// User-facing copy. Screens should not hardcode strings.
abstract final class AppStrings {
  static const appName = 'CampusCare';

  static const splashTitle = 'Splash';
  static const onboardingTitle = 'Onboarding';
  static const loginTitle = 'Login';
  static const registerTitle = 'Register';
  static const forgotPasswordTitle = 'Forgot password';
  static const verifyEmailTitle = 'Verify email';
  static const homeTitle = 'Home';
  static const reportsTitle = 'Reports';
  static const notificationsTitle = 'Notifications';
  static const profileTitle = 'Profile';
  static const reportIncidentTitle = 'Report incident';
  static const incidentDetailsTitle = 'Incident details';
  static const reportSuccessTitle = 'Report submitted';
  static const staffDashboardTitle = 'Dashboard';
  static const manageIncidentsTitle = 'Manage incidents';
  static const staffIncidentDetailsTitle = 'Staff incident details';
  static const pageNotFound = 'Page not found';

  static const home = 'Home';
  static const reports = 'Reports';
  static const notifications = 'Notifications';
  static const profile = 'Profile';
  static const dashboard = 'Dashboard';
  static const incidents = 'Incidents';

  static const continueLabel = 'Continue';
  static const signIn = 'Sign in';
  static const createAccount = 'Create account';
  static const forgotPassword = 'Forgot password';
  static const verifyEmail = 'Verify email';
  static const continueAsStudent = 'Continue as student';
  static const continueAsStaff = 'Continue as staff';
  static const signOut = 'Sign out';
  static const newReport = 'New report';
  static const viewSampleReport = 'View sample report';
  static const backToReports = 'Back to reports';
  static const backToIncidents = 'Back to incidents';
  static const backToLogin = 'Back to login';
  static const confirm = 'Confirm';
  static const cancel = 'Cancel';
  static const retry = 'Retry';
  static const placeholderSubtitle = 'Placeholder screen. Navigation only.';

  static const splashTodo =
      'TODO: Check persisted auth, then route to onboarding or the role shell.';
  static const onboardingTodo =
      'TODO: Introduce reporting, tracking, and staff follow-up.';
  static const loginTodo =
      'TODO: ALU email and password form. Mock buttons exercise the role guard.';
  static const registerTodo =
      'TODO: Registration form restricted to verified ALU emails.';
  static const forgotPasswordTodo = 'TODO: Send a password reset email.';
  static const verifyEmailTodo =
      'TODO: Ask the student to verify their ALU email before reporting.';
  static const homeTodo = 'TODO: Summary cards and shortcuts for the student.';
  static const reportsTodo =
      'TODO: Search, filter, and list the student incidents.';
  static const reportIncidentTodo =
      'TODO: Title, category, description, location, photos, and priority form.';
  static const incidentDetailsTodo =
      'TODO: Full report, photos, and status timeline.';
  static const reportSuccessTodo =
      'TODO: Confirmation with the generated reference number.';
  static const notificationsTodo =
      'TODO: Status updates for the signed-in user.';
  static const profileTodo = 'TODO: Account details and sign out.';
  static const staffDashboardTodo =
      'TODO: Queue counts by status and priority.';
  static const manageIncidentsTodo =
      'TODO: Review every incident, search, and filter.';
  static const staffIncidentDetailsTodo =
      'TODO: Update status and add an optional staff note.';

  static String signedInAs(String name, String role) =>
      'Signed in as $name ($role)';

  static String incidentIdLabel(String id) => 'Incident id: $id';
}
