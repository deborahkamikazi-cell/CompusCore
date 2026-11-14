import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/constants/validators.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/app_text_field.dart';
import 'package:campus_care/core/widgets/info_banner.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/auth/domain/auth_failure.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const emailFieldKey = Key('login-email-field');
  static const passwordFieldKey = Key('login-password-field');

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscurePassword = true;
  var _isLoading = false;
  String? _formError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _formError = null);
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );
    } on AuthFailure catch (error) {
      if (mounted) {
        setState(() => _formError = error.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _formError = AppStrings.invalidCredentials);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          _LoginHero(onSecondary: theme.colorScheme.onSecondary),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.loginTitle,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      AppStrings.tagline,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      fieldKey: LoginScreen.emailFieldKey,
                      label: AppStrings.aluEmail,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: Validators.aluEmail,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      fieldKey: LoginScreen.passwordFieldKey,
                      label: AppStrings.password,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      validator: (value) => Validators.minLength(
                        value,
                        6,
                        fieldName: AppStrings.password,
                      ),
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? AppStrings.showPassword
                            : AppStrings.hidePassword,
                        onPressed: () {
                          setState(
                            () => _obscurePassword = !_obscurePassword,
                          );
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () =>
                            context.push(RouteNames.forgotPassword),
                        child: const Text(AppStrings.forgotPassword),
                      ),
                    ),
                    if (_formError != null) ...[
                      Text(
                        _formError!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    PrimaryButton(
                      label: AppStrings.logIn,
                      isLoading: _isLoading,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          AppStrings.newHere,
                          style: theme.textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: () => context.push(RouteNames.register),
                          child: const Text(AppStrings.registerWithAluEmail),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const InfoBanner(message: AppStrings.verifiedEmailNote),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginHero extends StatelessWidget {
  const _LoginHero({required this.onSecondary});

  final Color onSecondary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.colorScheme.secondary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Container(
                width: AppSpacing.logoMark,
                height: AppSpacing.logoMark,
                decoration: BoxDecoration(
                  color: onSecondary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.health_and_safety_outlined,
                  color: onSecondary,
                  size: AppSpacing.xl + AppSpacing.xs,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                AppStrings.appName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: onSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                AppStrings.tagline,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: onSecondary.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
