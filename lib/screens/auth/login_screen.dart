import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth_services.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';
import '../project/project_home_screen.dart';
import '../../utils/shared_pref_helper.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  void togglePasswordView() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    await ref.read(loginProvider.notifier).login(email, password);
    final state = ref.read(loginProvider);

    if (state is AsyncData) {
      // Login success
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      SharedPrefHelper.setBool("isLogin", true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProjectHomeScreen()),
      );
    } else if (state is AsyncError) {
      final errorMsg = state.error.toString();

      if (errorMsg.contains('user-not-found')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email not registered. Redirecting to Sign Up...')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SignUpScreen(email: email),
          ),
        );
      } else if (errorMsg.contains('wrong-password')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
      } else if (errorMsg.contains('invalid-email')) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email format')),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $errorMsg')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
          leading: const SizedBox(),
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text(
            "Login",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white, fontSize: 16),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: emailController,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Email",
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Password TextField with toggle visibility icon
            TextField(
              controller: passwordController,
              autofocus: false,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password",
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: togglePasswordView,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen()));
                  },
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.purple),
                  )),
            ),

            loginState.when(
              data: (_) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 6),
                onPressed: handleLogin,
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Column(
                children: [
                  Text(e.toString(), style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: handleLogin,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text.rich(TextSpan(
              children: [
                const TextSpan(text: "New User? "),
                TextSpan(
                  text: "Sign Up",
                  style: const TextStyle(color: Colors.purple),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen(email: "",)),
                      );
                    },
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
