import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../model/login_response_model.dart';
import '../resource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, void>> login(LoginEntity user) async {
    if (await networkInfo.isConnected) {
      print('----------------auth_inplementATION IS CALLED');
      try {
        await authRemoteDataSource.login(LoginResponseModel.toModel(user));

        return const Right(null);
      } catch (error) {
        if (error is Failure) {
          return Left(error);
        } else {
          return Left(ServerFailure());
        }
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
