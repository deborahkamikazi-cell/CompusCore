import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/widgets/placeholder_body.dart';

/// TODO: Confirm submission and show the generated reference number.
class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportSuccessTitle)),
      body: PlaceholderBody(
        title: AppStrings.reportSuccessTitle,
        subtitle: AppStrings.reportSuccessTodo,
        children: [
          TextButton(
            onPressed: () => context.go(RouteNames.studentReports),
            child: const Text(AppStrings.backToReports),
          ),
        ],
      ),
    );
  }
}
