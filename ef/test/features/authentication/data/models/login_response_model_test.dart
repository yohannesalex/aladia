import 'package:ef/features/authentication/data/model/login_response_model.dart';
import 'package:ef/features/authentication/domain/entity/login_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testLoginModel =
      LoginResponseModel(email: 'user@gmail.com', password: 'abcd1234');
  const testJsonModel = {'email': 'user@gmail.com', 'password': 'abcd1234'};
  test('should be a subclass of login entity', () async {
    expect(testLoginModel, isA<LoginEntity>());
  });
  test('should be return a correct Json model', () async {
    final result = testLoginModel.toJson();
    expect(result, testJsonModel);
  });
}
