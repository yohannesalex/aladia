import 'package:dartz/dartz.dart';
import 'package:ef/core/error/exception.dart';
import 'package:ef/core/error/failure.dart';
import 'package:ef/features/authentication/data/model/login_response_model.dart';
import 'package:ef/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:ef/features/authentication/domain/entity/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasourceImpl mockAuthRemoteDataSource;
  late MockNetworkInfoImpl mockNetworkInfo;
  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDatasourceImpl();
    mockNetworkInfo = MockNetworkInfoImpl();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockAuthRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  const testLoginModel =
      LoginResponseModel(email: 'user@gmail.com', password: 'abcd1234');
  const testLoginEntity =
      LoginEntity(email: 'user@gmail.com', password: 'abcd1234');
  void deviceOnline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
  }

  void deviceOffline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  }

  group('login ', () {
    group('when the device is online', () {
      deviceOnline();
      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(const Right(null)));
      });

      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });
      test(
          'should return a Invalid credential failure when a call to the remote data source has invalid credential error',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenThrow(InvalidUserCredentialFailure());
        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(Left(InvalidUserCredentialFailure())));
      });
    });

    group('device is offline', () {
      // This setUp applies only to the 'device is online' group
      deviceOffline();

      test('should return connection failure when the device has no internet',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenThrow(SocketException());
        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
}
