import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/utils/helpers.dart';
import '../../core/utils/validators.dart';
import '../../routes/app_routes.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailPhoneCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  bool _codeSent = false;

  @override
  void dispose() {
    _emailPhoneCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    try {
      await auth.sendCode(_emailPhoneCtrl.text.trim());
      if (!mounted) return;
      setState(() {
        _codeSent = true;
      });
      Helpers.showSnackBar(context, 'Verification code sent (mock).');
    } catch (e) {
      if (!mounted) return;
      Helpers.showSnackBar(context, e.toString());
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    try {
      await auth.loginWithCode(
        emailOrPhone: _emailPhoneCtrl.text.trim(),
        code: _codeCtrl.text.trim(),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      Helpers.showSnackBar(context, 'Invalid code');
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isLoading = auth.status == AuthStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  AppStrings.login,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _emailPhoneCtrl,
                  label: AppStrings.emailOrPhone,
                  validator: Validators.emailOrPhone,
                ),
                const SizedBox(height: 16),
                if (_codeSent)
                  CustomTextField(
                    controller: _codeCtrl,
                    label: AppStrings.verificationCode,
                    keyboardType: TextInputType.number,
                    validator: Validators.verificationCode,
                  ),
                const SizedBox(height: 24),
                if (!_codeSent)
                  CustomButton(
                    label: isLoading ? 'Sending...' : AppStrings.sendCode,
                    onPressed: isLoading ? () {} : _sendCode,
                  )
                else
                  CustomButton(
                    label: isLoading ? 'Verifying...' : AppStrings.verify,
                    onPressed: isLoading ? () {} : _login,
                  ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.register,
                    );
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


