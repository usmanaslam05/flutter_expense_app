# Flutter Expense App

A Flutter learning project with a login flow and a placeholder home screen. Authentication currently uses local mock data; no backend or expense-tracking features are connected yet.

## Features

- Login screen with loading feedback while authentication is checked.
- Mock authentication with an error dialog for invalid credentials.
- Named routes for `/login` and `/home`. Successful login replaces the login route with the home screen.
- Authentication code organized into presentation, domain, and data layers.

### Demo credentials

Use the following credentials to complete the mock login:

- Username: `testuser`
- Password: `password123`

These credentials are for local demonstration only and must not be used for real accounts.

## Project structure

```text
lib/
  components/       Shared UI components, including the error dialog
  data/             Data models, mappers, repository implementation, and mock data
  domain/           Authentication model, repository contract, and use case
  navigation/       Named route configuration
  presentation/     Login and home screens, controller, and login states
  main.dart         Application entry point
```

## Run the app

Install the Flutter SDK, then from the project directory run:

```sh
flutter pub get
flutter run
```

## Validate the project

```sh
flutter analyze
flutter test
```
