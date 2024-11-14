import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mail_client/providers/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
                    'M_Client!',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),

                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField('First Name', _firstNameController),
                  const SizedBox(height: 10),
                  _buildTextField('Last Name', _lastNameController),
                  const SizedBox(height: 10),
                  _buildTextField('Email', _emailController),
                  const SizedBox(height: 10),
                  _buildTextField('Password', _passwordController, isPassword: true),
                  const SizedBox(height: 20),
                  _buildSignUpButton(context),
                  const SizedBox(height: 20),
                  _buildSignInText(context),
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
          colors: [Colors.blue, Colors.teal], // New gradient colors
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

  Widget _buildSignUpButton(BuildContext context) {
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
          bool success = await context.read<AuthProvider>().signUp(
              _firstNameController.text,
              _lastNameController.text,
              _emailController.text,
              _passwordController.text);
          if (success) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            _showErrorDialog(context);
          }
        },
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignInText(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/login'); // Adjust the route name if necessary
      },
      child: const Text(
        'Already have an account? Sign In',
        style: TextStyle(color: Colors.teal, fontSize: 16),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Sign-up failed. Please try again.'),
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
