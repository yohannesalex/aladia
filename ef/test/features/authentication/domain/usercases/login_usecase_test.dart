import 'package:dartz/dartz.dart';
import 'package:ef/core/error/failure.dart';
import 'package:ef/features/authentication/domain/entity/login_entity.dart';
import 'package:ef/features/authentication/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LoginUseCase loginUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUsecase = LoginUseCase(mockAuthRepository);
  });

  const testUserdetail = LoginEntity(
    email: 'abc@gmail.com',
    password: 'abcd1234',
  );
  const testUserdetail1 = LoginEntity(
    email: 'abc@gmail.com',
    password: 'abcd1234',
  );
  test('should login the user in the repository', () async {
    // Arrange
    when(mockAuthRepository.login(testUserdetail))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await loginUsecase(const LoginParams(user: testUserdetail));

    // Assert
    expect(result, const Right(null));
    verify(mockAuthRepository.login(testUserdetail));
  });
  test('should return a failure when credentials are invalid', () async {
    // Arrange
    when(mockAuthRepository.login(any))
        .thenAnswer((_) async => Left(InvalidUserCredentialFailure()));

    // Act
    final result = await loginUsecase(const LoginParams(user: testUserdetail1));

    // Assert
    expect(result, equals(Left(InvalidUserCredentialFailure())));
    verify(mockAuthRepository.login(any)).called(1);
  });
  test('should return a failure when there is a server error', () async {
    // Arrange
    when(mockAuthRepository.login(any))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await loginUsecase(const LoginParams(user: testUserdetail1));

    // Assert
    expect(result, equals(Left(ServerFailure())));
    verify(mockAuthRepository.login(any)).called(1);
  });
  test('should return a failure when there is a connection error', () async {
    // Arrange
    when(mockAuthRepository.login(any))
        .thenAnswer((_) async => Left(ConnectionFailure()));

    // Act
    final result = await loginUsecase(const LoginParams(user: testUserdetail1));

    // Assert
    expect(result, equals(Left(ConnectionFailure())));
    verify(mockAuthRepository.login(any)).called(1);
  });
}
