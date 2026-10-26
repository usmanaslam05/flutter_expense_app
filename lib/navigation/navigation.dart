import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/authentication/login_screen.dart';
import 'package:flutter_application/presentation/home/home_screen.dart';
import 'package:flutter_application/presentation/registration/registration_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/login': (context) => const LoginScreen(),
    '/home': (context) => const HomeScreen(),
    '/registration': (context) => const RegistrationScreen(),
  };
}