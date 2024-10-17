import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newdoor/firebase/firebase_service.dart';
import 'package:newdoor/routes/app_route.dart';
import 'package:newdoor/utils/utils.dart';
import '../../../components/custom_suffix_icon.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError, _passwordError;
  bool _isLoading = false; // Manage loading state

  FirebaseService _service = FirebaseService();

  // Login function
  Future<void> login(String email, String password, BuildContext context) async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final credential = await _service.login(email, password);

      setState(() {
        _isLoading = false; // Stop loading
      });

      // If the user is authenticated successfully
      if (credential.user != null) {
        // Navigate to home screen
        Navigator.pushNamedAndRemoveUntil(
          context, AppRoute.homeScreen, (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false; // Stop loading

        // Check the error code and set appropriate error messages
        if (e.code == 'wrong-password') {
          _passwordError = 'Password is incorrect'; // Specific error for incorrect password
          _emailError = null; // Reset any existing email error
        } else if (e.code == 'user-not-found') {
          _emailError = 'No user found with that email'; // Error for non-existing user
          _passwordError = null; // Reset any existing password error
        } else {
          _emailError = 'Login failed: ${e.message}'; // General error message
          _passwordError = null; // Reset any existing password error
        }
      });
    } catch (e) {
      print(e); // Log unexpected errors
      setState(() {
        _isLoading = false; // Stop loading
        _emailError = 'User Not Found';
        _passwordError = 'Password Is Incorrect'; // Reset any existing password error
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildEmailFormField(),
          const SizedBox(height: 24),
          buildPasswordFormField(),
          const SizedBox(height: 24),
          buildForgotPasswordWidget(context),
          const SizedBox(height: 24),
          buildLoginButtonWidget(context),
          if (_isLoading) const CircularProgressIndicator(), // Show loading indicator
        ],
      ),
    );
  }

  // Build email form field
  Widget buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email address',
        labelText: 'Email',
        errorText: _emailError, // Display email error here
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Mail.svg'),
      ),
      onChanged: (value) {
        if (_emailError != null) {
          resetFocus(); // Reset error on change
        }
      },
    );
  }

  // Build password form field
  Widget buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Enter password',
        errorText: _passwordError, // Display password error here
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Lock.svg'),
      ),
      onChanged: (value) {
        if (_passwordError != null) {
          resetFocus(); // Reset error on change
        }
      },
    );
  }

  // Forgot Password Widget
  Widget buildForgotPasswordWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Navigate to forgot password screen or handle the logic here
        },
        child: const Text(
          "Forgot Password",
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  // Login Button Widget
  Widget buildLoginButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      onPressed: _isLoading
          ? null // Disable button while loading
          : () {
        // Get values from form fields
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();

        resetFocus();

        // Validate input
        if (!Utils.isValidEmail(email)) {
          setState(() {
            _emailError = 'Enter a valid email address';
          });
        } else if (!Utils.isValidPassword(password)) {
          setState(() {
            _passwordError = 'Enter a valid password';
          });
        } else {
          // If valid, perform login
          login(email, password, context);
        }
      },
      child: const Text(
        'Sign In',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  // Reset form focus and errors
  void resetFocus() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });
  }
}
