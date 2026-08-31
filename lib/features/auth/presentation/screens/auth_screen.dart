import 'package:flutter/material.dart';
import 'package:x_o/core/utils/validators.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_gradient_button.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../../core/widgets/grid_background.dart';

enum _AuthMode { login, register }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  _AuthMode _mode = _AuthMode.login;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  bool get _isRegister => _mode == _AuthMode.register;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _switchMode(_AuthMode target) {
    if (_mode == target) return;
    setState(() => _mode = target);
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    // setState(() => _isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return GridBackground(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: GlassPanel(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: Text(
                          _isRegister ? 'REGISTRATION' : 'AUTHENTICATION',
                          key: ValueKey(_isRegister),
                          style: AppTypography.h1.copyWith(
                            color: AppColors.primaryText,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: _isRegister
                            ? Column(
                                key: const ValueKey('name-field'),
                                children: [
                                  CustomTextField(
                                    label: 'Callsign',
                                    hintText: 'Enter Name',
                                    icon: Icons.badge_outlined,
                                    controller: _nameController,
                                    textInputAction: TextInputAction.next,
                                    validator: (v) => !_isRegister
                                        ? null
                                        : (Validators.required(v) ??
                                              Validators.minLength(v, 3)),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('no-name-field'),
                              ),
                      ),

                      CustomTextField(
                        label: 'Commander Email',
                        hintText: 'Enter Identifier',
                        icon: Icons.person_outline,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (v) => Validators.email(v),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Security Access Key',
                        hintText: 'Enter Password',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: _isRegister
                            ? TextInputAction.next
                            : TextInputAction.done,
                        validator: (v) => Validators.password(v),
                      ),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: _isRegister
                            ? Column(
                                key: const ValueKey('confirm-field'),
                                children: [
                                  const SizedBox(height: 24),
                                  CustomTextField(
                                    label: 'Confirm Access Key',
                                    hintText: 'Re-enter Password',
                                    icon: Icons.lock_outline,
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    validator: (v) => !_isRegister
                                        ? null
                                        : Validators.confirmPassword(
                                            v,
                                            _passwordController.text,
                                          ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('no-confirm-field'),
                              ),
                      ),

                      const SizedBox(height: 32),
                      CustomGradientButton(
                        label: _isRegister
                            ? 'Register Callsign'
                            : 'Initialize Link',
                        isLoading: _isLoading,
                        onPressed: _onSubmit,
                      ),
                      const SizedBox(height: 20),

                      // Only present in login mode.
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: !_isRegister
                            ? Column(
                                key: const ValueKey('forgot-password'),
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'EMERGENCY SIGNAL (FORGOT PASSWORD?)',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.lowContrastText,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('no-forgot-password'),
                              ),
                      ),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                        child: Row(
                          key: ValueKey(_isRegister),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isRegister
                                  ? 'ALREADY ENLISTED? '
                                  : 'NEW PILOT? ',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.lowContrastText,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _switchMode(
                                _isRegister
                                    ? _AuthMode.login
                                    : _AuthMode.register,
                              ),
                              child: Text(
                                _isRegister
                                    ? 'INITIALIZE LINK'
                                    : 'REGISTER CALLSIGN',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.coreCyan,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
