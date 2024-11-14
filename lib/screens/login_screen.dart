import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mail_client/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreenAccent, // Background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('Email', _emailController),
                  const SizedBox(height: 10),
                  _buildTextField('Password', _passwordController, isPassword: true),
                  const SizedBox(height: 20),
                  _buildSignInButton(context),
                  const SizedBox(height: 20),
                  _buildSignUpText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.teal], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.teal],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make the button background transparent
          shadowColor: Colors.transparent, // Remove shadow
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          bool success = await context.read<AuthProvider>().signIn(
              _emailController.text, _passwordController.text);
          if (success) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _showErrorDialog(context);
          }
        },
        child: const Text(
          'Sign In',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/signup'); // Navigate to SignUpScreen
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Sign-in failed. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
