/// User-facing copy. Screens should not hardcode strings.
abstract final class AppStrings {
  static const appName = 'CampusCare';

  static const splashTitle = 'Splash';
  static const onboardingTitle = 'Onboarding';
  static const loginTitle = 'Welcome back';
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

  static const tagline = 'Report and track campus issues in one place.';
  static const logIn = 'Log in';
  static const aluEmail = 'ALU email';
  static const password = 'Password';
  static const newHere = 'New here?';
  static const registerWithAluEmail = 'Register with your ALU email';
  static const verifiedEmailNote =
      'Only verified ALU emails can sign in.';
  static const showPassword = 'Show password';
  static const hidePassword = 'Hide password';
  static const invalidCredentials =
      'Check your ALU email and password, then try again.';
  static const greetingMorning = 'Good morning';
  static const greetingAfternoon = 'Good afternoon';
  static const greetingEvening = 'Good evening';
  static const homeHeadline = 'Campus issues, handled.';
  static const reportAnIssue = 'Report an Issue';
  static const yourReports = 'Your reports';
  static const recentReports = 'Recent reports';
  static const browseByCategory = 'Browse by category';
  static const seeAll = 'See all';
  static const submitted = 'Submitted';
  static const pending = 'Pending';
  static const inProgress = 'In progress';
  static const resolved = 'Resolved';
  static const all = 'All';
  static const allCategories = 'All categories';
  static const searchReports = 'Search reports';
  static const noMatchingReports = 'No reports match your search.';
  static const noReportsYet = 'You have not reported an issue yet.';
  static const couldNotLoadReports = 'Could not load reports.';
  static const notificationsUnread = 'Unread notifications';
  static const reportIncidentHeading = 'Report an incident';
  static const titleLabel = 'Title';
  static const categoryLabel = 'Category';
  static const descriptionLabel = 'Description';
  static const locationLabel = 'Location';
  static const buildingLabel = 'Building';
  static const floorLabel = 'Floor';
  static const roomLabel = 'Room';
  static const photosLabel = 'Photos';
  static const camera = 'Camera';
  static const gallery = 'Gallery';
  static const removePhoto = 'Remove photo';
  static const priorityLabel = 'Priority';
  static const submitReport = 'Submit report';
  static const titleRequired = 'Please add a title to continue.';
  static const categoryRequired = 'Please choose a category.';
  static const descriptionRequired = 'Please describe the issue.';
  static const locationRequired = 'Please add a location.';
  static const requiredMarker = '*';
  static const photoPickFailed = 'Could not add that photo.';
  static const reportSubmitted = 'Report submitted';
  static const reportSubmittedBody =
      'Facilities can now review this incident. You can track it from your reports.';
  static const referenceNumber = 'Reference number';
  static const viewMyReports = 'View my reports';
  static const incidentDetails = 'Incident details';
  static const description = 'Description';
  static const status = 'Status';
  static const reportedBy = 'Reported by';
  static const staffNote = 'Staff note';
  static const updateStatus = 'Update status';
  static const statusNoteHint = 'Optional note for the student';
  static const confirmStatusTitle = 'Update status?';
  static const statusUpdated = 'Status updated';
  static const noPhotos = 'No photos attached';
  static const incidentNotFound = 'This incident could not be found.';
  static const couldNotLoadIncident = 'Could not load this incident.';

  static String greetingNamed(String greeting, String name) =>
      '$greeting, $name';

  static String confirmStatusMessage(String status) =>
      'Change this incident to $status? The student timeline will update.';

  static String statusUpdatedMessage(String status) =>
      'Status updated to $status.';

  static String unreadCount(int count) =>
      count == 1 ? '1 unread notification' : '$count unread notifications';

  static String incidentIdLabel(String id) => 'Incident id: $id';
}
