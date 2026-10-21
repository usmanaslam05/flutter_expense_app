import 'package:flutter/material.dart';
import 'package:flutter_application/components/error_dialog.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/presentation/authentication/login_controller.dart';
import 'package:flutter_application/presentation/authentication/states/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final loginController = LoginController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginStates _loginState = LoginStates.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Screen',
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
            TextButton(
                onPressed: _loginState == LoginStates.loading ? null : () async {
                try{
                  setState(() {
                    // Update the login state to loading when the login button is pressed
                    _loginState = LoginStates.loading;
                  });
                  
                  final isLoggedIn = await loginController.login(
                    AuthModel(
                      email: _usernameController.text,
                      password: _passwordController.text,
                    ),
                  );
                  setState(() {
                    // Update the login state to idle after the login process is complete
                    _loginState = LoginStates.idle;
                  });

                  if(isLoggedIn){
                    // Navigate to the next screen or show a success message
                    print('Login successful');

                    // Navigate to the next screen
                    Navigator.pushReplacementNamed(context, '/home');


                  } else {
                    // Show an error message
                    print('Login failed');
                    await showErrorDialog(context, 'Invalid username or password');
                  }
                } catch(e){
                  setState(() {
                    // Update the login state to idle after the login process is complete
                    _loginState = LoginStates.idle;
                  });
                  print('Error: $e');
                  await showErrorDialog(context, e.toString());
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: _loginState == LoginStates.loading ? 
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ) : 
              Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}