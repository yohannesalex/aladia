import 'package:ef/features/authentication/domain/repositories/auth_repository.dart';
import 'package:ef/features/authentication/presentation/provider/auth_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ef/features/authentication/domain/usecases/login_usecase.dart';
import 'package:ef/core/error/failure.dart';

void main() {
  late AuthProvider authProvider;
  late FakeLoginUseCase fakeLoginUseCase;

  setUp(() {
    fakeLoginUseCase = FakeLoginUseCase();
    authProvider = AuthProvider(fakeLoginUseCase);
  });

  group('AuthProvider Login Tests', () {
    test('Should set emailError if email is empty', () async {
      await authProvider.login('', 'password');
      expect(authProvider.emailError, 'Email is required');
      expect(authProvider.isLoading, false);
    });

    test('Should set passwordError if password is empty', () async {
      await authProvider.login('test@test.com', '');
      expect(authProvider.passwordError, 'Password is required');
      expect(authProvider.isLoading, false);
    });

    test('Should show success message on successful login', () async {
      fakeLoginUseCase.setResponse(Right(null)); // Simulate success
      await authProvider.login('test@test.com', 'password');
      expect(authProvider.success, 'Login successful!');
      expect(authProvider.isLoading, false);
    });

    test(
        'Should show InvalidUserCredentialFailure error on invalid credentials',
        () async {
      fakeLoginUseCase.setResponse(Left(InvalidUserCredentialFailure()));
      await authProvider.login('wrong@test.com', 'wrongpassword');
      expect(authProvider.emailError, 'Invalid email or password.');
      expect(authProvider.isLoading, false);
    });

    test('Should show ConnectionFailure error on no internet connection',
        () async {
      fakeLoginUseCase.setResponse(Left(ConnectionFailure()));
      await authProvider.login('test@test.com', 'password');
      expect(authProvider.connectionError, 'There is No Internet connection.');
      expect(authProvider.isLoading, false);
    });

    test('Should show ServerFailure error on server error', () async {
      fakeLoginUseCase.setResponse(Left(ServerFailure()));
      await authProvider.login('test@test.com', 'password');
      expect(authProvider.serverError, 'An error occurred. Please try again.');
      expect(authProvider.isLoading, false);
    });
  });
}

class FakeLoginUseCase implements LoginUseCase {
  Either<Failure, void> _response = Right(null);

  void setResponse(Either<Failure, void> response) {
    _response = response;
  }

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return _response;
  }

  @override
  // TODO: implement authRepository
  AuthRepository get authRepository => throw UnimplementedError();
}
