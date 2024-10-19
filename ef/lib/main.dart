import 'package:ef/core/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/data/resource/auth_remote_datasource.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/presentation/pages/login.dart';
import 'features/authentication/presentation/provider/auth_provider.dart';
import 'features/authentication/presentation/provider/theme_provider.dart';

void main() {
  // Create an instance of http.Client
  final client = http.Client();

  // Create an instance of InternetConnectionChecker
  final internetConnectionChecker = InternetConnectionChecker();

  // Create an instance of NetworkInfo
  final networkInfo = NetworkInfoImpl(internetConnectionChecker);

  // Create an instance of AuthRemoteDatasource
  final authRemoteDatasource = AuthRemoteDatasourceImpl(client: client);

  // Create an instance of AuthRepository
  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource: authRemoteDatasource,
    networkInfo: networkInfo,
  );

  // Create an instance of LoginUseCase
  final loginUseCase = LoginUseCase(authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider(loginUseCase)),
        // Add other providers here if necessary
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      title: 'Aladia Exercise',
      home: const LoginPage(),
    );
  }
}
