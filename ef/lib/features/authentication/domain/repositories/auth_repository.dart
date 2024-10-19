import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(LoginEntity user);
}
