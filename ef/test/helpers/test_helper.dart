import 'package:ef/core/network/network_info.dart';
import 'package:ef/features/authentication/data/resource/auth_remote_datasource.dart';
import 'package:ef/features/authentication/domain/repositories/auth_repository.dart';
import 'package:ef/features/authentication/domain/usecases/login_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    AuthRemoteDatasourceImpl,
    NetworkInfoImpl,
    InternetConnectionChecker,
    AuthRepository,
    LoginUseCase,
    http.Client
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
