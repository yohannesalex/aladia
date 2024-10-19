import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constant.dart';
import '../../../../core/error/failure.dart';
import '../model/login_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(LoginResponseModel user);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final http.Client client;
  AuthRemoteDatasourceImpl({required this.client});

  @override
  Future<void> login(LoginResponseModel user) async {
    final jsonBody = {
      'email': user.email,
      'password': user.password,
    };

    final response = await client.post(
      Uri.parse(Uris.apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonBody),
    );
    print(response.statusCode);
    // Check the response status codes
    if (response.statusCode == 200) {
      return; // success
    } else if (response.statusCode == 404 || response.statusCode == 401) {
      // Throw specific failure for 404 status
      throw const InvalidUserCredentialFailure();
    } else {
      // For all other errors, throw a general server failure
      throw const ServerFailure();
    }
  }
}
