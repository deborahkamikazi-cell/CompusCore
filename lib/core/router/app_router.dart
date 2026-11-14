import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/role_guard.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/error_view.dart';
import 'package:campus_care/features/auth/domain/auth_session.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';
import 'package:campus_care/features/auth/presentation/forgot_password_screen.dart';
import 'package:campus_care/features/auth/presentation/login_screen.dart';
import 'package:campus_care/features/auth/presentation/onboarding_screen.dart';
import 'package:campus_care/features/auth/presentation/register_screen.dart';
import 'package:campus_care/features/auth/presentation/splash_screen.dart';
import 'package:campus_care/features/auth/presentation/verify_email_screen.dart';
import 'package:campus_care/features/incidents/presentation/incident_details_screen.dart';
import 'package:campus_care/features/incidents/presentation/report_incident_screen.dart';
import 'package:campus_care/features/incidents/presentation/report_success_screen.dart';
import 'package:campus_care/features/incidents/presentation/reports_list_screen.dart';
import 'package:campus_care/features/notifications/presentation/notifications_screen.dart';
import 'package:campus_care/features/profile/presentation/profile_screen.dart';
import 'package:campus_care/features/staff/presentation/manage_incidents_screen.dart';
import 'package:campus_care/features/staff/presentation/staff_dashboard_screen.dart';
import 'package:campus_care/features/staff/presentation/staff_incident_details_screen.dart';
import 'package:campus_care/features/student_home/presentation/home_screen.dart';
import 'package:campus_care/shared/navigation/staff_shell.dart';
import 'package:campus_care/shared/navigation/student_shell.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class RouterRefreshListenable extends ChangeNotifier {
  void notifyAuthChanged() => notifyListeners();
}

final routerRefreshListenableProvider = Provider<RouterRefreshListenable>((
  ref,
) {
  final listenable = RouterRefreshListenable();
  ref.onDispose(listenable.dispose);
  ref.listen<AuthSession>(authControllerProvider, (previous, next) {
    listenable.notifyAuthChanged();
  });
  return listenable;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ref.watch(routerRefreshListenableProvider);
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final session = ref.read(authControllerProvider);
      return RoleGuard.redirect(
        session: session,
        location: state.matchedLocation,
      );
    },
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.pageNotFound)),
        body: ErrorView(
          message: state.error?.toString() ?? AppStrings.pageNotFound,
        ),
      );
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => RouteNames.splash,
      ),
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.verifyEmail,
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return StudentShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.studentHome,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.studentReports,
                builder: (context, state) => ReportsListScreen(
                  initialCategory: state.uri.queryParameters['category'],
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => IncidentDetailsScreen(
                      incidentId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.studentNotifications,
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.studentProfile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.studentReportNew,
        builder: (context, state) => const ReportIncidentScreen(),
      ),
      GoRoute(
        path: RouteNames.studentReportSuccess,
        builder: (context, state) => const ReportSuccessScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return StaffShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.staffDashboard,
                builder: (context, state) => const StaffDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.staffIncidents,
                builder: (context, state) => const ManageIncidentsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => StaffIncidentDetailsScreen(
                      incidentId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.staffNotifications,
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.staffProfile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
