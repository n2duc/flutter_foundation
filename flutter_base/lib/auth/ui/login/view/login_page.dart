import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(RFXSpacing.spacing20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'River Flow Solutions',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: RFXColors.lightPrimary,
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing20),
            Text('Welcome Travelling', style: textTheme.titleLarge),
            const SizedBox(height: RFXSpacing.spacing12),
            Text(
              'Style clip effect union underline. Editor auto bullet select fill select create draft. Pen list effect.',
            ),
            Form(
              key: _emailFormKey,
              child: RFXTextFormField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                validator: _valilidateEmail,
                initialValue: 'ngocduc@gmail.com',
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            Form(
              key: _passwordFormKey,
              child: RFXTextFormField(
                controller: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                validator: _validatePassword,
                initialValue: '1234',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _valilidateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }
}
