import 'dart:convert';
import 'package:ef/core/constants/constant.dart';
import 'package:ef/core/error/failure.dart';
import 'package:ef/features/authentication/data/model/login_response_model.dart';
import 'package:ef/features/authentication/data/resource/auth_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AuthRemoteDatasourceImpl datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = AuthRemoteDatasourceImpl(client: mockHttpClient);
  });

  const tLoginResponseModel =
      LoginResponseModel(email: 'test@example.com', password: 'password123');

  group('login', () {
    test('should perform a POST request on a URL with application/json header',
        () async {
      // Arrange
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('{"token": "abcd1234"}', 200));

      // Act
      await datasource.login(tLoginResponseModel);

      // Assert
      verify(mockHttpClient.post(
        Uri.parse(Uris.apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': tLoginResponseModel.email,
          'password': tLoginResponseModel.password,
        }),
      ));
    });

    test('should return void when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Success', 200));

      // Act & Assert
      await datasource.login(tLoginResponseModel);
    });

    test(
        'should throw InvalidUserCredentialFailure when the response code is 404',
        () async {
      // Arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final call = datasource.login;

      // Assert
      expect(() => call(tLoginResponseModel),
          throwsA(isA<InvalidUserCredentialFailure>()));
    });

    test(
        'should throw ServerFailure when the response code is other than 200 or 404',
        () async {
      // Arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      // Act
      final call = datasource.login;

      // Assert
      expect(() => call(tLoginResponseModel), throwsA(isA<ServerFailure>()));
    });

    test('should throw ServerFailure when there is a failure', () async {
      // Arrange
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenThrow(ServerFailure());

      // Act
      final call = datasource.login;

      // Assert
      expect(() => call(tLoginResponseModel), throwsA(isA<ServerFailure>()));
    });
  });
}
