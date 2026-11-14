# CampusCare

## Description

CampusCare is a campus incident reporting app for Android and iOS. Students with a verified ALU email report issues such as water, electricity, Wi-Fi, furniture, sanitation, and safety, then search, filter, and track those reports. Authorized staff review every incident and update its status, with an optional note the student can see.

A report includes a title, category, description, location, photos, and a priority of Low, Medium, High, or Critical. Status moves in one direction: Submitted, Under Review, In Progress, then Resolved. Students and staff have separate navigation. Staff screens are only reachable by staff accounts.

The app is built with Flutter, Riverpod, and go_router. Firebase Authentication, Cloud Firestore, and Firebase Storage are the planned backend. They are not configured yet, so the running app uses in-memory sample data. Login, the student home, the report form, the reports list, incident details, and the staff status update screen are implemented. Splash, onboarding, registration, password reset, email verification, notifications, profile, and the staff dashboard are still placeholders.

## Run

```bash
flutter pub get
flutter run
```

Android and iOS only. From the splash screen, continue to onboarding and then login. Use `d.uwase@alustudent.com` / `password` for the student screens, or `jean.habimana@alueducation.com` / `password` for staff. Any other verified ALU email with a password of at least 6 characters also signs in against the mock repository.

## Project structure

```text
lib/
  main.dart                 App entry. Firebase init is guarded.
  app.dart                  Theme and go_router host, under ProviderScope.
  core/                     App-wide code that features share.
    theme/                  Colors, type, spacing, Material 3 ThemeData.
    router/                 Route paths, role redirect, GoRouter config.
    constants/              Strings, validators, Firestore and Storage paths.
    utils/                  Date formatting and snackbars.
    widgets/                Reusable UI. Placeholders until feature screens need them.
  features/                 One folder per product area.
    auth/                   Splash, onboarding, login, register, password, verify.
    student_home/           Student home tab.
    incidents/              Report, list, details, success, models, repository.
    notifications/          Notification model and screen.
    profile/                Shared profile screen.
    staff/                  Staff dashboard, queue, and incident review.
  shared/
    models/                 AppUser and UserRole.
    navigation/             Student and staff bottom-navigation shells.
```

Each feature is split into `presentation`, `domain`, and `data` when that feature owns state or persistence. Presentation widgets never call Firebase. Domain types stay free of Flutter and Firebase. Data types map those models to Firestore and implement repository interfaces.

### Naming

- Files and folders: `snake_case`.
- Types: `PascalCase`. Widgets end in `Screen`, `Shell`, `Card`, `Badge`, or `Button`.
- Providers: `camelCase` and end in `Provider` (`authControllerProvider`).
- Routes: constants on `RouteNames`. Do not hardcode path strings in screens.
- Visible copy: `AppStrings`. Colors and text styles: `Theme.of(context)`, backed by `AppColors` and `AppTextStyles`. Do not put hex colors or raw `TextStyle`s in screens.
- Material widgets and `google_fonts` share `package:material_ui/material_ui.dart` on this Flutter version. Import that package instead of `package:flutter/material.dart`.

### Where new code goes

- Shared widget used by more than one feature: `lib/core/widgets`. Incident chips may import domain enums, not Firebase.
- Widget used by one feature: `lib/features/<feature>/presentation/widgets`.
- New screen: a `snake_case` file under that feature's `presentation` folder, then a route in `lib/core/router/app_router.dart`.
- New persisted type: entity in `domain`, `fromMap` / `toMap` in `data`, path helper in `lib/core/constants/firestore_paths.dart`.

### Roles

`UserRole` is `student` or `staff`, stored on `users/{uid}`.

- Unauthenticated users can open splash, onboarding, login, register, forgot-password, and verify-email.
- Students land in the student shell (`/student/...`) and are redirected away from `/staff/...`.
- Staff land in the staff shell (`/staff/...`) and are redirected away from `/student/...`.
- The check lives in `RoleGuard` and is driven by `authControllerProvider`. That provider is a mock until Firebase Auth replaces `MockAuthRepository`.

Shell tabs use `StatefulShellRoute` so each tab keeps its own navigation stack.

### Data, for now

`AuthRepository` and `IncidentRepository` are abstract. `MockAuthRepository` and `MockIncidentRepository` return sample users and incidents. Do not add Firebase calls in presentation code. Wire repositories in a later phase.

Firestore paths: `users/{uid}`, `incidents/{incidentId}`, `notifications/{id}`. Storage path: `incident_images/{incidentId}/{fileName}`.

### Firebase

`main.dart` calls `Firebase.initializeApp()` and continues if native config is missing. Do not apply the Google Services Gradle plugin until `google-services.json` and `GoogleService-Info.plist` are added, or Android/iOS builds will fail.

Assets belong in `assets/images` and `assets/icons`.
