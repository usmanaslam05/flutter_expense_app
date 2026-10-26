import 'package:flutter/material.dart';
import 'package:flutter_application/domain/models/auth/auth_model.dart';
import 'package:flutter_application/presentation/authentication/login_controller.dart';
import 'package:flutter_application/presentation/registration/registration_controller.dart';
import 'package:flutter_application/presentation/registration/registration_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registration creates an account that can log in', () async {
    const username = 'registration_flow_test_user';
    const password = 'test_password';
    final registrationController = RegistrationController();
    final loginController = LoginController();
    final authModel = AuthModel(email: username, password: password);

    expect(
      await registrationController.register(authModel, 'different_password'),
      isFalse,
    );
    expect(await registrationController.register(authModel, password), isTrue);
    expect(await registrationController.register(authModel, password), isFalse);
    expect(await loginController.login(authModel), isTrue);
    expect(
      await loginController.login(
        AuthModel(email: username, password: 'incorrect_password'),
      ),
      isFalse,
    );
  });

  testWidgets('registration form submits and returns to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const RegistrationScreen(),
        routes: {
          '/login': (context) =>
              const Scaffold(body: Text('Login destination')),
        },
      ),
    );

    await tester.enterText(
      find.byType(TextField).at(0),
      'registration_screen_test_user',
    );
    await tester.enterText(find.byType(TextField).at(1), 'test_password');
    await tester.enterText(find.byType(TextField).at(2), 'test_password');
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Registration successful'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Login destination'), findsOneWidget);
  });
}
