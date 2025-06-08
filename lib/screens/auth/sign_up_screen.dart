import 'package:assignment_application/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final String email;

  const SignUpScreen({super.key, required this.email});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  InputDecoration _inputDecoration(BuildContext context, String label) {
    return InputDecoration(
      labelText: label,
      hintText: label,
      hintStyle:
          Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }

  void getEmail() {
    if (widget.email != "") {
      _emailController.text = widget.email;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      signUpUser(_nameController.text, _emailController.text,
          _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: Colors.purple,
            title: Text(
              "Sign Up",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontSize: 16),
            )),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  // Name field
                  TextFormField(
                    autofocus: false,
                    controller: _nameController,
                    decoration: _inputDecoration(context, "Name"),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Email field with format validation
                  TextFormField(
                    autofocus: false,
                    controller: _emailController,
                    decoration: _inputDecoration(context, "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      // Simple regex email validation
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password field with length validation
                  TextFormField(
                    autofocus: false,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: _inputDecoration(context, "Password").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm password field with matching validation
                  TextFormField(
                    autofocus: false,
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration:
                        _inputDecoration(context, "Confirm Password").copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscureConfirmPassword =
                              !_obscureConfirmPassword);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password is required';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5),
                    onPressed: _submit,
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
