import 'package:flutter/material.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthProvider(this.loginUseCase);

  bool _isLoading = false;
  String _emailError = '';
  String _passwordError = '';
  String _serverError = '';
  String _success = '';
  String _connectionError = '';

  // Getters for the state
  bool get isLoading => _isLoading;
  String get emailError => _emailError;
  String get passwordError => _passwordError;
  String get serverError => _serverError;
  String get success => _success;
  String get connectionError => _connectionError;

  // Setters
  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners(); // Notify UI when _isLoading changes
    }
  }

  set emailError(String error) {
    _emailError = error;
  }

  set passwordError(String error) {
    _passwordError = error;
  }

  set serverError(String error) {
    _serverError = error;
  }

  set success(String message) {
    _success = message;
  }

  set connectionError(String error) {
    _connectionError = error;
  }

  void setEmailError(String error) {
    _emailError = error;
    notifyListeners();
  }

  void setPasswordError(String error) {
    _passwordError = error;
    notifyListeners();
  }

  void setServerError(String error) {
    _serverError = error;
    notifyListeners();
  }

  void setSuccess(String message) {
    _success = message;
    notifyListeners();
  }

  // Login method
  Future<void> login(String email, String password) async {
    // Reset errors before login attempt
    emailError = '';
    passwordError = '';
    serverError = '';
    success = '';
    connectionError = '';

    // Validate email and password before making the async call
    if (email.isEmpty) {
      emailError = 'Email is required';
      notifyListeners();
      return;
    }

    if (password.isEmpty) {
      passwordError = 'Password is required';
      notifyListeners();
      return;
    }

    // If email and password are not empty, proceed with the login
    isLoading = true; // Use the setter to update the loading state

    // Create a LoginEntity instance
    final loginEntity = LoginEntity(email: email, password: password);
    final result = await loginUseCase(LoginParams(user: loginEntity));

    result.fold(
      (failure) {
        isLoading = false; // Stop loading
        // Handle different types of failures
        if (failure is InvalidUserCredentialFailure) {
          emailError = 'Invalid email or password.';
        } else if (failure is ConnectionFailure) {
          connectionError = 'There is No Internet connection.';
        } else {
          serverError = 'An error occurred. Please try again.';
        }
        notifyListeners(); // Notify UI of the changes
      },
      (_) {
        isLoading = false; // Stop loading
        success = 'Login successful!';
        notifyListeners(); // Notify UI of the success
      },
    );
  }
}
