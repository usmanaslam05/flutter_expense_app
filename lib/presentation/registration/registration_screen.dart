import 'package:flutter/material.dart';
import 'package:flutter_application/components/error_dialog.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/presentation/common/states/async_states.dart';
import 'package:flutter_application/presentation/registration/registration_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final registrationController = RegistrationController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AsyncStates _registrationState = AsyncStates.idle;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registration Screen',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                controller: _confirmPasswordController,
              ),
            ),
            TextButton(
              onPressed: _registrationState == AsyncStates.loading
                  ? null
                  : () async {
                      setState(() {
                        _registrationState = AsyncStates.loading;
                      });

                      try {
                        final isRegistered = await registrationController
                            .register(
                              AuthModel(
                                email: _usernameController.text,
                                password: _passwordController.text,
                              ),
                              _confirmPasswordController.text,
                            );

                        if (!context.mounted) return;
                        setState(() {
                          _registrationState = AsyncStates.idle;
                        });

                        if (isRegistered) {
                          await showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Registration successful'),
                              content: const Text(
                                'Your account has been created.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          if (!context.mounted) return;
                          await showErrorDialog(
                            context,
                            'Check your username and passwords, or try a different username.',
                          );
                        }
                      } catch (error) {
                        if (!mounted) return;
                        setState(() {
                          _registrationState = AsyncStates.idle;
                        });
                        if (!context.mounted) return;
                        await showErrorDialog(context, error.toString());
                      }
                    },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: _registrationState == AsyncStates.loading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
