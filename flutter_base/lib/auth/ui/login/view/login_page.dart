import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/home/home.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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

  bool _isPasswordVisible = false;

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
              style: textTheme.headlineMedium?.copyWith(
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
            const SizedBox(height: RFXSpacing.spacing32),
            Form(
              key: _emailFormKey,
              child: RFXTextFormField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                validator: _valilidateEmail,
                initialValue: "ngocduc@gmail.com",
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
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                initialValue: "1234",
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing12),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.end,
                style: textTheme.bodyMedium?.copyWith(
                  color: RFXColors.lightPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: RFXSpacing.spacing20),
            SizedBox(
              width: double.infinity,
              child: RFXPrimaryButton.large(
                title: 'Login',
                onPressed: _onLoginPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    if (_emailFormKey.currentState!.validate() &&
        _passwordFormKey.currentState!.validate()) {
      // if (_passwordController.text == "123123") {
      context.goNamed(HomePage.routeName);
      // }
    }
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
